//
//  RaportsView.swift
//  Restourant Manager
//
//  Created by Jakub Górka on 05/08/2023.
//

import SwiftUI

struct RaportsView: View {
    

    var body: some View {
        GeometryReader{ proxy in
            VStack{
                Text("Raports View")
                
                Spacer()
            }
            .frame(width: proxy.size.width, height: proxy.size.height)
        }
    }
}

