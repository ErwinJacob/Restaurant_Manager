//
//  RaportDayView.swift
//  Restaurant Manager
//
//  Created by Jakub Górka on 27/09/2023.
//

import SwiftUI

struct RaportDayView: View {
    
    @State var restaurant: Restaurant

    @ObservedObject var raport: DayRaport
    
    @State private var showTakings: Bool = false
    @State private var showExpenses: Bool = false
    @State private var showIncomes: Bool = false
    @State private var showWorkingTimes: Bool = false
    
    @State var user: UserData

    
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
                            Text("Utarg")
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
                    ExpensesView(raport: raport, signature: user.signature, useCase: "Utarg")

                })
            
                
                Button {
                    showExpenses = true
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundColor(Color.primary)
                            .opacity(0.1)
                        VStack{
                            Text("Wydatki")
                                .foregroundColor(Color.primary)
                                .bold()
                            Text(getCleanString(value: String(raport.sumExpenses())))
                                .foregroundColor(Color.primary)

                        }
                    }
                }
                .frame(width: proxy.size.width*0.85, height: proxy.size.height*0.2)
                .padding(.vertical, proxy.size.height*0.01)
                .sheet(isPresented: $showExpenses, onDismiss: {
                    showExpenses = false
                }, content: {
                    ExpensesView(raport: raport, signature: user.signature, useCase: "Wydatki")
                })

                Button {
                    showIncomes = true
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundColor(Color.primary)
                            .opacity(0.1)
                        VStack{
                            Text("Wpłaty")
                                .foregroundColor(Color.primary)
                                .bold()
                            Text(getCleanString(value: String(raport.sumIncomes())))
                                .foregroundColor(Color.primary)

                        }
                    }
                }
                .frame(width: proxy.size.width*0.85, height: proxy.size.height*0.2)
                .padding(.vertical, proxy.size.height*0.01)
                .sheet(isPresented: $showIncomes, onDismiss: {
                    showIncomes = false
                }, content: {
                    ExpensesView(raport: raport, signature: user.signature, useCase: "Wpłaty")
                })
                
                Button {
                    showWorkingTimes = true
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundColor(Color.primary)
                            .opacity(0.1)
                        VStack{
                            Text("Pracownicy")
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
                    RaportPersonnelView(restaurant: restaurant, raport: raport, user: user)
                })

            }
            .frame(width: proxy.size.width, height: proxy.size.height)
            .padding(.vertical, proxy.size.height*0.025)
        }
    }
}


