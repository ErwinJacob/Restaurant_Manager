
import SwiftUI

func getFromDate(from date: Date, component: Calendar.Component) -> String {
    let calendar = Calendar.current
    let value = calendar.component(component, from: date)
    return String(format: "%02d", value)
}

struct EmployeesView: View {

    @ObservedObject var user: UserData
    @ObservedObject var restaurant: Restaurant
    @State var showAddEmployeeView: Bool = false
    @State private var searchedEmployeeID: String = ""

    @State var employee: Employee?

    var body: some View {
        GeometryReader{ proxy in
            VStack{

                Text("Pracownicy")
                    .bold()
                    .font(.title)
                    .padding(.top, proxy.size.height*0.02)


                ScrollView{
                    ForEach(restaurant.employees){ emp in
                        Button {
                            employee = emp
                        } label: {
                            NavigationLink(destination: EmployeeView(employee: emp)) {
                                EmployeeListView(employee: emp)
                            }
                            .frame(width: proxy.size.width*0.85, height: proxy.size.height*0.15)
                        }
                    }

                    Button {
                        showAddEmployeeView = true
                    } label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundColor(Color.primary)
                                .opacity(0.15)
                            Image(systemName: "plus")
                                .resizable()
                                .frame(width: proxy.size.height*0.05, height: proxy.size.height*0.05)
                                .foregroundColor(.black)
                        }
                    }
                    .frame(width: proxy.size.width*0.85, height: proxy.size.height*0.15)
                }
                .sheet(item: $employee) {
                    employee = nil
                } content: { emp in
                    EmployeeWorkTimesView(restaurant: restaurant, employee: emp)
                }
                .frame(width: proxy.size.width)

                Spacer()
            }
//            .frame(width: proxy.size.width)
            .sheet(isPresented: $showAddEmployeeView) {
                InviteEmployeeView(user: user, restaurant: restaurant)
            }
        }
    }
}

struct EmployeeWorkTimesView: View {
    
    @State var restaurant: Restaurant
    @State var employee: Employee
    
    @State var workTimeData: [WorkData] = []
    
    //Date picker
//    @State var startDate: Date
    @State var selectedMonthIndex: Int = 0
    @State var selectedYearIndex: Int = 0
    
    let months = ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"]
    
    var years: [String] {
        let startYear = Calendar.current.component(.year, from: restaurant.firstIssue ?? Date())
        let endYear = Calendar.current.component(.year, from: Date())
        
        return Array(startYear...endYear).map { "\($0)" }
    }
        
    var startYear: Int {
        return Calendar.current.component(.year, from: restaurant.firstIssue ?? Date())
    }
    //
    
