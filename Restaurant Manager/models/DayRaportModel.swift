//
//  DayRaportModel.swift
//  Restourant Manager
//
//  Created by Jakub Górka on 08/08/2023.
//

import Foundation


class DayRaport: ObservableObject, Identifiable{
    //id = "year-month-day"
    let day: String
    let month: String
    let year: String
    @Published var takings: [Takings] = []
    @Published var expenses: [Expense] = []
    @Published var incomes: [Income] = []
    
    init(day: String, month: String, year: String) {
        self.day = day
        self.month = month
        self.year = year
        self.fetchIncomes()
        self.fetchExpenses()
        self.fetchTakings()
    }
    
    func fetchTakings(){
        
    }
    
    func fetchExpenses(){
        
    }
    
    func fetchIncomes(){
        
    }
    
    func getLatestTakings(){
        
    }
    
    func getTotalIncome(){
        
    }
    
    func getTotalExpenses(){
        
    }

}


class Income: Identifiable{
    let label: String
    let amount: String
    let signature: String
    let description: String //var?
//    let image: String //blob
    
    init(label: String, amount: String, signature: String, description: String) {
        self.label = label
        self.amount = amount
        self.signature = signature
        self.description = description
//        self.image = image
    }
}

class Expense: Identifiable{
    let label: String
    let amount: String
    let signature: String
    let description: String //var?
    let image: String //blob
    
    init(label: String, amount: String, signature: String, description: String, image: String) {
        self.label = label
        self.amount = amount
        self.signature = signature
        self.description = description
        self.image = image
    }
}
