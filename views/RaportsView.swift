//
//  RaportsView.swift
//  Restourant Manager
//
//  Created by Jakub Górka on 05/08/2023.
//

import SwiftUI

struct RaportsView: View {
    
    @State private var raportDay = Date.now
    @State var user: UserData
    @State var restaurant: Restaurant
    
    @State var raport: DayRaport? = nil
    
    @State var errorMsg: String = ":)"
    
    var body: some View {
        GeometryReader{ proxy in
            VStack{

                if raport != nil {
                    // Render UI when the raport is available
//                    Text("Raport is available")
                    RaportDayView(raport: raport!, signature: user.signature)
                } else {
                    // Render UI when the raport is not available
                    Text("Day not opened yet.")
                    
                    Button {
                        if restaurant.startDay(date: raportDay, ignoreDate: true){
                            refreshView()
                        }
                        else{
                            errorMsg = "Cant open this date"
                        }
                    } label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 15)
                                .frame(width: proxy.size.width*0.4, height: proxy.size.height*0.1)
                                .foregroundColor(.green)
                            Text("Start day")
                                .bold()
                                .font(.title2)
                                .foregroundStyle(.white)
                        }
                    }

                    Text(errorMsg)
                    
                }
                    
                Spacer()
                
                DatePicker(
                    selection: $raportDay,
                    in: Calendar.current.date(from: DateComponents(year: 2023, month: 9, day: 25))!...,
                    displayedComponents: .date
                ){
                    Text("Raport from day")
                        .bold()
                }
                .datePickerStyle(.compact) // Optional, use compact style for a smaller picker
                .padding(.horizontal, proxy.size.width*0.15)
                .padding(.bottom, proxy.size.height*0.025)
                .onChange(of: raportDay) { newDate in
                    // When DatePicker value changes, refresh the view
                    refreshView()
                }
            }
            .frame(width: proxy.size.width, height: proxy.size.height)
            .onAppear {
                // Initial loading when the view appears
                refreshView()
            }
        }
    }
    
    private func refreshView() {
        Task {
            do {
                if let _ = await restaurant.getDayRaport(dayId: dateToString(date: raportDay)) {
                    // Raport exists
                    //                        isRaportAvailable = true
                    
                    raport = DayRaport(date: dateToString(date: raportDay), restaurantId: restaurant.id)
                                        
                } else {
                    // Raport does not exist
                    raport = nil
                    
                }
            }
        }
    }
}

