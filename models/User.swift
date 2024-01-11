

import Foundation
import SwiftUI
import Firebase
import FirebaseAuth

class UserData: Identifiable, ObservableObject{
    @AppStorage("email") var email = ""
    @AppStorage("password") var password = ""
    @AppStorage("isLogged") var isLogged: Bool = false
    @Published var errorMessage = ""

    @Published var data: User?
    @Published var signature: String = ""
    @Published var restaurants: [Restaurant] = []

    @MainActor
    func fetchData() async -> Bool{

        if let userData = self.data{
            let db = Firestore.firestore()
            do{
                let document = try await db.collection("Users").document(userData.uid).getDocument()
                document.data().map { d in
                    self.signature = d["signature"] as? String ?? ""
                }

                await self.fetchRestaurants()


                return true
            }
            catch{
                print("Error while trying to fetch user data")
                return false
            }
        }
        else{
            return false
        }
    }


    func acceptRestaurantInvite(restaurantID: String) async -> Bool{

        if let userData = self.data{
            let db = Firestore.firestore()

            do{
                try await db.collection("Restaurants").document(restaurantID).collection("Employees").document(userData.uid).setData([
                    "role" : "employee"
                ], merge: true)

                try await db.collection("Users").document(userData.uid).collection("Restaurants").document(restaurantID).setData([
                    "role" : "employee"
                ], merge: true)

                return true
            }
            catch{
                print("Error, while trying to set restaurant invite to accepted")
                return false
            }
        }
        print("Error, missing user data while trying to accept restaurant invite")
        return false

    }

    func findUserByShortenedId(restaurantId: String, shortenedId: String, employee: @escaping (Employee) -> Void) async{

        let db = Firestore.firestore()
        do{
            let docs = try await db.collection("Users").getDocuments()
            docs.documents.forEach { data in
                let checkedId = data.documentID.prefix(shortenedId.count)
                if checkedId == shortenedId{
                    print("Found user: \(data.documentID)")

                    let foundEmployee: Employee = Employee(id: data.documentID, name: data["signature"] as? String ?? "Name missing", salary: "0", role: "", restaurantId: restaurantId)
                    employee(foundEmployee)
                }
            }

//            print("User not found")
//            userId("") //if use wasnt found
            
        }
        catch{
            print("Error while trying ")
        }
    }

    @MainActor
    @Sendable func fetchRestaurants() async -> Bool{
        
        self.restaurants = []
        
        if let userData = self.data{
            let db = Firestore.firestore()
            do{
                let doc = try await db.collection("Users").document(userData.uid).collection("Restaurants").getDocuments()

                self.restaurants = []

//                doc.documents.forEach { data in
//                    Task{
//                        self.restaurants.append(await Restaurant(id: data.documentID))
//                        print(data.documentID)
//                    }
//                }
                

                self.restaurants = doc.documents.map({ data in
                    return Restaurant(id: data.documentID, role: data["role"] as? String ?? "unknown")
                })
                return true
            }
            catch{
                print("Error, while trying to fetch restaurants")
                return false
            }
        }
        else{
            print("Error, while trying to fetch restaurants - missing user data")
            return false
        }
    }

    @MainActor
    func login() async -> Bool{

        do{
            let authDataResult = try await Auth.auth().signIn(withEmail: self.email, password: self.password)
            data = authDataResult.user
            self.isLogged = true
            
            if await self.fetchData(){ 
                return true
            }
            else{
                return false
            }
        }
        catch{
            print("There was an issue when trying to sign in: \(error)")
            self.errorMessage = error.localizedDescription
            return false
        }

    }

    @MainActor
    func register(confirmPassword: String) async -> Bool{
        if (self.email == "" || self.password == ""){
            self.errorMessage = "Pole nie może być puste"
            return false
        }
        else if (self.password != confirmPassword){
            self.errorMessage = "Hasła nie zgadzają się"
            return false
        }
        else{
                //success
            do{
                let authDataResult = try await Auth.auth().createUser(withEmail: self.email, password: self.password)
                data = authDataResult.user
                if await self.addNewUser(){
                    self.isLogged = true
                    return true
                }
                else{
                    return false
                }
            }
            catch{
                print("There was an issue when trying to register: \(error)")
                self.errorMessage = error.localizedDescription
                return false
            }

        }

    }

    func createRestaurant(restaurantName: String) async->Bool{

        if let userData = self.data{
            let restaurantId = UUID().uuidString

            let db = Firestore.firestore()
            do{
                try await db.collection("Restaurants").document(restaurantId).setData(
                    ["name": restaurantName,
                     "firstIssue": dateToString(date: Date())
                    ]
                )

                try await db.collection("Restaurants").document(restaurantId).collection("Employees").document(userData.uid).setData([
                    "role" : "admin",
                    "salary" : "0",
                    "name": self.signature
                ])

                
                try await db.collection("Users").document(userData.uid).collection("Restaurants").document(restaurantId).setData([
                    "role" : "admin"
                ])
                return true
            }
            catch{
                print("Error, while trying to create new restaurant instance")
                return false
            }
        }
        else{
            print("Error, while trying to create restaurant - missing user data")
            return false
        }
    }

    func addNewUser() async -> Bool{
        if let userData = data{
            let db = Firestore.firestore()

            do{
                try await db.collection("Users").document(userData.uid).setData([
                    "signature": self.signature
                ])
            }
            catch{
                return false
            }

            return true
        }
        else{
            print("UserData found to be nil while trying to add new user to db")
            return false
        }
    }

    func logout(){
        do{
            try Auth.auth().signOut()
            self.email = ""
            self.password = ""
            self.errorMessage = ""
            self.isLogged = false
            self.restaurants = []
        }
        catch{
            print("ERROR - logout")
        }
    }

}
