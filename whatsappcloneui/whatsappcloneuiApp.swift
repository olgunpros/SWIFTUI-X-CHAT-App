//
//  whatsappcloneuiApp.swift
//  whatsappcloneui
//
//  Created by Olgun ‏‏‎‏‏‎ on 2.03.2024.
//

import SwiftUI
import FirebaseCore

@main
struct whatsappcloneuiApp: App {
    init() {
    FirebaseApp.configure()
            
        }
    var body: some Scene {
        WindowGroup {
            AuthView()
        }
    }
}
