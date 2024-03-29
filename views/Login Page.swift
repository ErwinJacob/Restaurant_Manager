
//  Login Page.swift
//  The Flower App
//
//  Created by Jakub Górka on 25/03/2023.
//


//Users:
//a@a.pl aaaaaa Adamin
//b@b.pl bbbbbb User



import SwiftUI

struct Login_Page: View {
    //
    @State var isLoginActive: Bool = true
    @State var isRegisterActive: Bool = false
    @ObservedObject var user: UserData
    @ObservedObject var view: ViewController
    @State private var passwordRepeat = ""
    @State private var showErrorAlert = false


    var body: some View {
        GeometryReader{ proxy in
            VStack{
                Spacer()
                    HStack(){
                        Spacer()
                        VStack(alignment: .center){


                            HStack(){
                                Button {
                                    isLoginActive = true
                                    isRegisterActive = false
                                } label: {
                                    if isLoginActive{
                                        LoginLabel(text: "Logowanie", textColor: Color(red: 239/265, green: 87/265, blue: 124/265))
                                    }
                                    else{
                                        LoginLabel(text: "Logowanie", textColor: Color(UIColor.label))
                                    }
                                }
                                .padding(.trailing, 15)

                                Button {
                                    isLoginActive = false
                                    isRegisterActive = true
                                } label: {
                                    if isRegisterActive{
                                        LoginLabel(text: "Rejestracja", textColor: Color(red: 239/265, green: 87/265, blue: 124/265))
                                    }
                                    else{
                                        LoginLabel(text: "Rejestracja", textColor: Color(UIColor.label))
                                    }
                                }
                                .padding(.leading, 15)

                            }
                            .padding(.top, proxy.size.height*0.05)


                            Spacer()

                            ZStack{
                                if isLoginActive{
                                    VStack(spacing: 15){
//                                        Text("Zaloguj się :)")
                                        TextField("email", text: $user.email)
                                            .frame(width: proxy.size.width*0.65, height: 30)
                                            .textFieldStyle(.roundedBorder)
                                        SecureField("haslo", text: $user.password)
                                            .frame(width: proxy.size.width*0.65, height: 30)
                                            .textFieldStyle(.roundedBorder)
                                        VStack{
                                        }
                                            .frame(width: proxy.size.width*0.65, height: 30)
                                    }
                                }
                                else{
                                    VStack(spacing: 15){
//                                        Text("Zarejestruj się :)")
                                        TextField("imie naziwsko", text: $user.signature)
                                            .frame(width: proxy.size.width*0.65, height: 30)
                                            .textFieldStyle(.roundedBorder)
                                        TextField("email", text: $user.email)
                                            .frame(width: proxy.size.width*0.65, height: 30)
                                            .textFieldStyle(.roundedBorder)
                                        SecureField("haslo", text: $user.password)
                                            .frame(width: proxy.size.width*0.65, height: 30)
                                            .textFieldStyle(.roundedBorder)
                                        SecureField("powtórz hasło", text: $passwordRepeat)
                                            .frame(width: proxy.size.width*0.65, height: 30)
                                            .textFieldStyle(.roundedBorder)

                                    }
                                }
                            }
                            .frame(width: proxy.size.width*0.85, height: proxy.size.width*0.65)

                            Spacer()

//                            Button("TEST - Log in offline"){
//                                user.restaurants.append(Restaurant(id: "00000", role: "admin"))
//                                view.changeView(newView: Views.restaurantsList)
//
//                            }
                            
                            
                            Button {
                                //login
                                if isLoginActive{
                                    //login handling
                                    Task{
                                        let isgood = await user.login()
                                        if isgood{
                                            view.changeView(newView: Views.restaurantsList)
                                        }
                                        else{
                                            showErrorAlert = true
                                        }
                                    }
                                }
                                else{
                                    //register handling
                                    Task{
                                        let isgood = await user.register(confirmPassword: passwordRepeat)
                                        if isgood{
                                            view.changeView(newView: Views.restaurantsList)
                                        }
                                        else{
                                            showErrorAlert = true
                                        }
                                    }
                                }



                            } label: {
                                ZStack{
                                    RoundedRectangle(cornerRadius: 5)
                                        .frame(width: proxy.size.width*0.30, height: proxy.size.width*0.1)
                                        .foregroundColor(.green)
                                    Text(">")
                                        .foregroundColor(.white)
                                        .bold()
//                                        .font(.title)
                                }
                            }
                            .padding(.bottom, proxy.size.height*0.05)
                            .alert("Błąd", isPresented: $showErrorAlert) {
                                        Button("OK", role: .cancel) { }
                            } message: {
                                Text("Error: \(user.errorMessage)")
                            }


                        }

                        Spacer()
                    }
                Spacer()
            }
            .background(
//                Image("background-transparent")
//                    .resizable()
            )
        }
        .onAppear{
            Task{
                if user.isLogged{
                    let isgood = await user.login()
                    if isgood{
                        view.changeView(newView: Views.restaurantsList)
                    }
                }
            }
        }
    }
}


struct LoginLabel: View {

    @State var text: String
    @State var textColor: Color

    var body: some View {
        Text(text)
            .bold()
            .font(.largeTitle)
            .foregroundColor(textColor)
    }
}
