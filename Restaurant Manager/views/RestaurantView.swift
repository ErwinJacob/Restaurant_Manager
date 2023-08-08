
//  RestaurantView.swift
//  Restourant Manager
//
//  Created by Jakub Górka on 04/08/2023.
//

import SwiftUI

struct RestaurantView: View {

    @ObservedObject var view: ViewController = ViewController()
    @ObservedObject var restaurant: Restaurant
    @ObservedObject var user: UserData
    @State private var searchedUser: String = ""
    @State private var showAlert: Bool = false
    @State private var resultOfSearch: String = ""

    @State var searchedEmployeeID: String = ""

    @ObservedObject private var restaurantViewController: RestaurantViewController = RestaurantViewController()

    var body: some View {
        GeometryReader{ proxy in

            VStack(spacing: 0){

                HStack{
                    Button {
                        view.changeView(newView: Views.restaurantsList)
                    } label: {
                        Image(systemName: "arrowshape.backward.fill")
                            .resizable()
                            .foregroundColor(Color.primary)
//                            .frame(width: proxy.size.height*0.025, height: proxy.size.height*0.025)
                    }
                    .frame(width: proxy.size.height*0.035, height: proxy.size.height*0.035)

                    Spacer()

                    Text(restaurant.name)
                        .bold()
                        .font(.system(size: min(proxy.size.width, proxy.size.height) * 0.075))

                    Spacer()

                    VStack{
                        //
                    }
                    .frame(width: proxy.size.height*0.025, height: proxy.size.height*0.025)


                }
                .frame(width: proxy.size.width*0.85, height: proxy.size.height*0.05)

                Spacer()

                Divider()

                switch restaurantViewController.view{
                case RestaurantViews.employees:

                    EmployeesView(user: user, restaurant: restaurant)
                        .frame(width: proxy.size.width, height: proxy.size.height*0.85)

                case RestaurantViews.raports:
                    RaportsView()
                        .frame(width: proxy.size.width, height: proxy.size.height*0.85)

                case RestaurantViews.invoice:
                    InvoiceManagerView()
                        .frame(width: proxy.size.width, height: proxy.size.height*0.85)

                default:
                    VStack{
                        Text("view controller error")
                            .bold()
                    }
                }

                Divider()
                    .padding(0)
                HStack(spacing: 0){
                    Button {
                        restaurantViewController.changeView(newView: RestaurantViews.employees)
                    } label: {
                        ZStack{
                            Rectangle()
                                .opacity(0)

                            if restaurantViewController.view == RestaurantViews.employees{
                                VStack(spacing: 0){

                                    Image(systemName: "person.2.fill")
                                        .padding(.top, proxy.size.height*0.01)

                                    Spacer()

                                    Text("Employees")
                                        .font(.system(size: min(proxy.size.width, proxy.size.height) * 0.03))

                                    Spacer()

                                }
                                .foregroundColor(.primary)
                            }
                            else{
                                VStack(spacing: 0){

                                    Image(systemName: "person.2.fill")
                                        .padding(.top, proxy.size.height*0.01)

                                    Spacer()

                                    Text("Employees")
                                        .font(.system(size: min(proxy.size.width, proxy.size.height) * 0.03))

                                    Spacer()

                                }
                                .foregroundColor(.primary)
                                .opacity(0.25)
                            }
                        }
                    }
                    .frame(width: proxy.size.width/3)

                    Button {
                        restaurantViewController.changeView(newView: RestaurantViews.raports)
                    } label: {
                        ZStack{
                            Rectangle()
                                .opacity(0)

                            if restaurantViewController.view == RestaurantViews.raports{
                                VStack(spacing: 0){

                                    Image(systemName: "calendar")
                                        .padding(.top, proxy.size.height*0.01)

                                    Spacer()

                                    Text("Raports")
                                        .font(.system(size: min(proxy.size.width, proxy.size.height) * 0.03))

                                    Spacer()

                                }
                                .foregroundColor(.primary)
                            }
                            else{
                                VStack(spacing: 0){

                                    Image(systemName: "calendar")
                                        .padding(.top, proxy.size.height*0.01)

                                    Spacer()

                                    Text("Raports")
                                        .font(.system(size: min(proxy.size.width, proxy.size.height) * 0.03))

                                    Spacer()

                                }
                                .foregroundColor(.primary)
                                .opacity(0.25)
                            }
                        }
                    }
                    .frame(width: proxy.size.width/3)

                    Button {
                        restaurantViewController.changeView(newView: RestaurantViews.invoice)
                    } label: {
                        ZStack{
                            Rectangle()
                                .opacity(0)

                            if restaurantViewController.view == RestaurantViews.invoice{
                                VStack(spacing: 0){

                                    Image(systemName: "doc.fill")
                                        .padding(.top, proxy.size.height*0.01)

                                    Spacer()

                                    Text("Invoices")
                                        .font(.system(size: min(proxy.size.width, proxy.size.height) * 0.03))

                                    Spacer()
                                }
                                .foregroundColor(.primary)
                            }
                            else{
                                VStack(spacing: 0){

                                    Image(systemName: "doc.fill")
                                        .padding(.top, proxy.size.height*0.01)

                                    Spacer()

                                    Text("Invoices")
                                        .font(.system(size: min(proxy.size.width, proxy.size.height) * 0.03))

                                    Spacer()

                                }
                                .foregroundColor(.primary)
                                .opacity(0.25)
                            }
                        }
                    }
                    .frame(width: proxy.size.width/3)


                }
                .frame(width: proxy.size.width, height: proxy.size.height*0.08)
                .padding(.top, 0)
                .padding(.bottom, proxy.size.height*0.02)

            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .navigationTitle(restaurant.name)
    }
}
//            VStack{
//
//                Spacer()
//
//                TextField("user id", text: $searchedUser)
//                    .frame(width: proxy.size.width*0.6)
//                    .textFieldStyle(.roundedBorder)
//
//                Button("Search"){
//                    if searchedUser != ""{
//                        Task{
//                            await user.findUserByShortenedId(shortenedId: searchedUser) { result in
//                                resultOfSearch = result
//                                if result != ""{
//                                    Task{
//                                        if await restaurant.inviteEmployee(userId: result){
//                                            showAlert = true
//                                        }
//                                    }
//                                }
//                            }
//                        }
//                    }
//                }
//                .bold()
//                .alert(isPresented: $showAlert) {
//                    Alert(title: Text("Result of search"),
//                    message: Text(resultOfSearch),
//                    dismissButton: .default(Text("Ok ;p")))
//                }
//
//                Spacer()
//
//                Text(restaurant.id)
//                    .font(.footnote)
//
//                RestaurantNavigationBar(restaurantViewController: restaurantViewController)
//                    .frame(width: proxy.size.width, height: proxy.size.height*0.1)
//            }
//            .frame(width: proxy.size.width, height: proxy.size.height)
//        }
//
//}



/* user searcher
 TextField("user id", text: $searchedUser)
 Button("Search"){
     if searchedUser != ""{
         Task{
             await user.findUserByShortenedId(shortenedId: searchedUser) { result in
                 resultOfSearch = result
                 print(result)
                 showAlert = true
             }
         }
     }
 }
 .alert(isPresented: $showAlert) {
     Alert(title: Text("Result of search"),
     message: Text(resultOfSearch),
     dismissButton: .default(Text("Ok ;p")))
 }
 */
