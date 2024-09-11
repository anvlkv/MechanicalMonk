//
//  Data.swift
//  MechanicalMonk Watch App
//
//  Created by a.nvlkv on 05/05/2024.
//

import Foundation
import SwiftUI
import HealthKit

class MechanicalMonkModel: NSObject, ObservableObject, WKExtendedRuntimeSessionDelegate {
    func extendedRuntimeSession(_ extendedRuntimeSession: WKExtendedRuntimeSession, didInvalidateWith reason: WKExtendedRuntimeSessionInvalidationReason, error: Error?) {
        switch reason {
        case .expired:
            if self.hours > 0 || self.minutes > 0 || self.seconds > 0 {
                self.startWorkout()
            }
        default:
            break
        }
    }
    
    func extendedRuntimeSessionDidStart(_ extendedRuntimeSession: WKExtendedRuntimeSession) {
        self.scheduleTimer()
    }
    
    func extendedRuntimeSessionWillExpire(_ extendedRuntimeSession: WKExtendedRuntimeSession) {
        self.timer?.invalidate()
        self.timer = nil
    }
    
    @Published var hours: Int = 0
    @Published var minutes: Int = 15
    @Published var seconds: Int = 0
    
    @Published var intervalMinutes: Int = 3
    @Published var intervalSeconds: Int = 0
    
    @Published var timer: Timer? = nil
    
    @Published var feedback: Bool = false
    
    
    let device = WKInterfaceDevice.current()
    var session = WKExtendedRuntimeSession()
    

    // Start the workout.
    func startWorkout() {
        session.delegate = self
        session.start()
    }
    

    // MARK: - Session State Control

    // The app's workout state.
    @Published var running = false

    func togglePause() {
        if running == true {
            self.pause()
        } else {
            resume()
        }
    }

    func pause() {
        session.invalidate()
        timer!.invalidate()
    }

    func resume() {
        session = WKExtendedRuntimeSession()
        session.start()
        scheduleTimer()
    }

    func endWorkout() {
        session.invalidate()
        timer!.invalidate()
        timer = nil
    }
    
    func scheduleTimer() {
        var interval = intervalMinutes * 60 + intervalSeconds
        
        timer = Timer(timeInterval: 1, repeats: true, block: { t in
            interval -= 1
            
            if interval <= 0 {
                self.device.play(.click)
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
                self.device.play(.success)
                self.session.invalidate()
                self.timer = nil;
            }
        })
        
        RunLoop.main.add(timer!, forMode: .common)
    }
}


// MARK: - HKWorkoutSessionDelegate
extension MechanicalMonkModel: HKWorkoutSessionDelegate {
    func workoutSession(_ workoutSession: HKWorkoutSession, didChangeTo toState: HKWorkoutSessionState,
                        from fromState: HKWorkoutSessionState, date: Date) {
        DispatchQueue.main.async {
            self.running = toState == .running
        }

        // Wait for the session to transition states before ending the builder.
        if toState == .ended {
//            builder?.endCollection(withEnd: date) { (success, error) in
//                self.builder?.finishWorkout { (workout, error) in
//                    DispatchQueue.main.async {
//                        self.workout = workout
//                    }
//                }
//            }
        }
    }

    func workoutSession(_ workoutSession: HKWorkoutSession, didFailWithError error: Error) {

    }
}

// MARK: - HKLiveWorkoutBuilderDelegate
extension MechanicalMonkModel: HKLiveWorkoutBuilderDelegate {
    func workoutBuilderDidCollectEvent(_ workoutBuilder: HKLiveWorkoutBuilder) {

    }

    func workoutBuilder(_ workoutBuilder: HKLiveWorkoutBuilder, didCollectDataOf collectedTypes: Set<HKSampleType>) {
//        for type in collectedTypes {
//            guard let quantityType = type as? HKQuantityType else {
//                return // Nothing to do.
//            }
//
//            let statistics = workoutBuilder.statistics(for: quantityType)
//
//            // Update the published values.
//            updateForStatistics(statistics)
//        }
    }
}