    var body: some View {
        GeometryReader{ proxy in
            VStack{
                Text(employee.name)
                    .bold()
                    .font(.title2)
                    .padding(.top, proxy.size.height*0.025)
                Text(employee.role)
                    .bold()
                    .font(.footnote)
                Text(employee.salary)
                    .bold()
                    .font(.footnote)


                VStack { //date picker
                    Text("Wybierz miesiąc")
                    HStack {
                        Picker("Month", selection: $selectedMonthIndex) {
                            ForEach(0..<months.count) {
                                Text(self.months[$0])
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    
                    HStack {
                        Picker("Year", selection: $selectedYearIndex) {
                            ForEach(0..<years.count) {
                                Text(self.years[$0])
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                }
                .onAppear {
                    selectedMonthIndex = Calendar.current.component(.month, from: Date()) - 1
                    selectedYearIndex = Calendar.current.component(.year, from: Date()) - startYear
                    
                    Task{
                        await workTimeData = employee.fetchWorkTimes(month: String(selectedMonthIndex+1), year: String(startYear + selectedYearIndex))
                    }
                }
                .padding(.top, proxy.size.height*0.025)
                //end of date picker
                
                
                
                Spacer()
                
                
                if let dateOfFirstIssue = restaurant.firstIssue{
                    
                    
                    //                    employee.fetchWorkTimes(month: String(selectedMonthIndex+1), year: String(startYear + selectedYearIndex))
                    ScrollView{
                        
                        ForEach(workTimeData){ wtd in
                            
                            ZStack{
                                RoundedRectangle(cornerRadius: 15)
                                    .foregroundColor(Color.secondary)
                                    .opacity(0.1)
                                VStack{
                                    Text(wtd.date)
                                    Text(wtd.startTime)
                                    Text(wtd.endTime)
                                    Text(" \(String(convertMinutesToHours(Int(wtd.timeWorked) ?? 0))) h")
                                }
                                .foregroundColor(Color.primary)
                            }
                            .frame(width: proxy.size.width*0.85, height: proxy.size.height*0.15)
                        }
                    }
                    .onChange(of: selectedMonthIndex) { newM in
                        Task{
                            await workTimeData = employee.fetchWorkTimes(month: String(selectedMonthIndex+1), year: String(startYear + selectedYearIndex))
                        }
                    }
                    .onChange(of: selectedYearIndex) { newY in
                        Task{
                            await workTimeData = employee.fetchWorkTimes(month: String(selectedMonthIndex+1), year: String(startYear + selectedYearIndex))
                        }
                    }
                }
                
                Spacer()
                Divider()
                
                Text("Suma przepracowanych godzin: \(String(format: "%.2f", employee.sumWorkTime(workData: workTimeData))) h")
                Text("Suma zarobku za godziny pracy: \(String(format: "%.2f", employee.sumWorkTime(workData: workTimeData)*(Double(employee.salary) ?? 0))) zl")
            }
            .frame(width: proxy.size.width, height: proxy.size.height)
        }
        
    }
//    func getIdToSearch() -> String{
//        return String(startYear + selectedYearIndex) + "-" + String(selectedMonthIndex+1)
//    }
    

    
}



struct EmployeeListView: View{

    @ObservedObject var employee: Employee

    var body: some View{

        GeometryReader{ proxy in
            ZStack{
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(Color.primary)
                    .opacity(0.15)
                HStack{

                    Image(systemName: "person.fill")
//                        .frame(width: proxy.size.height*0.75, height: proxy.size.height*0.75)
                        .padding(.leading, proxy.size.width*0.1)
                        
                    Spacer()

                    VStack{
                        Text(employee.name)
                            .bold()
//                        Text(employee.id)
//                            .font(.footnote)
                    }

                    Spacer()

                    Image(systemName: "chevron.compact.right")
//                        .frame(width: proxy.size.height*0.75, height: proxy.size.height*0.75)
                        .padding(.trailing, proxy.size.width*0.1)

                }
                .foregroundColor(Color.primary)
            }
            .frame(width: proxy.size.width, height: proxy.size.height)
        }

    }
}


struct InviteEmployeeView: View{

    @ObservedObject var user: UserData
    @ObservedObject var restaurant: Restaurant
    @State var searchedEmployeeID: String = ""
    @Environment(\.dismiss) var dismiss


    var body: some View{
        GeometryReader{ proxy in
            VStack {

                Spacer()

                Text("Invite employee")
                    .bold()
                    .font(.title)
                    .padding(.bottom, proxy.size.height*0.05)


                Text("Enter employee ID.")
                Text("You dont have to enter full ID")
                    .font(.footnote)

                TextField("Employee ID", text: $searchedEmployeeID)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: proxy.size.width*0.65, height: proxy.size.height*0.1)
//                        .font(.headline)

                Button {
                    if searchedEmployeeID != ""{
                        Task{
                            await user.findUserByShortenedId(restaurantId: restaurant.id, shortenedId: searchedEmployeeID) { result in
                                    Task{
                                        if await restaurant.inviteEmployee(employee: result){
                                            print("User \(result.name) invited")
                                            await restaurant.fetchEmployees()
                                            dismiss()
                                        }
                                    }
                            }
                        }
                    }
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundColor(Color.green)
//                                .opacity(0.15)
                        Text("Invite")
                            .bold()
                            .font(.title3)
                            .foregroundColor(Color.primary)
                    }
                }
                .frame(width: proxy.size.width*0.55, height: proxy.size.height*0.075)

                Button {
                    //dismiss sheet
                    dismiss()
//                        showAddEmployeeView = false
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundColor(Color.primary)
                            .opacity(0.15)
                        Text("Cancel")
                            .bold()
                            .font(.title3)
                            .foregroundColor(Color.primary)
                    }
                }
                .frame(width: proxy.size.width*0.55, height: proxy.size.height*0.075)



                Spacer()
            }
            .frame(width: proxy.size.width, height: proxy.size.height)
        }
    }
}
