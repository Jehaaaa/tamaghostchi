//
//  ARViewContainer.swift
//  Tamaghostchi3
//
//  Created by Vincent Junior Halim on 17/05/24.
//


import SwiftUI
import ARKit
import RealityKit

struct ARViewContainer: UIViewRepresentable {
    @Binding var funValue: Double
    @Binding var coinValue: Double
    @Binding var hungerValue: Double
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        //        arView.environment.sceneUnderstanding.options = .occlusion
        arView.environment.background = .cameraFeed(exposureCompensation: 0.3)
        
//        arView.enableTapGesture()
        
        let config = ARWorldTrackingConfiguration()
        config.environmentTexturing = .automatic
        arView.session.run(config)
        
        let model = try! Entity.load(named: "Baby.usdz")
        model.generateCollisionShapes(recursive: true)
        
        let anchor = AnchorEntity(world: [0,0,-5])
        anchor.addChild(model)
        
        arView.scene.anchors.append(anchor)
        
        modelMove(model: model)
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        
    }
    
    func modelMove(model: Entity){
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            model.transform.translation = SIMD3(x: Float.random(in: -5 ... 5), y: 0, z: Float.random(in: -5 ... 5))
            funValue -= 0.05
            coinValue += Double.random(in: 0...0.2)
            hungerValue -= 0.05
            SoundManager.instance.playSound(sound: SoundOptions.coin)
            if (funValue-0.05 >= 0 && hungerValue-0.05 >= 0){
                modelMove(model:model)
            }
        }
    }
}


