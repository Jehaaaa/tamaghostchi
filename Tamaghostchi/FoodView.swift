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
        HStack{
            Food(hungerValue: $hungerValue, food: "birthday.cake.fill")
            Spacer()
            Food(hungerValue: $hungerValue, food: "birthday.cake.fill")
            Spacer()
            Food(hungerValue: $hungerValue, food: "birthday.cake.fill")
        }.padding()
        .background(Color(red: 1, green: 1, blue: 1,opacity: 0.3))
    }
}

struct Food: View {
    @Binding var hungerValue:Double
    @State var food: String
    @State var isDragging = false
    @State var position = CGSize.zero
    var body: some View {
        Image(systemName:food)
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
                        hungerValue += 0.2
                    })
                
            )
    }
}
