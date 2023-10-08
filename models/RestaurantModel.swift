//
 //  RestaurantModel.swift
 //  Restourant Manager
 //
 //  Created by Jakub Górka on 11/07/2023.
 //

 import Foundation
 import Firebase

 class Restaurant: Identifiable, ObservableObject{

     let id: String
     @Published var name: String = ""
     @Published var employees: [Employee] = []
//     @Published var dayRaports: [DayRaport] = []
     @Published var invoiceManager: [Company] = []
     @Published var userRole: String

     @MainActor
     init(id: String, role: String){//}, name: String) {
         self.id = id
         self.userRole = role
         Task{
             await self.fetchRestaurantData()
             await self.fetchEmployees()
//             await self.fetchDayRaports()
             await self.fetchInvoiceManager()
         }
     }

     
     func startDay(date: Date, ignoreDate: Bool = false) -> Bool{
         
         let dateNow = Date()
         if date.compare(dateNow) == .orderedSame || ignoreDate{
            
             let db = Firestore.firestore()
             
             let raportPath = db.collection("Restaurants").document(self.id).collection("Raports").document(dateToString(date: date))
             
             raportPath.setData([:])
//             raportPath.collection("")
             
             
             
             return true
         }
         else{
             return false
         }
         
     }
     
     func getDayRaport(dayId: String) async -> DayRaport?{
         let db = Firestore.firestore()
         
         do{
             let doc = try await db.collection("Restaurants").document(self.id).collection("Raports").document(dayId).getDocument()
             if doc.exists{
                 return DayRaport(date: dayId, restaurantId: self.id)
             }
             else{
                 return nil
             }
         }
         catch{
             return nil
         }
         
     }
     
     
     func getEmployee(employeeID: String) -> Employee? {

         print(self.employees)

         return self.employees.first { emp in
             emp.id == employeeID
         }
     }

     func deleteEmployee(employeeID: String) async -> Bool{

         let db = Firestore.firestore()
         do{
             try await db.collection("Users").document(employeeID).collection("Restaurants").document(self.id).delete()
             try await db.collection("Restaurants").document(self.id).collection("Employees").document(employeeID).delete()
             return true
         }
         catch{
             print("Error, while trying to delete restaurant from users Restaurants Collection")
             print("Error, while trying to delete user from restaurants Employees Collection")
             return false
         }

     }



     func inviteEmployee(employee: Employee) async -> Bool{

         let db = Firestore.firestore()
         var userGood = false
         var restaurantGood = false
         do{
             try await db.collection("Users").document(employee.id).collection("Restaurants").document(self.id).setData([
                 "role" : "invited"
             ])
             userGood = true
         }
         catch{
             print("Error, while trying to add Restaurant to invited user restaurants list")
         }


         do{
             try await db.collection("Restaurants").document(self.id).collection("Employees").document(employee.id).setData([
                 "role" : "invited",
                 "name" : employee.name,
                 "salary" : employee.salary
             ])
             restaurantGood = true
         }
         catch{
             print("Error, while trying to add user to restaurant employees list")
         }

         if userGood && restaurantGood{
             return true
         }
         else{
             return false
         }
     }

     @MainActor
     func fetchRestaurantData() async{
         let db = Firestore.firestore()
         Task{
             do{
                 let doc = try await db.collection("Restaurants").document(self.id).getDocument()
                 doc.data().map { data in
                     DispatchQueue.main.async {
                                     self.name = data["name"] as? String ?? "missing name"
                                 }

                 }
             }
             catch{
                 print("Error, while trying to fetch restaurant data")
             }
         }
     }

     @MainActor
     func fetchEmployees() async{//} -> Bool{
         let db = Firestore.firestore()
         do{
             let docs = try await db.collection("Restaurants").document(self.id).collection("Employees").getDocuments()
             self.employees = docs.documents.map({ data in
                 return Employee(id: data.documentID, name: data["name"] as? String ?? "name missing", salary: data["salary"] as? String ?? "Salary missing", role: data["role"] as? String ?? "unknown")
             })
 //            return true
         }
         catch{
             print("Error, while fetching employees")
 //            return false
         }
     }

//     @MainActor
//     func fetchDayRaports() async{
//
//     }

     @MainActor
     func fetchInvoiceManager() async{

     }

     func getMonthRaports(){

     }

     func getDayRaport(){

     }

     func getYearRaports(){

     }

 }




 class WorkTime: Identifiable{
     let year: String
     let month: String
     let dat: String
     @Published var startTime: String
     @Published var endTime: String?
     @Published var totalTimeWorked: String?

     init(year: String, month: String, dat: String, startTime: String, endTime: String? = nil, totalTimeWorked: String? = nil) {
         self.year = year
         self.month = month
         self.dat = dat
         self.startTime = startTime
         self.endTime = endTime
         self.totalTimeWorked = totalTimeWorked
     }

 }





 
