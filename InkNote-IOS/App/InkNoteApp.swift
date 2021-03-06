//
//  InkNoteApp.swift
//  InkNote-IOS
//
//  Created by Uwais Alqadri on 24/04/21.
//

import SwiftUI
import NavigationStack

@main
struct InkNoteApp: App {
    var body: some Scene {
        WindowGroup {
            let homePresenter = HomePresenter(repository: Injection.init().provideRepository())
            HomeView().environmentObject(homePresenter)
        }
    }
}
