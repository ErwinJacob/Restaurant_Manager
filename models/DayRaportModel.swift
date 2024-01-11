//
//  DayRaportModel.swift
//  Restourant Manager
//
//  Created by Jakub Górka on 08/08/2023.
//

import Foundation
import Firebase


func getClosestTime(timeToCheck: Date) -> Date{
    let currentDate = Date()

    // Tworzenie kalendarza
    let calendar = Calendar.current

    // Pobranie komponentów czasu z obiektu Date
    let components = calendar.dateComponents([.hour, .minute], from: currentDate)

    // Pobranie godziny i minut z komponentów
    if let hour = components.hour, let minute = components.minute {
        // Obliczenie pozostałego czasu do najbliższej pełnej kwadransowej godziny
        let remainingMinutes = 15 - (minute % 15)
        
        // Tworzenie nowego obiektu Date z najbliższą pełną kwadransową godziną
        if remainingMinutes > 0 {
            if let nextQuarterHour = calendar.date(byAdding: .minute, value: remainingMinutes, to: currentDate) {
                print("Najbliższa pełna kwadransowa godzina to: \(nextQuarterHour)")
                return nextQuarterHour
            }
        } else {
            // Jeśli jesteś już w pełnej kwadransowej godzinie, to nie trzeba dodawać minut
            print("Jesteś już w pełnej kwadransowej godzinie: \(currentDate)")
            return timeToCheck

        }
        return timeToCheck

    }

    return timeToCheck

}


func czasMiedzyGodzinami(_ godzina1: String, _ godzina2: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm"
    
    guard let date1 = dateFormatter.date(from: godzina1),
          let date2 = dateFormatter.date(from: godzina2) else {
        return "Błąd w formacie godzin"
    }
    
    let calendar = Calendar.current
    let components = calendar.dateComponents([.hour, .minute], from: date1)
    
    // Zaokrąglamy godzinę do najbliższego kwadransa w górę
    let minutes = components.minute ?? 0
    var roundedHour = components.hour ?? 0
    
    if minutes > 0 {
        roundedHour += 1
    }
    
    if roundedHour == 24 {
        roundedHour = 0
    }
    
    // Tworzymy zaokrągloną datę
    let roundedDate = calendar.date(bySettingHour: roundedHour, minute: 0, second: 0, of: date1)
    
    guard let roundedDate = roundedDate else {
        return "Błąd w obliczeniach"
    }
    
    // Obliczamy różnicę czasu między zaokrągloną datą a drugą datą
    let timeDifference = calendar.dateComponents([.hour, .minute], from: roundedDate, to: date2)
    
    let hours = timeDifference.hour ?? 0
    let minutesDifference = timeDifference.minute ?? 0
    
    return String(format: "%02d:%02d", hours, minutesDifference)
}


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

func timeStringToDate(timeString: String) -> Date?{
    
    // Tworzenie obiektu DateFormatter
    let dateFormatter = DateFormatter()

    // Ustalanie formatu czasu w stringu
    dateFormatter.dateFormat = "HH:mm"

    // Próba przekształcenia stringa w obiekt Date
    if let date = dateFormatter.date(from: timeString) {
        return date
    } else {
        return nil
    }
    
}

func convertMinutesToHours(_ minutes: Int) -> Double {
    let hours = Double(minutes) / 60.0
    let roundedHours = round(hours * 4) / 4.0 // Round to the nearest 0.25 hours
    return roundedHours
}

class WorkTime: ObservableObject, Identifiable{
    
    let id: String
    let date: String
    @Published var startTime: String
    @Published var endTime: String = ""
    let userId: String
    let photo: String
    @Published var note: String
    
    init(id: String, startTime: String, endTime: String, userId: String, photo: String, date: String, note: String) {
        self.id = id //"2001-01-01-userid
        self.startTime = startTime
        self.endTime = endTime
        self.userId = userId
        self.photo = photo
        self.date = date
        self.note = note
    }
    
    
    
    func modifyWorkTime(restaurantId: String, newStartTime: String? = nil, newEndTime: String? = nil, signature: String, newNote: String) async{
        
        self.note = newNote
        
        let db = Firestore.firestore()
        
        do{
            
            try await db.collection("Restaurants").document(restaurantId).collection("Raports").document(self.date).collection("Personnel").document(self.id).setData([
                "startTime": self.startTime,
                "endTime": self.endTime,
                "note": newNote
            ], merge: true)

            
            try await db.collection("Restaurants").document(restaurantId).collection("Employees").document(userId).collection("WorkTimes").document(self.id).setData([
                "totalTimeWorked": self.calcWorkTime(),
                "date": self.date,
                "startTime": self.startTime,
                "endTime": self.endTime
            ])
            
            
        }
        catch{
            print("ERROR, while editing work time")
        }
                
    }
    
    
    func isItToday() -> Bool{
        return self.date == dateToString(date: Date())
    }
    
