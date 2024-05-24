//
//  ContentView.swift
//  Tamaghostchi3
//
//  Created by Vincent Junior Halim on 17/05/24.
//

import SwiftUI
import CoreMotion

import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    let defaults = UserDefaults.standard
    @StateObject private var motionManager = CoreMotionController()
    @State var hungerValue:Double =  0.2
    @State var funValue:Double =  0.2
    @State var coinValue: Double = 0
    var body: some View {
        ZStack {
            
//            VStack{
                ARViewContainer(funValue: $funValue, coinValue: $coinValue, hungerValue: $hungerValue)
                .overlay(Status(hungerValue: $hungerValue, funValue: $funValue, coinValue: $coinValue),alignment: .top)
//            }
            .onAppear(){
                if(defaults.value(forKey: "hunger") != nil){
                    hungerValue = getHungerValue()
                    funValue = getFunValue()
                    coinValue = getCoinValue()
                }
                DispatchQueue.global().async {
                    
                    while true{
                        if(isTimanging == true){
                            if(funValue<1){
                                funValue += 0.1
                                
                            }
                            isTimanging = false
                        }
                        saveStatus(hungerValue: hungerValue, funValue: funValue, coinValue: coinValue)
                    }
                }
            }
            
            Color(red: 0.2196, green: 0.69, blue: 0.0,opacity: 0.3)
                .blendMode(.overlay)
                .allowsHitTesting(false)
                .overlay(FoodView(hungerValue: $hungerValue),alignment: .bottom)
            
        }
        .ignoresSafeArea(.all)
        
        
        
    }
}

#Preview {
    ContentView()
}

struct Status: View {
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
