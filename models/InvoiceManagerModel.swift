//
//  InvoiceManagerModel.swift
//  Restourant Manager
//
//  Created by Jakub Górka on 08/08/2023.
//

import Foundation

//TODO: Przedbudować
/*
 InvoiceManager -> Year -> Month -> Invoice data
 TODO: Always fetch this month only

 Invoice Document:
 company name
 issue date
 paymant date
 (...)
 TODO: Depending on this data perform sorting in Swift Model
 */



class Company: Identifiable, ObservableObject{
    
    let name: String
    @Published var description: String
    @Published var invoices: [Invoice] = []
    
    init(name: String, description: String) {
        self.name = name
        self.description = description
        self.fetchInvoices()
    }
    
    func fetchInvoices(){
        
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
    
    init(id: String, dateOfIssue: String, dateOfPaymant: String, invoiceNumber: String, description: String, amount: String, signature: String) {
        self.id = id
        self.dateOfIssue = dateOfIssue
        self.dateOfPaymant = dateOfPaymant
        self.invoiceNumber = invoiceNumber
        self.description = description
        self.amount = amount
        self.signature = signature
    }
    
}
