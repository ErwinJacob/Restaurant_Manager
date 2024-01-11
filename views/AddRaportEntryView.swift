

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
                if useCase == "Wydatki"{
                    Text("Dodaj nowy wydatek")
                        .bold()
                        .font(.largeTitle)
                }
                else if useCase == "Wpłaty"{
                    Text("Dodaj nową wpłatę")
                        .bold()
                        .font(.largeTitle)

                }
                else if useCase == "Utarg"{
                    Text("Dodaj aktualny utarg")
                        .bold()
                        .font(.largeTitle)

                }
                else{
                    Text("Błąd")
                        .bold()
                        .font(.largeTitle)
                }
                
                
                DatePicker("Wybierz godzinę", selection: $selectedTime, displayedComponents: [.hourAndMinute])
                    .frame(width: proxy.size.width*0.7)
                
                TextField("Kwota", text: $newValue)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: proxy.size.width*0.5, height: proxy.size.height*0.1)
                
                if useCase == "Wydatki" || useCase == "Wpłaty"{
                    if useCase == "Wydatki"{
                        TextField("Powód wydatku", text: $label)
                            .textFieldStyle(.roundedBorder)
                            .frame(width: proxy.size.width*0.5, height: proxy.size.height*0.1)
                    }
                    else{
                        TextField("Powód wpłaty", text: $label)
                            .textFieldStyle(.roundedBorder)
                            .frame(width: proxy.size.width*0.5, height: proxy.size.height*0.1)
                    }
                    
                    TextField("Opis (opcjonalny)", text: $description)
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
                    
                    if useCase == "Utarg"{
                        raport.addTakings(time: timeString,
                                          value: valueString,
                                          signature: signature)
                    }
                    else if useCase == "Wydatki"{
                        raport.addExpense(signature: signature, value: valueString, description: description, name: label, time: timeString)
                    }
                    else if useCase == "Wpłaty"{
                        raport.addIncome(signature: signature, value: valueString, description: description, name: label, time: timeString)
                    }
                    else{
                        print("ERROR, unknown usage case")
                    }
                    isSheetVisible = false
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: proxy.size.width*0.6, height: proxy.size.height*0.065)
                            .foregroundColor(.green)
                        Text("Potwierdź")
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
