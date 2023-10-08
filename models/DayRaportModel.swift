//
//  DayRaportModel.swift
//  Restourant Manager
//
//  Created by Jakub Górka on 08/08/2023.
//

import Foundation
import Firebase

func getCleanString(value: String) -> String{
    
    var valueString = value.replacingOccurrences(of: ",", with: ".")
    let arr = valueString.split(separator: ".")
    if arr.count == 1{
        valueString.append(".00")
    }
    else if arr.count == 2{
        if arr[1].count == 0{
            valueString.append("00")
        }
        else if arr[1].count == 1{
            valueString.append("0")
        }
        else{
            valueString.removeLast(arr[1].count - 2)
        }
    }
    else{
        print("ERROR")
        valueString = "0.00"
    }

    return valueString
}

func dateToString(date: Date) -> String{
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"

    let dateString = dateFormatter.string(from: date)

    return dateString
}

func dateToTime(date: Date) -> String{
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm"

    let timeString = dateFormatter.string(from: date)

    return timeString
}

func stringToDate(dateString: String) -> Date?{
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"

    if let date = dateFormatter.date(from: dateString) {
        return date
    } else {
        print("ERROR, Invalid string date format")
        return nil
    }
    
}


class DayRaport: ObservableObject, Identifiable{
//    id = "year-month-day"
    let date: Date
    let restaurantId: String
    @Published var takings: [Takings] = []
    @Published var expenses: [Expense] = []
    @Published var incomes: [Income] = []
    @Published var workingHours: [String] = [] //TODO: get working times by ID
    
    init(date: String, restaurantId: String) {
        self.restaurantId = restaurantId
        
        if let d = stringToDate(dateString: date){
            self.date = d
            Task{
                await self.fetchIncomes()
                await self.fetchExpenses()
                await self.fetchTakings()
            }
        }
        else{
            print("ERROR, while changing string date to Date in DayRaport init")
            self.date = Calendar.current.date(from: DateComponents(year: 2006, month: 8, day: 18))!
        }
    }
    
    func sumWorkers() -> Int{
        
        var sum: Int = 0
        
        workingHours.forEach { x in
            sum += 1
        }
        
        return sum
    }

    func getTotalExpenses() -> Float{
        
        var total: Float = 0.0
        
        self.expenses.forEach { e in
            total += Float(e.value) ?? 0.0
        }
        
        return total
    }
    
    func getTotalIncomes() -> Float{
        
        var total: Float = 0.0
        
        self.incomes.forEach { i in
            total += Float(i.value) ?? 0.0
        }
        
        return total

    }
    
    func getTopTakings() -> Float{
        
        var top: Float = 0.0
        
        self.takings.forEach { t in
            if let tks = Float(t.takings){
                if tks > top{
                    top = tks
                }
            }
            else{
                print("ERROR, while trying to get float from \(t.id) \(self.date)")
            }
        }

        return top
    }
    
    
    func sumTakings() -> Float{
        
        var sum: Float = 0.0
        
        takings.forEach { x in
            sum += x.getTakings()
        }

        return sum
    }    
    
    func sumExpenses() -> Float{
        
        var sum: Float = 0.0
        
        expenses.forEach { x in
            sum += x.getFloat()
            
        }

        return sum
    }    
    
    func sumIncomes() -> Float{
        
        var sum: Float = 0.0
        
        incomes.forEach { x in
            sum += x.getFloat()
        }

        return sum
    }
    
    func addTakings(time: String, value: String, signature: String){
        let db = Firestore.firestore()
        db.collection("Restaurants").document(self.restaurantId).collection("Raports").document(dateToString(date: self.date)).collection("Takings").document(time).setData([
            "signature" : signature,
            "value" : value
        ])
        
        self.takings.append(Takings(takings: value, signature: signature, time: time))

    }
    
