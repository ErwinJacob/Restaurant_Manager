//
//  ContentView.swift
//  Restourant Manager
//
//  Created by Jakub Górka on 11/07/2023.
//

import SwiftUI

struct ContentView: View {
//
    @ObservedObject var user: UserData = UserData()
    @ObservedObject var view: ViewController = ViewController()
    
    var body: some View {
        
        switch view.view{
        case Views.loginView:
            Login_Page(user: user, view: view)
        case Views.restaurantsList:
            RestaurantListView(user: user, view: view)
        case Views.restaurant:
            RestaurantView(view: view, restaurant: view.restaurant!, user: user)
        default:
            VStack{
                Text("view controller error")
                    .bold()
            }
        }
    }
}

