//
//  EmployeeModel.swift
//  Restourant Manager
//
//  Created by Jakub Górka on 08/08/2023.
//

import Foundation

class Employee: Identifiable, ObservableObject{
    let id: String
    let name: String
    @Published var salary: String
    @Published var role: String
    @Published var workTimes: [WorkTime] = []
    
    init(id: String, name: String, salary: String, role: String){
        self.id = id
        self.name = name
        self.salary = salary
        self.role = role
        Task{
            await self.fetchWorkTimes()
        }
    }
    
    func fetchWorkTimes() async{
        
    }
    
    func getEarnings(month: String){
        
    }
    
}
