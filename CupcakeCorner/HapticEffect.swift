//
//  HapticEffect.swift
//  CupcakeCorner
//
//  Created by mac on 28/09/2024.
//

//Adding haptic effects

import CoreHaptics
import SwiftUI

struct HapticEffect: View {
    @State private var engine: CHHapticEngine?
    
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {
            return
        }
        
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print(
                "There was an error creating the engine \(error.localizedDescription)"
            )
        }
    }
    
    func complexSuccess() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {
            return
        }
        
        var events = [CHHapticEvent]()
        
        let intensity = CHHapticEventParameter(
            parameterID: .hapticIntensity,
            value: 1
        )
        let sharpness = CHHapticEventParameter(
            parameterID: .hapticSharpness,
            value: 1
        )
        let event = CHHapticEvent(
            eventType: .hapticTransient,
            parameters: [intensity, sharpness],
            relativeTime: 0
        )
        
        events.append(event)
        
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription)")
        }
    }
    
    var body: some View {
        Button("Play Haptic") {
            complexSuccess()
        }
        .onAppear(perform: prepareHaptics)
//        .sensoryFeedback(.increase, trigger: counter) //easy option
    }
}

#Preview {
    HapticEffect()
}
