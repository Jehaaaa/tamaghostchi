//
//  FoodView.swift
//  Tamaghostchi3
//
//  Created by Vincent Junior Halim on 20/05/24.
//

import SwiftUI
import ARKit
import RealityKit


struct FoodView: View {
    @Binding var hungerValue:Double
    var body: some View {
        HStack(alignment:.center){
            Food(hungerValue: $hungerValue, food: .CURUT)
            Food(hungerValue: $hungerValue, food: .BUNGA)
            Food(hungerValue: $hungerValue, food: .SAJEN)
            Food(hungerValue: $hungerValue, food: .DUPA)
            Food(hungerValue: $hungerValue, food: .DARAH)
        }
        .frame(width: 1210,height: 110)
        .background(Color(red: 1, green: 1, blue: 1,opacity: 0.3))
    }
}

struct Food: View {
    @Binding var hungerValue:Double
    @State var food: UIImage
    @State var isDragging = false
    @State var position = CGSize.zero
    var body: some View {
        Image(uiImage: food)
            .resizable()
            .scaledToFit()
            .frame(width: 200,height: 100)
            .offset(x: position.width, y: position.height)
            .gesture(
                DragGesture()
                    .onChanged({ value in
                        position = value.translation
                        isDragging = true
                    })
                    .onEnded({ value in
                        position = .zero
                        isDragging = false
                        if(hungerValue <= 1.0){
                            SoundManager.instance.playSound(sound: SoundOptions.eating)
                            hungerValue += 0.1
                        }
                    })
                
            )
    }
}
