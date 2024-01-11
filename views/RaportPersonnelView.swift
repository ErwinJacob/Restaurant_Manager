//
//  RaportPersonnelView.swift
//  Restaurant Manager
//
//  Created by Jakub Górka on 05/11/2023.
//

import SwiftUI
import PhotosUI

struct RaportPersonnelView: View {
    
    @State var restaurant: Restaurant

    @State var showStartYourDay: Bool = false
    @ObservedObject var raport: DayRaport
    @State var user: UserData
    @State var cameraShow: Bool = false
    
    let datenow = Date()

    
    //camera
    @StateObject var camera: CameraModel = CameraModel(whichCam: AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front)!)
    
    @State private var isLoading: Bool = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @State private var image: UIImage?
    
    var body: some View {
        GeometryReader{ proxy in
            VStack{
                Text("Pracownicy:")
                    .bold()
                    .font(.title)
                    .padding(.top, proxy.size.height*0.05)
                ScrollView{
                    ForEach(raport.workingTimes){ wt in
                        
                        WorkTimeLabel(workTime: wt, restaurant: restaurant, user: user)
                        //.frame(width: proxy.size.width, height: proxy.size.height*0.2)
                    }
                    Button {
                        showStartYourDay = true
                    } label: {
                        VStack{
                            Spacer()
                            Image(systemName: "plus")
                                .resizable()
                                .frame(width: proxy.size.height*0.03, height: proxy.size.height*0.03)
                            Text("Rozpocznij prace")
                                .bold()
                            Spacer()
                        }
                        .foregroundColor(Color.primary)
                    }
                    .disabled(raport.isWorkingNow(userId: user.data!.uid))
                    .frame(width: proxy.size.width*0.85, height: proxy.size.height*0.1)
                    .sheet(isPresented: $showStartYourDay) {
                        showStartYourDay = false
                    } content: {
                        
                        
                        ZStack{
                            CameraPreview(camera: camera)
                                .ignoresSafeArea(.all)
                                .overlay {
                                    if camera.isTaken{
                                    }
                                }
                            
                            VStack{
                                Text("Pracownik: " + user.signature)

                                Text("Czas rozpoczcia pracy: " + dateToTime(date: datenow))
                                
                                Spacer()
                            }
                            .padding(.top, proxy.size.height*0.1)

                            
                            if camera.isTaken {
                                VStack {
                                    Spacer()
                                                                        
                                    HStack {
                                        
                                        ZStack {
                                            // Additional views or overlays
                                        }
                                        .frame(width: proxy.size.width * 0.15, height: proxy.size.width * 0.15)
                                        
                                        Button {
                                            // Save button action
                                            if !camera.isSaved {
                                                isLoading = true
                                                let cameraImg = camera.savePic() // Get image
                                                self.image = cameraImg
                                                
                                                let cameraString = convertImageToBase64String(img: cameraImg)
                                                
                                                //
                                                raport.addPersonnel(imageBlob: cameraString, userId: user.data!.uid, time: datenow)
                                                showStartYourDay = false
                                                
                                            }
                                        } label: {
                                            ZStack {
                                                Capsule()
                                                    .frame(width: proxy.size.width * 0.35, height: proxy.size.width * 0.15)
                                                    .foregroundColor(.white.opacity(0.25))
                                                    .overlay {
                                                        Capsule().stroke(.white, lineWidth: 3)
                                                    }
                                                if isLoading {
                                                    ProgressView()
                                                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                                        .frame(width: proxy.size.width * 0.1, height: proxy.size.width * 0.1)
                                                } else {
                                                    Text(camera.isSaved ? "Zapisano" : "Zapisz zdjęcie")
                                                        .foregroundColor(.white)
                                                }
                                            }
                                        }
                                        .padding(.horizontal, proxy.size.width * 0.05)
                                        
                                        // Retake button
                                        Button {
                                            camera.reTake()
                                        } label: {
                                            ZStack {
                                                Circle()
                                                    .frame(width: proxy.size.width * 0.15, height: proxy.size.width * 0.15)
                                                    .foregroundColor(.white.opacity(0.25))
                                                    .overlay {
                                                        Circle().stroke(.white, lineWidth: 3)
                                                    }
                                                Image(systemName: "camera.rotate")
                                                    .foregroundColor(.white)
                                            }
                                        }
                                    }
                                }
                            } else {
                                VStack {
                                    
//                                    Text("Pracownik: " + user.signature)
//                                        .padding(.top, proxy.size.height*0.1)
//
//                                    Text("Czas rozpoczcia pracy: " + dateToTime(date: datenow))
                                    
                                    Spacer()
                                    
                                    Button {
                                        camera.takePic { img in
                                        }
                                    } label: {
                                        ZStack {
                                            Circle()
                                                .frame(width: proxy.size.width * 0.15)
                                                .foregroundColor(.white.opacity(0.25))
                                                .overlay {
                                                    Circle().stroke(.white, lineWidth: 3)
                                                }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                
//                .frame(width: proxy.size.width, height: proxy.size.height*0.9)

            }
            .frame(width: proxy.size.width, height: proxy.size.height)
            
        }
        .onAppear(perform: {
            camera.checkPerm()
        })
    }
}

struct WorkTimeLabel: View {
    
    @ObservedObject var workTime: WorkTime
    let datenow = Date()
    @State var restaurant: Restaurant
    @State private var showPhoto: Bool = false
    @State var user: UserData
    
    @State var showEdit: Bool = false
    @State var newNote: String = ""
    
    var body: some View {
        
        VStack(alignment: .leading){
            //            VStack(alignment: .leading){
            HStack{
                Spacer()
                Text(restaurant.getEmployeeName(employeeID: workTime.userId) ?? "Missing user name")
                    .font(.title2)
                    .bold()
                Spacer()
            }
            VStack(alignment: .leading){
                HStack{
                    Text("Czas rozpoczęcia pracy: ")
                        .font(.title3)
                        .bold()
                    
                    Text(workTime.startTime)
                        .font(.title3)
                }
                HStack{
                    Text("Czas zakończenia pracy: ")
                        .font(.title3)
                        .bold()
                    
                    if workTime.endTime != ""{
                        Text(workTime.endTime)
                            .font(.title3)
                    }
                    else{
                        Text("Nadal w pracy")
                            .font(.title3)
                    }
                    
                }
                if workTime.note != ""{
                    Text(workTime.note)
                        .font(.footnote)
                }
            }
            .padding(.leading, 20)
            
            
            //            }
            
            
            if workTime.userId == user.data!.uid || restaurant.logedUserRole == "admin"{
                
                Spacer()
                
                HStack{
                    
                    Spacer()
                    
                    
                    Button("Zakończ pracę"){
                        if !workTime.isWorkEnded(){
                            workTime.endWork(restaurantId: restaurant.id)
                        }
                    }
                    
                    Spacer()
                    
                    if restaurant.logedUserRole == "admin"{
                        Button("Edytuj"){
                            showEdit = true
                        }
                    }
                    
                    Spacer()
                    
                    Button("Pokaż zdjęcie"){
                        showPhoto = true
                    }
                    .sheet(isPresented: $showPhoto) {
                        showPhoto = false
                    } content: {
                        Image(uiImage: convertBase64StringToImage(imageBase64String: workTime.photo))
                            .resizable()
                            .scaledToFit()
                    }
                    
                    
                    Spacer()
                    
                }
                
                Spacer()
            }
            
            Divider()
        }
        .foregroundColor(Color.primary)
        //            .frame(width: proxy.size.width, height: proxy.size.height)
        .sheet(isPresented: $showEdit) {
            showEdit = false
        } content: {
            VStack{
                Text(restaurant.getEmployeeName(employeeID: workTime.userId) ?? "Missing user name")
                    .bold()
                    .font(.title)
                
                
                TextField("", text: $workTime.startTime)
                    .frame(width: 200, height: 40)
                    .textFieldStyle(.roundedBorder)
                    .onAppear {
                        newNote = workTime.note + """
                        
                        Zmodyfikowane przez \(user.signature) - \(dateToString(date: Date())) - \(dateToTime(date: Date()))
                        Poprzednia wersja \(workTime.startTime) - \(workTime.endTime)
                        """
                    }
                
//                if workTime.isWorkEnded(){
                    TextField("", text: $workTime.endTime)
                        .frame(width: 200, height: 40)
                        .textFieldStyle(.roundedBorder)
//                }
                    

                
                
                Button("Save"){
                    
                    if ((timeStringToDate(timeString: workTime.startTime) != nil) && !workTime.isWorkEnded()) || ((timeStringToDate(timeString: workTime.startTime) != nil) && (timeStringToDate(timeString: workTime.endTime) != nil)){
                        
                        print(((timeStringToDate(timeString: workTime.startTime) != nil) && !workTime.isWorkEnded()))
                        print(((timeStringToDate(timeString: workTime.startTime) != nil) && (timeStringToDate(timeString: workTime.endTime) != nil)))
                        
                        Task{
                            if workTime.isWorkEnded(){
                                await workTime.modifyWorkTime(restaurantId: restaurant.id, newStartTime: workTime.startTime, newEndTime: workTime.endTime, signature: user.signature, newNote: newNote)
                            }
                            else{
                                await workTime.modifyWorkTime(restaurantId: restaurant.id, newStartTime: workTime.startTime, signature: user.signature, newNote: newNote)
                            }
                        }
                        showEdit = false
                    }
                        
                }
                
            }
        }
    }
}


