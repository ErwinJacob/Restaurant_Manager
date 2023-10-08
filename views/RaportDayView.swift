//
//  RaportDayView.swift
//  Restaurant Manager
//
//  Created by Jakub Górka on 27/09/2023.
//

import SwiftUI

struct RaportDayView: View {
    
    @ObservedObject var raport: DayRaport
    
    @State private var showTakings: Bool = false
    @State private var showExpenses: Bool = false
    @State private var showIncomes: Bool = false
    @State private var showWorkingTimes: Bool = false
    
    @State var signature: String

    
    var body: some View {
        GeometryReader{ proxy in
            VStack{
                
                Button {
                    showTakings = true
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundColor(Color.primary)
                            .opacity(0.1)
                        VStack{
                            Text("Takings")
                                .foregroundColor(Color.primary)
                                .bold()
                            Text(getCleanString(value: String(raport.getTopTakings())))
                                .foregroundColor(Color.primary)
                            
                        }
                    }
                }
                .frame(width: proxy.size.width*0.85, height: proxy.size.height*0.2)
                .padding(.vertical, proxy.size.height*0.01)
                .sheet(isPresented: $showTakings, onDismiss: {
                    showTakings = false
                }, content: {
//                    TakingsView(raport: raport, signature: signature)
                    ExpensesView(raport: raport, signature: signature, useCase: "Takings")

                })
            
                
                Button {
                    showExpenses = true
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundColor(Color.primary)
                            .opacity(0.1)
                        VStack{
                            Text("Expenses")
                                .foregroundColor(Color.primary)
                                .bold()
                            Text(String(raport.sumExpenses()))
                                .foregroundColor(Color.primary)

                        }
                    }
                }
                .frame(width: proxy.size.width*0.85, height: proxy.size.height*0.2)
                .padding(.vertical, proxy.size.height*0.01)
                .sheet(isPresented: $showExpenses, onDismiss: {
                    showExpenses = false
                }, content: {
                    ExpensesView(raport: raport, signature: signature, useCase: "Expenses")
                })

                Button {
                    showIncomes = true
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundColor(Color.primary)
                            .opacity(0.1)
                        VStack{
                            Text("Incomes")
                                .foregroundColor(Color.primary)
                                .bold()
                            Text(String(raport.sumIncomes()))
                                .foregroundColor(Color.primary)

                        }
                    }
                }
                .frame(width: proxy.size.width*0.85, height: proxy.size.height*0.2)
                .padding(.vertical, proxy.size.height*0.01)
                .sheet(isPresented: $showIncomes, onDismiss: {
                    showIncomes = false
                }, content: {
                    ExpensesView(raport: raport, signature: signature, useCase: "Incomes")
                })
                
                Button {
                    showWorkingTimes = true
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundColor(Color.primary)
                            .opacity(0.1)
                        VStack{
                            Text("Workers this day")
                                .foregroundColor(Color.primary)
                                .bold()
                            Text(String(raport.sumWorkers()))
                                .foregroundColor(Color.primary)

                        }
                    }
                }
                .frame(width: proxy.size.width*0.85, height: proxy.size.height*0.2)
                .padding(.vertical, proxy.size.height*0.01)
                .sheet(isPresented: $showWorkingTimes, onDismiss: {
                    showWorkingTimes = false
                }, content: {
                    
                })

            }
            .frame(width: proxy.size.width, height: proxy.size.height)
            .padding(.vertical, proxy.size.height*0.025)
        }
    }
}


//
//struct TimePickerView: View {
//    @Binding var selectedTime: Date
//
//    var body: some View {
//        DatePicker("Select a Time", selection: $selectedTime, displayedComponents: [.hourAndMinute])
//    }
//}
