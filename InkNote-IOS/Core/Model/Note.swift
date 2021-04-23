//
//  Note.swift
//  InkNote-IOS
//
//  Created by Uwais Alqadri on 24/04/21.
//

import Foundation

struct Note: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let date: String
    let isRemove: Bool
    let imageUrl: String
}
