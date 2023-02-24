//
// This source file is part of the CS342 2023 Allergy Team Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import SwiftUI


struct CameraApp: App {
    var body: some Scene {
        WindowGroup {
            CameraView()
        }
    }
    
    init() {
        UINavigationBar.applyCustomAppearance()
    }
}

fileprivate extension UINavigationBar {
    static func applyCustomAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}
