//
//  ExpensesView.swift
//  Restaurant Manager
//
//  Created by Jakub Górka on 08/10/2023.
//

import SwiftUI

struct ExpensesView: View {
    
    @State private var showingTimePicker = false
    @ObservedObject var raport: DayRaport
    @State var signature: String
    
    @State var useCase: String
    
    var body: some View {
        GeometryReader{ proxy in
            VStack{
                Text(useCase)
                    .bold()
                    .font(.title)
                    .padding(.top, proxy.size.height*0.05)
                ScrollView{
                    if useCase == "Utarg"{
                        ForEach(raport.takings){ t in
                            VStack{
                                VStack(alignment: .trailing){
                                    HStack{
                                        Text(t.time)
                                            .font(.title3)
                                            .bold()
                                        Spacer()
                                        Text(t.takings)
                                            .font(.title3)
                                            .bold()
                                    }
                                    Text(t.signature)
                                        .font(.footnote)
                                }
                                .frame(width: proxy.size.width*0.85, height: proxy.size.height*0.1)
                                
                                Divider()
                            }
                        }
                    }
                    else if useCase == "Wydatki"{
                        ForEach(raport.expenses){ e in
                            VStack{
                                VStack(alignment: .trailing){
                                    HStack{
                                        Text(e.label)
                                            .font(.title3)
                                            .bold()
                                        Spacer()
                                        Text(e.value)
                                            .font(.title3)
                                            .bold()
                                    }
                                    HStack{
                                        Text(e.description)
                                            .font(.footnote)
                                        Spacer()
                                        Text(e.signature)
                                            .font(.footnote)
                                    }
                                }
                                .frame(width: proxy.size.width*0.85, height: proxy.size.height*0.1)
                                Divider()
                            }
                        }
                    }
                    else if useCase == "Wpłaty"{
                        ForEach(raport.incomes){ i in
                            VStack{
                                VStack(alignment: .trailing){
                                    HStack{
                                        Text(i.label)
                                            .font(.title3)
                                            .bold()
                                        Spacer()
                                        Text(i.value)
                                            .font(.title3)
                                            .bold()
                                    }
                                    HStack{
                                        Text(i.description)
                                            .font(.footnote)
                                        Spacer()
                                        Text(i.signature)
                                            .font(.footnote)
                                    }
                                }
                                .frame(width: proxy.size.width*0.85, height: proxy.size.height*0.1)
                                
                                Divider()
                            }
                        }
                    }
                    else{
                        
                    }
                    Button {
                        showingTimePicker = true
                    } label: {
                        VStack{
                            Image(systemName: "plus")
                                .resizable()
                                .frame(width: proxy.size.height*0.03, height: proxy.size.height*0.03)
                            Text("Dodaj")
                                .bold()
                        }
                        .foregroundColor(Color.primary)
                    }
                    .frame(width: proxy.size.width*0.85, height: proxy.size.height*0.1)
                    .sheet(isPresented: $showingTimePicker) {
                        showingTimePicker = false
                    } content: {
                        AddRaportEntryView(raport: raport, signature: signature, useCase: useCase, isSheetVisible: $showingTimePicker)
                    }
                }
                
                Spacer()
                
                if useCase == "Utarg"{
                    ExpensesSumBarView(label: "Utarg:", value: getCleanString(value: String(raport.getTopTakings())))
                        .frame(width: proxy.size.width, height: proxy.size.height*0.1)
                }
                else if useCase == "Wydatki"{
                    ExpensesSumBarView(label: "Suma wydatków:", value: getCleanString(value: getCleanString(value: String(raport.sumExpenses()))))
                        .frame(width: proxy.size.width, height: proxy.size.height*0.1)

                }
                else if useCase == "Wpłaty"{
                    ExpensesSumBarView(label: "Suma wpłat:", value: getCleanString(value: getCleanString(value: String(raport.sumIncomes()))))
                        .frame(width: proxy.size.width, height: proxy.size.height*0.1)

                }
                else{
                    
                }
            }
        }
    }
}

struct ExpensesSumBarView: View {
    
    @State var label: String
    @State var value: String

    var body: some View {
        GeometryReader{ proxy in
            VStack{
                Divider()
                
                HStack{
                    Text(label)
//                    Spacer()
                    Text(value)
                }
                .padding(.horizontal, proxy.size.width*0.05)
                .bold()
                .font(.title2)

            }
            .frame(width: proxy.size.width, height: proxy.size.height)
        }
    }
}
