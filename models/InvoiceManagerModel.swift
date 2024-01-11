//
//  InvoiceManagerModel.swift
//  Restourant Manager
//
//  Created by Jakub Górka on 08/08/2023.
//

import Foundation
import Firebase



class Company: Identifiable, ObservableObject{
    
    let name: String // name == id
    @Published var description: String
    @Published var invoices: [Invoice] = []
    
    let restaurantId: String
    
    init(name: String, restaurantId: String, description: String) {
        self.name = name
        self.description = description
        self.restaurantId = restaurantId

//        Task{
//            await self.fetchInvoices(restaurantId: restaurantId)
//        }
    }
    
    func sumInvoices() -> Double{
        
        var sum = 0.0
        
        self.invoices.forEach { inv in
            
            let formattedValue = inv.amount.replacingOccurrences(of: ",", with: ".")
            
            sum += Double(formattedValue) ?? 0
            print(formattedValue)
        }
        
        return sum
    }
    
    @MainActor
    func delInvoice(invoice: Invoice){
        let db = Firestore.firestore()
        
        db.collection("Restaurants").document(self.restaurantId).collection("InvoiceManager").document(self.name).collection(String(invoice.dateOfIssue.dropLast(3))).document(invoice.id).delete()
        self.invoices.forEach { i in
            var counter = 0
            if i.id == invoice.id{
                self.invoices.remove(at: counter)
            }
            else{
                counter += 1
            }
        }
    }
    
    @MainActor
    func addInvoice(dateOfIssue: String, dateOfPaymant: String, invoiceNumber: String, description: String, amount: String, signature: String, image: String) async{
        
        
        let fvMonth = String(dateOfIssue.dropLast(3))
        let newInvoice = Invoice(id: UUID().uuidString, dateOfIssue: dateOfIssue, dateOfPaymant: dateOfPaymant, invoiceNumber: invoiceNumber, description: description, amount: amount, signature: signature, image: image)
        
        self.invoices.append(newInvoice)
        
        let db = Firestore.firestore()
        
        do{
            try await db.collection("Restaurants").document(self.restaurantId).collection("InvoiceManager").document(self.name).collection(fvMonth).document(newInvoice.id).setData([
                "amount": newInvoice.amount,
                "dateOfIssue": newInvoice.dateOfIssue,
                "dateOfPaymant": newInvoice.dateOfPaymant,
                "description": newInvoice.description,
                "invoiceNumber": newInvoice.invoiceNumber,
                "signature": newInvoice.signature,
                "image": newInvoice.image
            ])
        }
        catch{
            print("ERROR, addInvoice")
        }
    }
    
    @MainActor
    func fetchInvoices(month: String, year: String) async -> Double{
        
        let db = Firestore.firestore()
        let companyPath = db.collection("Restaurants").document(self.restaurantId).collection("InvoiceManager").document(self.name).collection(year + "-" + String(format: "%02d", Int(month)!))
        
//        print("m " + String(format: "%02d", Int(month)!))
        print("Wczytano: " + companyPath.path) //test
        
        do{
            self.invoices = try await companyPath.getDocuments().documents.map({ doc in
                print("doc id \(doc.documentID)")
                return Invoice(id: doc.documentID,
                               dateOfIssue: doc["dateOfIssue"] as? String ?? "",
                               dateOfPaymant: doc["dateOfPaymant"] as? String ?? "",
                               invoiceNumber: doc["invoiceNumber"] as? String ?? "",
                               description: doc["description"] as? String ?? "",
                               amount: doc["amount"] as? String ?? "",
                               signature: doc["signature"] as? String ?? "", 
                               image: (doc["image"] as? String ?? errorImg)
                )
            })
            
            return self.sumInvoices()
            
            
        }
        catch{
            return 0.0
        }
                
        
    }
}

class Invoice: Identifiable{
    let id: String
    let dateOfIssue: String
    let dateOfPaymant: String
    let invoiceNumber: String
    let description: String
    let amount: String
    let signature: String
    let image: String
    
    init(id: String, dateOfIssue: String, dateOfPaymant: String, invoiceNumber: String, description: String, amount: String, signature: String, image: String) {
        self.id = id
        self.dateOfIssue = dateOfIssue
        self.dateOfPaymant = dateOfPaymant
        self.invoiceNumber = invoiceNumber
        self.description = description
        self.amount = amount
        self.signature = signature
        self.image = image
    }
    
}


let errorImg = """
"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
"""

