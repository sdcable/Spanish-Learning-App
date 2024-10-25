//
//  LearnSpanishApp.swift
//  LearnSpanish
//
//  Created by IS 543 on 10/10/24.
//

import SwiftUI

@main
struct LearnSpanishApp: App {
    var body: some Scene {
        WindowGroup {
            HomePageView(spanishViewModel : SpanishViewModel())
        }
    }
}
