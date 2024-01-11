//
//  CompanyInvoicesView.swift
//  Restaurant Manager
//
//  Created by Jakub Górka on 03/12/2023.
//

import SwiftUI
import PhotosUI

struct CompanyInvoicesView: View {
    
    @State var restaurant: Restaurant

    @ObservedObject var company: Company
    @State var signature: String
    
    @State private var showCamera = false

    //add new invoice
    @State var showAddInvoiceView: Bool = false
    
    @State var newInvoiceNr: String = ""
    @State var newInvoiceAmount: String = ""
    @State var newInvoiceDateOfIssue: Date = Date()
    @State var newInvoiceDateOfPaymant: Date = Date()
    @State var newInvoiceDescription: String = ""
    @State var newInvoiceImage: String = ""
//    @State var newInvoiceSignature: String = ""
    
//    @State private var pickerItem: PhotosPickerItem?
//    @State private var pickerItem: UIImage?
    @State private var pickerImage: Image?

    @State private var image: UIImage?
    @StateObject var camera: CameraModel = CameraModel(whichCam: AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)!)
    @State var cameraShow: Bool = false
    @State private var isLoading: Bool = false

    @State var pickedInvoice: Invoice?
//    @State var showPickedImg: Bool = false
    
    var body: some View {
        GeometryReader{ proxy in
            VStack{
                
                Text("Faktury")
                    .font(.title2)
                    .bold()
                    .padding(.vertical, proxy.size.height*0.025)
                
                ScrollView{
                    ForEach(company.invoices){ invoice in
                        
                        Button {
                            pickedInvoice = invoice
//                            pickedImg = invoice.image
//                            pickedImg = Image(uiImage: UIImage(data: Data(base64Encoded: invoice.image, options: .ignoreUnknownCharacters)!)!)
//                            showPickedImg = true
                        } label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 15)
                                    .foregroundColor(Color.primary)
                                    .opacity(0.15)
                                HStack{
                                    
                                    Image(uiImage: UIImage(data: Data(base64Encoded: invoice.image, options: .ignoreUnknownCharacters)!)!)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: proxy.size.width*0.2)
                                        .foregroundColor(.black)
                                    Spacer()
                                    VStack{
                                        Text(invoice.invoiceNumber)
                                            .bold()
                                        Text(invoice.amount)
                                        Text(invoice.dateOfIssue)
                                        Text(invoice.dateOfPaymant)
                                        Text(invoice.description)
                                        Text(invoice.signature)
                                            .font(.footnote)
                                    }
                                    .foregroundColor(.primary)
                                    Spacer()
                                    
                                }
                                .padding(.horizontal, proxy.size.width*0.05)
                            }
                            .frame(width: proxy.size.width*0.85)
                            .frame(minHeight: proxy.size.height*0.2)
                        }
                        
                    }
                    
                    Button {
                        showAddInvoiceView = true
                    } label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundColor(Color.primary)
                                .opacity(0.15)
                            Image(systemName: "plus")
                                .resizable()
                                .frame(width: proxy.size.height*0.05, height: proxy.size.height*0.05)
                                .foregroundColor(.black)
                        }
                    }
                    .frame(width: proxy.size.width*0.85, height: proxy.size.height*0.15)

                }
                .sheet(item: $pickedInvoice) {
//                    showPickedImg = false
                    pickedInvoice = nil
                } content: { inv in
                    ZStack{
                        Image(uiImage: UIImage(data: Data(base64Encoded: inv.image, options: .ignoreUnknownCharacters)!)!)
                            .resizable()
                            .scaledToFit()
                        
                        VStack{
                            Spacer()
                            Button {
                                company.delInvoice(invoice: pickedInvoice!)
                                pickedInvoice = nil
                            } label: {
                                ZStack{
                                    RoundedRectangle(cornerRadius: 20)
                                        .foregroundColor(.red)
                                    Text("Usuń")
                                        .foregroundColor(.white)
                                        .bold()
                                }
                            }
                            .frame(width: proxy.size.width*0.45, height: proxy.size.height*0.06)
                            .disabled(!restaurant.isAdmin())
                        }
                    }
                }

                Spacer()
                Divider()
                Text("Suma: \(String(format: "%.2f", company.sumInvoices())) zł")
                    .padding(.vertical, proxy.size.width*0.025)
            }
            .frame(width: proxy.size.width, height: proxy.size.height)
            .sheet(isPresented: $showAddInvoiceView) {
                showAddInvoiceView = false
            } content: {
                VStack{
                    
                    TextField("Numer faktury", text: $newInvoiceNr)
                        .frame(width: proxy.size.width*0.6, height: proxy.size.height*0.05)
                        .textFieldStyle(.roundedBorder)
                    
                    TextField("Kwota", text: $newInvoiceAmount)
                        .frame(width: proxy.size.width*0.6, height: proxy.size.height*0.05)
                        .textFieldStyle(.roundedBorder)

                    TextField("Notatka", text: $newInvoiceDescription)
                        .frame(width: proxy.size.width*0.6, height: proxy.size.height*0.05)
                        .textFieldStyle(.roundedBorder)
                    
                    DatePicker(selection: $newInvoiceDateOfIssue, in: ...Date.now, displayedComponents: .date) {
                        Text("Data wystawienia faktury")
                    }
                    .frame(width: proxy.size.width*0.85)

                    DatePicker(selection: $newInvoiceDateOfPaymant, displayedComponents: .date) {
                        Text("Data płatności")
                    }
                    .frame(width: proxy.size.width*0.85)

                    
                    Button("Zrób zdjęcie"){
                        showCamera = true
                    }
                    
                    
                    .sheet(isPresented: $showCamera) {
                        showCamera = false
                    } content: {
                        
                        
                        ZStack{
                            CameraPreview(camera: camera)
                                .ignoresSafeArea(.all)
                                .overlay {
                                    if camera.isTaken{
                                    }
                                }
                            
                            

                            
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
                                                pickerImage = Image(uiImage: cameraImg)
                                                
                                                let cameraString = convertImageToBase64String(img: cameraImg)
                                                newInvoiceImage = cameraString
                                                //
//                                                raport.addPersonnel(imageBlob: cameraString, userId: user.data!.uid, time: datenow)
                                                showCamera = false
                                                
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
                    
                    if let pickerImage {
                        pickerImage
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 300)
                        
                    }
                        
                    
                    Button {
                        
                        if newInvoiceImage == ""{
                            newInvoiceImage = (UIImage(systemName: "questionmark")?.jpegData(compressionQuality: 0.1)?.base64EncodedString())!
                        }

                        Task{
                            await company.addInvoice(dateOfIssue: dateToString(date: newInvoiceDateOfIssue), dateOfPaymant: dateToString(date: newInvoiceDateOfPaymant), invoiceNumber: newInvoiceNr, description: newInvoiceDescription, amount: newInvoiceAmount, signature: signature, image: newInvoiceImage)
                            newInvoiceNr = ""
                            newInvoiceImage = ""
                            newInvoiceAmount = ""
                            newInvoiceDescription = ""
                            newInvoiceDateOfIssue = Date()
                            newInvoiceDateOfPaymant = Date()
//                            pickerItem = nil
                            pickerImage = nil
                            showAddInvoiceView = false
                        }
                    } label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundColor(Color.green)
                            Text("Dodaj")
                                .bold()
                                .foregroundColor(.primary)
                        }
                    }
                    .frame(width: proxy.size.width*0.75, height: proxy.size.height*0.075)

                    
                }
            }
            .onAppear(perform: {
                camera.checkPerm()
            })

        }
    }
}

