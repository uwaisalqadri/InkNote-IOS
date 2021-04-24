//
//  HomeRouter.swift
//  InkNote-IOS
//
//  Created by Uwais Alqadri on 24/04/21.
//

import Foundation
import NavigationStack

class HomeRouter {
    private let navStack: NavigationStack
    
    init(navStack: NavigationStack) {
        self.navStack = navStack
    }
    
    func toWrite() {
        self.navStack.push(WriteView())
    }
}

