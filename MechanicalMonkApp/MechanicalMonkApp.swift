//
//  MechanicalMonkApp.swift
//  MechanicalMonk Watch App
//
//  Created by a.nvlkv on 05/05/2024.
//

import SwiftUI

@main
struct MechanicalMonkAppApp: App {
    @StateObject var model: MechanicalMonkModel = MechanicalMonkModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(model)
        }
    }
}
