//
//  ContentView.swift
//  MechanicalMonk Watch App
//
//  Created by a.nvlkv on 05/05/2024.
//

import SwiftUI
import HealthKit

struct ContentView: View {
    @EnvironmentObject var model: MechanicalMonkModel
    
    var body: some View {
        if model.timer == nil {
            TabView {
                DurationView().tabItem{
                    Text("Duration")
                }
                IntervalView().tabItem {
                    Text("Interval")
                }
                StartSessionView().tabItem{
                    Text("Session")
                }
            }
        }
        else {
            SessionView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(MechanicalMonkModel())
    }
}
