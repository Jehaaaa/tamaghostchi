//
//  ContentView.swift
//  Tamaghostchi3
//
//  Created by Vincent Junior Halim on 17/05/24.
//

import SwiftUI
import CoreMotion

struct ContentView: View {
    let defaults = UserDefaults.standard
    @StateObject private var motionManager = CoreMotionController()
    @State var hungerValue:Double =  0.2
    @State var funValue:Double =  0.2
    @State var coinValue: Double = 0
    var body: some View {
        ZStack {
            
            VStack {
                Status(hungerValue: $hungerValue, funValue: $funValue, coinValue: $coinValue)
                ARViewContainer(funValue: $funValue, coinValue: $coinValue, hungerValue: $hungerValue)
            }
            .onAppear(){
                if(defaults.value(forKey: "hunger") != nil){
                    hungerValue = getHungerValue()
                    funValue = getFunValue()
                    coinValue = getCoinValue()
                }
                DispatchQueue.global().async {
                    
                    while true{
                        if(isTimanging == true){
                            funValue += 0.1
                            isTimanging = false
                        }
                        saveStatus(hungerValue: hungerValue, funValue: funValue, coinValue: coinValue)
                    }
                }
            }
            
            Color(red: 0.2196, green: 0.69, blue: 0.0,opacity: 0.6)
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
            ProgressView(value: hungerValue){
                Image(systemName: "fork.knife")
            }.tint(getStatusBarColor(value: hungerValue))
            
            VStack{
                Image(systemName:"bitcoinsign.circle.fill")
                Text("\(String(format: "₿ %0.02f", coinValue))")
            }.padding()
            //
            ProgressView(value: funValue){
                Image(systemName: "face.smiling.inverse")
            }.tint(getStatusBarColor(value: funValue))
        }.padding()
    }
    
    func getStatusBarColor(value:Double)->Color{
        if(value >= 0.6){
            return Color(.green)
        }
        else if(value >= 0.4 && value<0.6){
            return Color(.yellow)
        }
        else {
            return Color(.red)
        }
    }
}
