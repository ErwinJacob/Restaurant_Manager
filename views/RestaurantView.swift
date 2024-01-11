
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
                    RaportsView(user: user, restaurant: restaurant)
                        .frame(width: proxy.size.width, height: proxy.size.height*0.85)

                case RestaurantViews.invoice:
                    InvoiceManagerView(restaurant: restaurant, signature: user.signature)
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

                                    Text("Pracownicy")
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

                                    Text("Pracownicy")
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

                                    Text("Raporty")
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

                                    Text("Raporty")
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

                                    Text("Faktury")
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

                                    Text("Faktury")
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
