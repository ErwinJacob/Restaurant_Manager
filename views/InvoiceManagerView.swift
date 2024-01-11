//
//  InvoiceManagerView.swift
//  Restourant Manager
//
//  Created by Jakub Górka on 05/08/2023.
//

import SwiftUI

struct InvoiceManagerView: View {
    
    @State var restaurant: Restaurant
//    @State var employee: Employee
    @State var signature: String
    
    //add company
    @State var showAddCompanyAlert: Bool = false
    @State var newCompanyName: String = ""
    @State var newCompanyDescription: String = ""
        
    //sheet item
    @State var pickedCompany: Company?
    
    //Date picker
//    @State var startDate: Date
    @State var selectedMonthIndex: Int = 0
    @State var selectedYearIndex: Int = 0
    
    
    @State var sum: Double = 0.00
    
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
                    
                    sum = 0.0

//                    Task{
//                    
//                        restaurant.invoiceManager.forEach { company in
//                            Task{
//                                await sum += company.fetchInvoices(month: String(selectedMonthIndex+1), year: String(startYear + selectedYearIndex))
//                                
//
//                            }
//                        }
//
//                    }
                    
//                    sum = String(sumAllInvoices(restaurant: restaurant))

                }
                .padding(.top)
                //end of date picker
                
                Spacer()
                
                if let dateOfFirstIssue = restaurant.firstIssue{
                    
                    
                    ScrollView{
                        
                        ForEach(restaurant.invoiceManager){ company in
                            
                            Button {
                                pickedCompany = company
                            } label: {
                                ZStack{
                                    RoundedRectangle(cornerRadius: 15)
                                        .foregroundColor(Color.secondary)
                                        .opacity(0.1)
                                    VStack{
                                        Text(company.name)
                                        Text(company.description)
                                            .font(.footnote)
                                    }
                                    .foregroundColor(Color.primary)
                                }
                            }
                            .frame(width: proxy.size.width*0.85, height: proxy.size.height*0.15)
                            
                        }
                        
                        
                        Button {
                            showAddCompanyAlert = true
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
                    .alert(
                        Text("Dodaj firmę"),
                        isPresented: $showAddCompanyAlert
                    ) {
                        Button("Anuluj", role: .cancel) {
                            // Handle the acknowledgement.
                            newCompanyName = ""
                            newCompanyDescription = ""
                        }
                        Button("OK") {
                            // Handle the acknowledgement.
                            Task{
                                await restaurant.addInvoiceCompany(name: newCompanyName, descritpion: newCompanyDescription)
                                newCompanyName = ""
                                newCompanyDescription = ""

                            }

                        }
                        
                        TextField("Nazwa firmy", text: $newCompanyName)
                        TextField("Opis firmy", text: $newCompanyDescription)
                    } message: {
                        Text("Wpisz nazwę oraz opis firmy.")
                    }
                
                    .sheet(item: $pickedCompany, onDismiss: {
                        pickedCompany = nil
                    }, content: { comp in
                        CompanyInvoicesView(restaurant: restaurant, company: comp, signature: signature)
//                        ScrollView{
//                            
//                            ForEach(comp.invoices){ inv in
//                                Text(inv.invoiceNumber)
//                            }
//                            
//                        }
                    })
                    .onChange(of: selectedMonthIndex) { newM in
                        
                        sum = 0.0

                        Task{
                        //TODO: fetch
//                            await restaurant.fetchInvoiceManager(year: String(startYear + selectedYearIndex), month: String(selectedMonthIndex+1))
                            
                            restaurant.invoiceManager.forEach { company in
                                Task{
                                    await sum += company.fetchInvoices(month: String(selectedMonthIndex+1), year: String(startYear + selectedYearIndex))
                                }
                            }
                            
                            
                        }


                    }
                    .onChange(of: selectedYearIndex) { newY in
                        
                        sum = 0.0
                        
                        Task{
                            
                            restaurant.invoiceManager.forEach { company in
                                Task{
                                    await sum += company.fetchInvoices(month: String(selectedMonthIndex+1), year: String(startYear + selectedYearIndex))
                                }
                            }
                            
                        }


                    }
                    
                }
                
                Spacer()
                Divider()

                Text("Suma: \(String(format: "%.2f", sum)) zł")
                    .padding(.vertical, proxy.size.width*0.025)

            }
            .frame(width: proxy.size.width, height: proxy.size.height)
        }
        
    }
}

//func sumAllInvoices(restaurant: Restaurant) -> Double{
//    
//    var sum: Double = 0.0
//
//    restaurant.invoiceManager.forEach { comp in
//        
//        sum += comp.sumInvoices()
//        print(sum)
//        print(comp.sumInvoices())
//        
//    }
//    
//    return sum
//    
//}
