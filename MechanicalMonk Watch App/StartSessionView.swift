//
//  SessionView.swift
//  MechanicalMonk Watch App
//
//  Created by a.nvlkv on 05/05/2024.
//

import SwiftUI

struct StartSessionView: View {
    @EnvironmentObject var model: MechanicalMonkModel
    
    var body: some View {
        
        VStack {
            Text("Meditate for \(model.hours):\(model.minutes)")
            Spacer()
            Text("Feedback every \(model.intervalMinutes)m \(model.intervalSeconds)s").font(.footnote)
            Spacer()
            Button(action: startSession) {
                Text("Start")
            }.buttonStyle(.borderedProminent)
        }.padding(.top, 15)
    }
    
    func startSession() {
        model.scheduleTimer()
    }
}

struct StartSessionView_Previews: PreviewProvider {
    static var previews: some View {
        StartSessionView()
            .environmentObject(MechanicalMonkModel())
    }
}
