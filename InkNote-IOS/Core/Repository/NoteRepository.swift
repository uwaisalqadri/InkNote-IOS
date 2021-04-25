//
//  NoteRepository.swift
//  InkNote-IOS
//
//  Created by Uwais Alqadri on 25/04/21.
//

import Foundation
import Combine

protocol NoteRepositoryProtocol {
    func getNotes() -> AnyPublisher<[Note], Error>
    
    func addNote(from note: Note) -> AnyPublisher<Bool, Error>
    
    func removeNote(idNote: String) -> AnyPublisher<Bool, Error>
}

final class NoteRepository: NSObject {
    typealias NoteInstance = (LocalDataSource) -> NoteRepository
    
    fileprivate let local: LocalDataSource
    
    private init(local: LocalDataSource) {
        self.local = local
    }
    
    static let sharedInstance: NoteInstance = { localRepo in
        return NoteRepository(local: localRepo)
    }
}

extension NoteRepository: NoteRepositoryProtocol {
    func getNotes() -> AnyPublisher<[Note], Error> {
        return local.getNotes().eraseToAnyPublisher()
    }
    
    func addNote(from note: Note) -> AnyPublisher<Bool, Error> {
        return local.addNote(from: note).eraseToAnyPublisher()
    }
    
    func removeNote(idNote: String) -> AnyPublisher<Bool, Error> {
        return local.removeNote(idNote: idNote).eraseToAnyPublisher()
    }
}