    func calcWorkTime() -> Int{
        
        if self.endTime != ""{
            var startHour = Int(self.startTime.dropLast(3))!
            var startMin = String(self.startTime.dropFirst(3))

            switch Int(startMin)! {
                case 0:
                    startMin = "00"
                case 1..<16:
                    startMin = "15"
                case 16..<31:
                    startMin = "30"
                case 31..<46:
                    startMin = "45"
                case 46..<60:
                startHour += 1
                    if startHour == 24 {
                        startHour = 0
                    }
                    startMin = "00"
                default:
                    print("Error")
            }

            let newStartTime = String(format: "%02d", startHour) + ":" + startMin
            var endHour = String(endTime.dropLast(3))
            var endMin = String(endTime.dropFirst(3))
            
            switch Int(endMin)! {
            case 0..<14:
                endMin = "00"
            case 14..<29:
                endMin = "15"
            case 29..<44:
                endMin = "30"
            case 44..<60:
                endMin = "45"
            default:
                print("Error")
            }
            
            let newEndTime = endHour + ":" + endMin
                        
            
            let startM = (startHour ?? 0) * 60 + (Int(startMin) ?? 0)
            let endM = (Int(endHour) ?? 0) * 60 + (Int(endMin) ?? 0)
            
            let workTimeMin = endM - startM
            let workTimeFunction = timeDifferenceInMinutes(startTime: newStartTime, endTime: String(newEndTime)) ?? 0
            
            print("Czas pracy: \(self.startTime) \(newStartTime) - \(endTime) \(newEndTime) - \(workTimeMin)min - func: \(workTimeFunction) min- \(workTimeMin/60)h")
//            return workTimeMin
            return workTimeFunction

            
        }
        else{
            return 0
        }
        
    }
    
    //
    func timeDifferenceInMinutes(startTime: String, endTime: String) -> Int? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        if let startDate = dateFormatter.date(from: startTime), let endDate = dateFormatter.date(from: endTime) {
            let calendar = Calendar.current
            let components = calendar.dateComponents([.minute], from: startDate, to: endDate)
            
            if let minutes = components.minute {
                return minutes
            }
        }
        
        return nil
    }
    //
    
    func isWorkEnded() -> Bool{
        if self.endTime == nil || self.endTime == ""{
            return false
        }
        else{
            return true
        }
    }
    
    func endWork(restaurantId: String){
        
        if self.isItToday(){
            self.endTime = dateToTime(date: Date())
        }
        else{
            self.endTime = self.startTime
        }
        let db = Firestore.firestore()
                                 
        db.collection("Restaurants").document(restaurantId).collection("Raports").document(self.date).collection("Personnel").document(self.id).setData([
            "endTime": self.endTime
        ], merge: true)

        
        
        db.collection("Restaurants").document(restaurantId).collection("Employees").document(userId).collection("WorkTimes").document(self.id).setData([
            "totalTimeWorked": self.calcWorkTime(),
            "date": self.date,
            "startTime": self.startTime,
            "endTime": self.endTime
        ])
        
    }
}


class DayRaport: ObservableObject, Identifiable{
//    id = "year-month-day"
    let date: Date
    let restaurantId: String
    @Published var takings: [Takings] = []
    @Published var expenses: [Expense] = []
    @Published var incomes: [Income] = []
    @Published var workingTimes: [WorkTime] = [] //TODO: get working times by ID
    
    init(date: String, restaurantId: String) {
        self.restaurantId = restaurantId
        
        if let d = stringToDate(dateString: date){
            self.date = d
            Task{
                await self.fetchIncomes()
                await self.fetchExpenses()
                await self.fetchTakings()
                await self.fetchPersonnel()
            }
        }
        else{
            print("ERROR, while changing string date to Date in DayRaport init")
            self.date = Calendar.current.date(from: DateComponents(year: 2006, month: 8, day: 18))!
        }
    }
    
    
    func fetchPersonnel() async{
        let db = Firestore.firestore()
        
        do{
            try await self.workingTimes = db.collection("Restaurants").document(self.restaurantId).collection("Raports").document(dateToString(date: self.date)).collection("Personnel").getDocuments().documents.map { doc in
                return WorkTime(id: doc.documentID,
                                startTime: doc["startTime"] as? String ?? "",
                                endTime: doc["endTime"] as? String ?? "",
                                userId: doc["userId"] as? String ?? "",
                                photo: doc["photo"] as? String ?? "",
                                date: doc["date"] as? String ?? "",
                                note: doc["note"] as? String ?? ""
                )
            }
            
        }
        catch{
            print("ERROR")
        }
    }
    
    func isWorkingNow(userId: String) -> Bool{
        
        var isWorking = false
        
        self.workingTimes.forEach { wt in
            if wt.userId == userId{
                if wt.endTime == nil || wt.endTime == ""{
                    isWorking = true
                }
            }
                
        }
        
        return isWorking
        
    }
    
    func addPersonnel(imageBlob: String, userId: String, time: Date, endTime: Date? = nil, note: String = ""){
        
        let newId = dateToString(date: time)+"-"+dateToTime(date: time)+"-"+userId
        var newEndTime: String = ""
        if endTime != nil{
            newEndTime = dateToTime(date: endTime!)
        }
        var newWorkTime = WorkTime(id: newId, startTime: dateToTime(date: time), endTime: newEndTime, userId: userId, photo: imageBlob, date: dateToString(date: time), note: note)
        self.workingTimes.append(newWorkTime)
        
        let db = Firestore.firestore()
        db.collection("Restaurants").document(self.restaurantId).collection("Raports").document(dateToString(date: self.date)).collection("Personnel").document(newId).setData([
            "userId": newWorkTime.userId,
            "date": newWorkTime.date,
            "startTime": newWorkTime.startTime,
            "endTime": newWorkTime.endTime,
            "photo": newWorkTime.photo,
            "note": newWorkTime.note
        ])

        
    }
    
    func sumWorkers() -> Int{
        
        var sum: Int = 0
        
        self.workingTimes.forEach { x in
            sum += 1
        }
        
        return sum
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
            sum = round(sum * 100)/100
        }

        return sum
    }    
    
    func sumExpenses() -> Float{
        
        var sum: Float = 0.0
        
        expenses.forEach { x in
            sum += x.getFloat()
            sum = round(sum * 100)/100
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

