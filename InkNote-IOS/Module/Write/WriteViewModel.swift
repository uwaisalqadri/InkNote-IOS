//
//  WriteViewModel.swift
//  InkNote-IOS
//
//  Created by Uwais Alqadri on 24/04/21.
//

import SwiftUI

class WriteViewModel: ObservableObject {
    @Published var title = "Today is a great day"
    @Published var description = "I love making cookies"
}
