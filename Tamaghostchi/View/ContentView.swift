////
////  ContentView.swift
////  Tamaghostchi3
////
////  Created by Vincent Junior Halim on 17/05/24.
////
//
import SwiftUI
import CoreMotion
import CoreImage
import CoreImage.CIFilterBuiltins
// TODO: pecah lagi, biar ContentView kosong
struct ContentView: View {
    let defaults = UserDefaults.standard
    @StateObject private var motionManager = CoreMotionController()
    @State var hungerValue:Double =  0.2
    @State var funValue:Double =  0.2
    @State var coinValue: Double = 0
    @State private var showAlert = false
    var body: some View {
        @State var changeView = false
        
        ZStack {
                ARViewContainer(funValue: $funValue, coinValue: $coinValue, hungerValue: $hungerValue)
                    .overlay(StatusView(hungerValue: $hungerValue, funValue: $funValue, coinValue: $coinValue),alignment: .top)
                    .onAppear(){
                        if(defaults.value(forKey: "hunger") != nil){
                            hungerValue = getHungerValue()
                            funValue = getFunValue()
                            coinValue = getCoinValue()
                        }
                        DispatchQueue.global().async {
                            // TODO: bisa jadi function
                            while true{
                                if(isTimanging == true){
                                    if(funValue<1){
                                        funValue += 0.1
                                        SoundController.instance.playSound(sound: SoundOptions.yay)
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
            if (funValue-0.05 < 0 || hungerValue-0.05 < 0){
                Image(.jumpscare)
                    .resizable()
                    .scaledToFill()
                    .background()
                    .onAppear(){
                        SoundController.instance.playSound(sound: SoundOptions.jumpscare)
    
                        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { timer in
                            showAlert = false
                            funValue = 0.2
                            hungerValue = 0.2
                            coinValue = 0
                            exit(0)
                        }
                    }
            }
        }.ignoresSafeArea(.all)
    }
    
    
}


#Preview {
    ContentView()
}
