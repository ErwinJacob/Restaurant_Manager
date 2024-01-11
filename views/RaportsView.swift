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
    
    @State var errorMsg: String = ""
    
    @State var showDatePicker: Bool = false
    
    var body: some View {
        GeometryReader{ proxy in
            VStack{

                Spacer()
                
                if raport != nil {
                    // Render UI when the raport is available
//                    Text("Raport is available")
                    RaportDayView(restaurant: restaurant, raport: raport!, user: user)
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
                
                Button {
                    showDatePicker = true
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 15)
                            .opacity(0.1)
                            .foregroundColor(Color.primary)
                        Text(formattedDate(raportDay))
                            .foregroundColor(Color.primary)
                            .bold()
                    }
                    .frame(width: proxy.size.width*0.6, height: proxy.size.height*0.075)
                }
                .padding(.bottom, proxy.size.height*0.025)
                .sheet(isPresented: $showDatePicker) {
                    showDatePicker = false
                } content: {
                    VStack{
                        
                        Spacer()
                        
                        DatePicker(
                            selection: $raportDay,
                            in: restaurant.firstIssue!...Date.now,
                            displayedComponents: .date
                        ){
                            Text("Raport from day")
                                .bold()
                        }
                        .datePickerStyle(.graphical) // Optional, use compact style for a smaller picker
                        .labelsHidden()
                        .padding(.horizontal, proxy.size.width*0.15)
                        .padding(.bottom, proxy.size.height*0.025)
                        .onChange(of: raportDay) { newDate in
                            // When DatePicker value changes, refresh the view
                            refreshView()
                        }
                        
                        Spacer()
                        
                        Button {
                            showDatePicker = false
                        } label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 15)
                                    .foregroundColor(Color.green)
                                Text("Zatwierdź")
                                    .foregroundColor(Color.primary)
                                    .bold()
                            }
                        }
                        .frame(width: proxy.size.width*0.6, height: proxy.size.height*0.075)

                        
                        Spacer()
                        
                    }
                }

            }
            .frame(width: proxy.size.width, height: proxy.size.height)
            .onAppear {
                // Initial loading when the view appears
                refreshView()
            }
        }
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        formatter.locale = Locale(identifier: "pl_PL") // Set the locale to Polish
        return formatter.string(from: date)
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

