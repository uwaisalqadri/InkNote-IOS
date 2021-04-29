//
//  WritePresenter.swift
//  InkNote-IOS
//
//  Created by Uwais Alqadri on 24/04/21.
//

import SwiftUI
import Combine

class WritePresenter: ObservableObject {
    
    private let repository: NoteRepositoryProtocol
    private var cancellables: Set<AnyCancellable> = []
    
    @Published var note = Note()
    @Published var errorMessage: String = ""
    @Published var isSaved: Bool = false
    
    init(repository: NoteRepositoryProtocol) {
        self.repository = repository
    }
    
    func saveNote(from note: Note) {
        repository.addNote(from: note)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                case .finished:
                    print(completion)
                }
            }, receiveValue: { isSaved in
                self.isSaved = isSaved
                print("note save : \(isSaved)")
            })
            .store(in: &cancellables)
    }
    
    func getNoteDetail(idNote: Int) {
        repository.getNoteDetail(idNote: idNote)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                case .finished:
                    print(completion)
                }
            }, receiveValue: { detailNote in
                print(detailNote)
                self.note = detailNote
            })
            .store(in: &cancellables)
    }
}





