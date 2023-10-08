//
//  EmployeeView.swift
//  Restourant Manager
//
//  Created by Jakub Górka on 06/08/2023.
//

import SwiftUI

struct EmployeeView: View {
    
    @ObservedObject var employee: Employee
    
    var body: some View {
        Text(employee.name)
    }
}

