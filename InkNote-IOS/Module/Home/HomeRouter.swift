//
//  HomeRouter.swift
//  InkNote-IOS
//
//  Created by Uwais Alqadri on 24/04/21.
//

import Foundation
import SwiftUI

class HomeRouter {
    func makeWriteView(for note: Note) -> some View {
        let repository = Injection.init().provideRepository()
        let viewModel = WriteViewModel(repository: repository)
        return WriteView(viewModel: viewModel)
    }
}

