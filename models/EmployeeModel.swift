//
//  EmployeeModel.swift
//  Restourant Manager
//
//  Created by Jakub Górka on 08/08/2023.
//

import Foundation
import Firebase

class Employee: Identifiable, ObservableObject{
    let id: String
    let name: String
    let restaurantId: String
    @Published var salary: String
    @Published var role: String
    @Published var workTimes: [WorkTime] = []
    
    init(id: String, name: String, salary: String, role: String, restaurantId: String){
        self.id = id
        self.name = name
        self.salary = salary
        self.role = role
        self.restaurantId = restaurantId
        //        Task{
        //            await self.fetchWorkTimes()
        //        }
    }
    
    func sumWorkTime(workData: [WorkData]) -> Double {
        
        var sum: Double = 0.0
        
        workData.forEach { wd in
            sum += convertMinutesToHours(Int(wd.timeWorked) ?? 0)
        }
        
        return sum
    }
    
    
    func fetchWorkTimes(month: String, year: String) async -> [WorkData] {
        var workTimes: [WorkData] = []
        let db = Firestore.firestore()
        
        let collectionReference = db.collection("Restaurants")
            .document(self.restaurantId)
            .collection("Employees")
            .document(self.id)
            .collection("WorkTimes")
        
        print("restauracja: " + self.restaurantId)
        print("pracownik: " + self.id)
        
        let id = year + "-" + String(format: "%02d", Int(month)!)
        print("termin: " + id)
        
        // Construct the start and end dates for the query
        let startDate = id + "-01"
        let endDate = id + "-31" // You might need to adjust this based on the number of days in the month
        
        // Create a query
        let query = collectionReference
            .whereField("date", isGreaterThanOrEqualTo: startDate)
            .whereField("date", isLessThanOrEqualTo: endDate)
        
        
        
        do {
            //            let querySnapshot = try await query.getDocuments()
            let querySnapshot = try await query.getDocuments()
            
            workTimes = querySnapshot.documents.map { d in
                print(d.documentID)
                return WorkData(id: d.documentID,
                                date: d["date"] as? String ?? "2001-01-01",
                                startTime: d["startTime"] as? String ?? "00:00",
                                endTime: d["endTime"] as? String ?? "00:00",
                                timeWorked: String(d["totalTimeWorked"] as? Int ?? 0)
                )
            }
            
            return workTimes
            
        } catch {
            print("Error in fetchWorkTimes - EmployeeModel: \(error)")
            return workTimes
        }
        
    }
    
}

struct WorkData: Identifiable{
    
    let id: String
    let date: String
    let startTime: String
    let endTime: String
    let timeWorked: String
    
}

    
