//
//  DurationView.swift
//  MechanicalMonk Watch App
//
//  Created by a.nvlkv on 05/05/2024.
//

import SwiftUI

struct DurationView: View {
    @EnvironmentObject var model: MechanicalMonkModel
    
    var body: some View {
        VStack {
            Text("Session duration")
            Spacer()
            HStack {
                Picker("Hours", selection: $model.hours, content: {
                    ForEach(0..<13, content: {val in
                        Text("\(val)").tag(val)
                    })
                })
                Picker("Minutes", selection: $model.minutes, content: {
                    ForEach(1..<60, content: {val in
                        Text("\(val)").tag(val)
                    })
                })
            }
        }
    }
}

struct DurationView_Previews: PreviewProvider {
    static var previews: some View {
        DurationView().environmentObject(MechanicalMonkModel())
    }
}
