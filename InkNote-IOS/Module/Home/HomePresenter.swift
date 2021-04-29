//
//  HomePresenter.swift
//  InkNote-IOS
//
//  Created by Uwais Alqadri on 24/04/21.
//

import Foundation
import SwiftUI
import Combine

class HomePresenter: ObservableObject {
    
    private let router = HomeRouter()
    private let repository: NoteRepositoryProtocol
    private var cancellables: Set<AnyCancellable> = []
    
    @Published var notes: [Note] = []
    @Published var errorMessage = ""
    
    init(repository: NoteRepositoryProtocol) {
        self.repository = repository
    }
    
    func getNotes() {
        repository.getNotes()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                case .finished:
                    print("Success")
                }
            }, receiveValue: { notes in
                print("note: \(notes)")
                self.notes = notes
            })
            .store(in: &cancellables)
    }
    
    func removeNote(idNote: String) {
        repository.removeNote(idNote: idNote)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                case .finished:
                    print("Item Removed")
                }
            }, receiveValue: { note in
                print("removed note \(note)")
            })
            .store(in: &cancellables)
    }
    
    func toWriteView<Content: View>(
        for idNote: Int,
        isEdit: Bool,
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(
            destination: router.makeWriteView(for: idNote, isEditable: isEdit)
        ) { content() }
    }
}
