//
//  Data.swift
//  MechanicalMonk Watch App
//
//  Created by a.nvlkv on 05/05/2024.
//

import Foundation
import SwiftUI

class MechanicalMonkModel: ObservableObject {
    @Published var hours: Int = 0
    @Published var minutes: Int = 15
    @Published var seconds: Int = 0
    
    @Published var intervalMinutes: Int = 3
    @Published var intervalSeconds: Int = 0
    
    @Published var timer: Timer? = nil
    
    @Published var feedback: Bool = false
    
    
    let feedback_tick = UIImpactFeedbackGenerator(style: .soft)
    let ending_tick = UIImpactFeedbackGenerator(style: .medium)
    
    func scheduleTimer() {
        var interval = intervalMinutes * 60 + intervalSeconds
        
        timer = Timer(timeInterval: 1, repeats: true, block: { t in
            interval -= 1
            
            if interval <= 0 {
                self.feedback_tick.impactOccurred()
                self.timer!.invalidate()
                self.scheduleTimer()
                withAnimation {
                    self.feedback = true
                }
            }
            else {
                withAnimation {
                    self.feedback = false
                }
            }
            
            if self.seconds > 0 {
                self.seconds -= 1
            }
            else if self.minutes > 0 {
                self.minutes -= 1
                self.seconds = 59
            } else if self.hours > 0 {
                self.hours -= 1
                self.minutes = 59
                self.seconds = 59
            }
            else {
                self.timer!.invalidate()
                self.ending_tick.impactOccurred()
            }
        })
        
        RunLoop.main.add(timer!, forMode: .common)
    }
}
