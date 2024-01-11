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

     @State private var showNewRestaurantAlert: Bool = false
     @State private var newRestaurantName: String = ""
     
     var body: some View {
         GeometryReader{ proxy in
             VStack{
                 
                 HStack{
                     Button {
                         view.changeView(newView: Views.loginView)
                         user.logout()
                         
                     } label: {
                         Image(systemName: "arrowshape.backward.fill")
                             .resizable()
                             .foregroundColor(Color.primary)
                     }
                     .frame(width: proxy.size.height*0.035, height: proxy.size.height*0.035)
                     
                     Spacer()
                     
//                     Text(":)))")
//                         .bold()
//                         .font(.system(size: min(proxy.size.width, proxy.size.height) * 0.075))
                     
                     Spacer()
                     
                     VStack{
                         Button {
                             
                             showNewRestaurantAlert = true
                             
//                             Task{
//                                 if await user.createRestaurant(restaurantName: "Nowa"){
//                                     await user.fetchRestaurants()
//                                 }
//                             }
                         } label: {
                             Image(systemName: "plus")
                                 .resizable()
                                 .foregroundColor(Color.primary)
                         }
                         .frame(width: proxy.size.height*0.035, height: proxy.size.height*0.035)

                     }
                 }
                 .frame(width: proxy.size.width*0.85, height: proxy.size.height*0.05)

                 Spacer()

                 Divider()

                 
                 

                 Spacer()

                 Text("Your restaurants:")
                     .font(.largeTitle)
                     .bold()

                 ScrollView {
                     ForEach(user.restaurants) { restaurant in
                         if restaurant.logedUserRole == "invited"{
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
                     if user.restaurants.isEmpty{
                         Text("Nie należysz do żadnej restauracji")
                             .padding(.top, proxy.size.height*0.1)
                     }
                 }.refreshable{
                     Task{
                         await user.fetchRestaurants()
                     }
                 }



                 Spacer()

                 Text(user.signature + " " + (user.data?.uid ?? ""))
                     .font(.footnote)
             }
             .frame(width: proxy.size.width, height: proxy.size.height)
             
             .alert(
                 Text("Utwórz nową restauracje"),
                 isPresented: $showNewRestaurantAlert
             ) {
                 Button("Anuluj", role: .cancel) {
                     // Handle the acknowledgement.
                     newRestaurantName = ""
                     showNewRestaurantAlert = false
                     
                     
                 }
                 Button("OK") {
                     // Handle the acknowledgement.
                     Task{
                         if await user.createRestaurant(restaurantName: newRestaurantName){
                             await user.fetchRestaurants()
                             showNewRestaurantAlert = false
                             newRestaurantName = ""
                         }
                         else{
                             newRestaurantName = ""
                             showNewRestaurantAlert = false
                         }
                     }
                 }
                 
                 TextField("Nazwa firmy", text: $newRestaurantName)
             } message: {
                 Text("Wpisz nazwę restauracji, którą chcesz utworzyć.")
             }
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
