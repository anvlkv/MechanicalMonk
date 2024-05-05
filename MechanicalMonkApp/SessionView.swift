//
//  SessionView.swift
//  MechanicalMonk Watch App
//
//  Created by a.nvlkv on 05/05/2024.
//

import SwiftUI

struct SessionView: View {
    @EnvironmentObject var model: MechanicalMonkModel
    
    var body: some View {
        VStack {
            Text("Meditate")
            Spacer()
            let hh = String(format: "%02d", model.hours)
            let mm = String(format: "%02d", model.minutes)
            let ss = String(format: "%02d", model.seconds)
            Text("\(hh):\(mm):\(ss)").font(.title)
            Spacer()
            Circle().frame(width: 3, height: 3).foregroundColor(model.feedback ? Color("AccentColor"):Color.white)
            Spacer()
            Button(action:stopSession) {
                Text("Stop session")
            }
        }
    }
    
    func stopSession() {
        model.timer?.invalidate()
        model.timer = nil
    }
}

struct SessionView_Previews: PreviewProvider {
    static var previews: some View {
        SessionView()
            .environmentObject(MechanicalMonkModel())
    }
}
