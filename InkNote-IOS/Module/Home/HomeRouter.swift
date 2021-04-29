//
//  HomeRouter.swift
//  InkNote-IOS
//
//  Created by Uwais Alqadri on 24/04/21.
//

import Foundation
import SwiftUI

class HomeRouter {
    func makeWriteView(for idNote: Int, isEditable: Bool) -> some View {
        let repository = Injection.init().provideRepository()
        let presenter = WritePresenter(repository: repository)
        return WriteView(idNote: idNote, presenter: presenter, isEditable: isEditable)
    }
}

