//
 //  AppView.swift
 //  Restourant Manager
 //
 //  Created by Jakub Górka on 26/07/2023.
 //

 import SwiftUI

 struct RestaurantListView: View {

     @ObservedObject var user: UserData
     @ObservedObject var view: ViewController

     var body: some View {
         GeometryReader{ proxy in
             VStack{

                 Button("Add Restaurant"){
                     Task{
                         if await user.createRestaurant(restaurantName: "Nowa"){
                             await user.fetchRestaurants()
                         }
                     }
                 }

                 Spacer()

                 Text("Your restaurants:")
                     .font(.largeTitle)
                     .bold()

                 ScrollView {
                     ForEach(user.restaurants) { restaurant in
                         if restaurant.userRole == "invited"{
                             RestaurantInvitationView(restaurant: restaurant, user: user)
                                 .frame(width: proxy.size.width*0.85, height: proxy.size.height*0.15)
                         }
                         else{
                             Button {
                                 view.changeToRestaurantView(restaurant: restaurant)
                             } label: {
                                 RestaurantButtonView(restaurant: restaurant)
                                     .frame(width: proxy.size.width*0.85, height: proxy.size.height*0.15)
                             }
                         }
                     }
                 }



                 Spacer()

                 Text(user.signature + " " + user.data!.uid)
                     .font(.footnote)
             }
             .frame(width: proxy.size.width, height: proxy.size.height)
         }
     }
 }


 struct RestaurantInvitationView: View{
     @ObservedObject var restaurant: Restaurant
     @ObservedObject var user: UserData

     var body: some View{
         GeometryReader{ proxy in

             ZStack{
                 RoundedRectangle(cornerRadius: 15)
                     .foregroundColor(Color.primary).opacity(0.1)

                 HStack{
                     VStack{

                         Text(restaurant.name)
                             .foregroundColor(.primary)
                             .font(.title3)
                             .bold()

                     }

                     Button {
                         Task{
                             if await user.acceptRestaurantInvite(restaurantID: restaurant.id){
                                 await user.fetchRestaurants()
                             }
                         }
                     } label: {
                         ZStack{
                             RoundedRectangle(cornerRadius: 10)
                                 .frame(width: proxy.size.height*0.3, height: proxy.size.height*0.3)
                                 .foregroundColor(.green)
                             Image(systemName: "checkmark")
                                 .resizable()
                                 .frame(width: proxy.size.height*0.15, height: proxy.size.height*0.15)
                                 .foregroundColor(.black)
                         }
                     }

                     Button {
                         Task{
                             if await restaurant.deleteEmployee(employeeID: user.data!.uid){
                                 await user.fetchRestaurants()
                             }
                         }
                     } label: {
                         ZStack{
                             RoundedRectangle(cornerRadius: 10)
                                 .frame(width: proxy.size.height*0.3, height: proxy.size.height*0.3)
                                 .foregroundColor(.red)
                             Image(systemName: "xmark")
                                 .resizable()
                                 .frame(width: proxy.size.height*0.15, height: proxy.size.height*0.15)
                                 .foregroundColor(.black)
                         }
                     }




                 }
                 .padding(proxy.size.height*0.05)

             }

         }
     }
 }


 struct RestaurantButtonView: View{
     @ObservedObject var restaurant: Restaurant

     var body: some View{
         GeometryReader{ proxy in
             ZStack{
                 RoundedRectangle(cornerRadius: 15)
                     .foregroundColor(Color.primary).opacity(0.1)
                 VStack{
                     Text(restaurant.name)
                         .foregroundColor(.primary)
                         .font(.title3)
                         .bold()
                     Spacer()

                 }
                 .padding(proxy.size.height*0.05)
             }
         }
     }
 }
