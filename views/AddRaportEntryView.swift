

import SwiftUI

struct AddRaportEntryView: View{
    
    @State private var showingTimePicker = false
    @State private var selectedTime = Date()
    @ObservedObject var raport: DayRaport
    @State private var newValue: String = ""
    @State private var description: String = ""
    @State private var label: String = ""
    @State var signature: String
    
    @State var useCase: String
    
    @Binding var isSheetVisible: Bool

    var body: some View{
        GeometryReader{ proxy in
            VStack{
                Text("Add new entry")
                    .bold()
                    .font(.largeTitle)
                
                DatePicker("Select a Time", selection: $selectedTime, displayedComponents: [.hourAndMinute])
                    .frame(width: proxy.size.width*0.7)
                
                TextField("Enter a number", text: $newValue)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: proxy.size.width*0.5, height: proxy.size.height*0.1)
                
                if useCase == "Expenses" || useCase == "Incomes"{
                    TextField("Label", text: $label)
                        .textFieldStyle(.roundedBorder)
                        .frame(width: proxy.size.width*0.5, height: proxy.size.height*0.1)
                    
                    TextField("Description", text: $description)
                        .textFieldStyle(.roundedBorder)
                        .frame(width: proxy.size.width*0.5, height: proxy.size.height*0.1)
                }
                
                Button {
                    //format time
//                    let dateFormatter = DateFormatter()
//                    dateFormatter.dateFormat = "HH:mm"
//                    let timeString = dateFormatter.string(from: selectedTime)
                    
                    //format time
                    let timeString = dateToTime(date: selectedTime)
                    
                    //format value
                    let valueString = getCleanString(value: newValue)
                    
                    if useCase == "Takings"{
                        raport.addTakings(time: timeString,
                                          value: valueString,
                                          signature: signature)
                    }
                    else if useCase == "Expenses"{
                        raport.addExpense(signature: signature, value: valueString, description: description, name: label, time: timeString)
                    }
                    else if useCase == "Incomes"{
                        raport.addIncome(signature: signature, value: valueString, description: description, name: label, time: timeString)
                    }
                    else{
                        print("ERROR, unknown usage case")
                    }
                    isSheetVisible = false
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: proxy.size.width*0.4, height: proxy.size.height*0.1)
                            .foregroundColor(.green)
                        Text("Submit")
                            .bold()
                            .font(.title2)
                            .foregroundStyle(.white)
                    }
                }
            }
            .frame(width: proxy.size.width, height: proxy.size.height)
        }
    }
}
