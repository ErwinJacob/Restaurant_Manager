//
 //  ViewController.swift
 //  The Flower App
 //
 //  Created by Jakub Górka on 18/04/2023.
 //

 import Foundation
 //
 enum Views {
 case loginView
 case restaurantsList
 case restaurant
 }

 class ViewController : Identifiable, ObservableObject{

     @Published var view: Views = Views.loginView
     @Published var restaurant: Restaurant?

     @MainActor
     func changeView(newView: Views){
         self.view = newView
         self.restaurant = nil
     }

     func changeToRestaurantView(restaurant: Restaurant){
         self.view = Views.restaurant
         self.restaurant = restaurant
     }
 }


 enum RestaurantViews {
 case employees
 case raports
 case invoice
 }

 class RestaurantViewController : Identifiable, ObservableObject{

     @Published var view: RestaurantViews = RestaurantViews.raports

     @MainActor
     func changeView(newView: RestaurantViews){
         self.view = newView
     }
 }