    func fetchTakings() async{
        let db = Firestore.firestore()
        
        do{
            try await self.takings = db.collection("Restaurants").document(self.restaurantId).collection("Raports").document(dateToString(date: self.date)).collection("Takings").getDocuments().documents.map { doc in
                return Takings(takings: doc["value"] as? String ?? "",
                               signature: doc["signature"] as? String ?? "",
                               time: doc.documentID)
            }
            
        }
        catch{
            print("ERROR")
        }
    }
    
    func fetchExpenses() async{
        let db = Firestore.firestore()
        
        do{
            try await self.expenses = db.collection("Restaurants").document(self.restaurantId).collection("Raports").document(dateToString(date: self.date)).collection("Expenses").getDocuments().documents.map { doc in
                return Expense(label: doc["name"] as? String ?? "",
                               value: doc["value"] as? String ?? "",
                               signature: doc["signature"] as? String ?? "",
                               description: doc["description"] as? String ?? "",
                               id: doc.documentID
                )
            }
            
        }
        catch{
            print("ERROR")
        }

    }
    
    func addExpense(signature: String, value: String, description: String, name: String, time: String){
        let db = Firestore.firestore()
        let newId = UUID().uuidString
        
        db.collection("Restaurants").document(self.restaurantId).collection("Raports").document(dateToString(date: self.date)).collection("Expenses").document(newId).setData([
            "signature" : signature,
            "value" : value,
            "description" : description,
            "name" : name,
            "time" : time
        ])
        
        self.expenses.append(Expense(label: name, value: value, signature: signature, description: description, id: newId))
    }
    
    func fetchIncomes() async{
        let db = Firestore.firestore()
        
        do{
            try await self.incomes = db.collection("Restaurants").document(self.restaurantId).collection("Raports").document(dateToString(date: self.date)).collection("Incomes").getDocuments().documents.map { doc in
                return Income(label: doc["name"] as? String ?? "",
                               value: doc["value"] as? String ?? "",
                               signature: doc["signature"] as? String ?? "",
                               description: doc["description"] as? String ?? "",
                               id: doc.documentID
                )
            }
            
        }
        catch{
            print("ERROR")
        }

    }

    func addIncome(signature: String, value: String, description: String, name: String, time: String){
        let db = Firestore.firestore()
        let newId = UUID().uuidString
        
        db.collection("Restaurants").document(self.restaurantId).collection("Raports").document(dateToString(date: self.date)).collection("Incomes").document(newId).setData([
            "signature" : signature,
            "value" : value,
            "description" : description,
            "name" : name,
            "time" : time
        ])
        
        self.incomes.append(Income(label: name, value: value, signature: signature, description: description, id: newId))

    }
    
}

class Takings: Identifiable{
    let time: String
//    let id: String
    let takings: String
    let signature: String
    
    
    
    init(takings: String, signature: String, time: String) {
        
        self.takings = takings
        self.time = time
        self.signature = signature
    }

    func getTakings() -> Float{
        if let t = Float(self.takings){
            return t
        }
        else{
            print("ERROR")
            return 0
        }
    }
}



class Income: Identifiable{
    let id: String
    let label: String
    let value: String
    let signature: String
    let description: String
//    let image: String //blob
    //let time???
    
    init(label: String, value: String, signature: String, description: String, id: String) {
        self.label = label
        self.value = value
        self.signature = signature
        self.description = description
        self.id = id
//        self.image = image
    }
    
    func getFloat() -> Float{
        if let t = Float(self.value){
            return t
        }
        else{
            print("ERROR")
            return 0
        }
    }
}

class Expense: Identifiable{
    let id: String
    let label: String
    let value: String
    let signature: String
    let description: String
//    let image: String //TODO: blob
//    let time???
    
    init(label: String, value: String, signature: String, description: String, id: String) {
        self.label = label
        self.value = value
        self.signature = signature
        self.description = description
        self.id = id
//        self.image = image
    }
    
    func getFloat() -> Float{
        if let t = Float(self.value){
            return t
        }
        else{
            print("ERROR")
            return 0
        }
    }
}

