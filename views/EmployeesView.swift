
import SwiftUI

struct EmployeesView: View {

    @ObservedObject var user: UserData
    @ObservedObject var restaurant: Restaurant
    @State var showAddEmployeeView: Bool = false
    @State private var searchedEmployeeID: String = ""



    var body: some View {
        GeometryReader{ proxy in
            VStack{

                Text("Employees")
                    .bold()
                    .font(.title)
                    .padding(.top, proxy.size.height*0.02)


                ScrollView{
                    ForEach(restaurant.employees){ employee in
                        NavigationLink(destination: EmployeeView(employee: employee)) {
                            EmployeeListView(employee: employee)
                        }
                        .frame(width: proxy.size.width*0.85, height: proxy.size.height*0.15)
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

                Spacer()



            }
            .frame(width: proxy.size.width, height: proxy.size.height*0.9)
            .sheet(isPresented: $showAddEmployeeView) {
                InviteEmployeeView(user: user, restaurant: restaurant)
            }




        }

    }
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
                        .frame(width: proxy.size.height*0.75, height: proxy.size.height*0.75)


                    VStack{
                        Text(employee.name)
                            .bold()
                        Text(employee.id)
                            .font(.footnote)
                    }

                    Spacer()
                }
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
                            await user.findUserByShortenedId(shortenedId: searchedEmployeeID) { result in
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
