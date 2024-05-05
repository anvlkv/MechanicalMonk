//
//  IntervalView.swift
//  MechanicalMonk Watch App
//
//  Created by a.nvlkv on 05/05/2024.
//

import SwiftUI

struct IntervalView: View {
    @EnvironmentObject var model: MechanicalMonkModel
    
    var body: some View {
        VStack {
            Text("Feedback interval")
            Spacer()
            HStack {
                Picker("Minutes", selection: $model.intervalMinutes, content: {
                    ForEach(1..<61, content: {val in
                        Text("\(val)").tag(val)
                    })
                })
                Picker("Seconds", selection: $model.intervalSeconds, content: {
                    ForEach(0..<60, content: {val in
                        Text("\(val)").tag(val)
                    })
                })
            }
        }
    }
}

struct IntervalView_Previews: PreviewProvider {
    static var previews: some View {
        IntervalView()
            .environmentObject(MechanicalMonkModel())
    }
}
