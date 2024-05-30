//
//  Status.swift
//  Tamaghostchi
//
//  Created by Vincent Junior Halim on 26/05/24.
//

import Foundation
import SwiftUI

// TODO: ganti nama jadi StatusView
struct StatusView: View {
    @Binding var hungerValue: Double
    @Binding var funValue: Double
    @Binding var coinValue: Double
    var body: some View {
        HStack{
            HStack {
                Image(systemName: "fork.knife").colorInvert()
                ProgressView(value: hungerValue)
                    .scaleEffect(y:5)
                    .frame(width: 300)
                    .tint(.white)
            }
            .frame(width: 400)
            .padding()
            
            HStack {
                Image(systemName: "face.smiling.inverse").colorInvert()
                ProgressView(value: funValue)
                    .scaleEffect(y:5)
                    .frame(width: 300)
                    .tint(.white)
                    
            }.frame(width: 400)
            .padding()
                
            HStack{
                Image(systemName:"bitcoinsign.circle.fill").colorInvert()
                Text("\(String(format: "%.02f", coinValue))")
                    .foregroundStyle(.white)
            }.frame(width: 200)
            .padding()
            
        }.frame(width: 1000,height: 75)
        
        
    }
}
