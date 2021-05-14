//
//  LocalDataSource.swift
//  InkNote-IOS
//
//  Created by Uwais Alqadri on 24/04/21.
//

import Foundation
import Combine
import RealmSwift

protocol LocalDataSourceProtocol {
    
    func getNotes() -> AnyPublisher<[Note], Error>
    
    func getNoteDetail(idNote: Int) -> AnyPublisher<Note, Error>
    
    func addNote(from note: Note) -> AnyPublisher<Bool, Error>
    
    func removeNote(idNote: String) -> AnyPublisher<Bool, Error>
    
}

final class LocalDataSource: NSObject {
    private let realm: Realm?
    
    private init(realm: Realm?) {
        self.realm = realm
    }
    
    static let sharedInstance: (Realm?) -> LocalDataSource = {
        realmDatabase in return LocalDataSource(realm: realmDatabase)
    }
}

extension LocalDataSource: LocalDataSourceProtocol {
    
    func getNotes() -> AnyPublisher<[Note], Error> {
        return Future<[Note], Error> { completion in
            if let realm = self.realm {
                let notes: Results<Note> = {
                    realm.objects(Note.self)
                        .sorted(byKeyPath: "id", ascending: false)
                }()
                completion(.success(notes.toArray(ofType: Note.self)))
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func getNoteDetail(idNote: Int) -> AnyPublisher<Note, Error> {
        return Future<Note, Error> { completion in
            if let realm = self.realm {
                let note = realm.object(ofType: Note.self, forPrimaryKey: idNote)
                if realm.isInWriteTransaction {
                    completion(.success(note ?? Note()))
                } else {
                    realm.beginWrite()
                    completion(.success(note ?? Note()))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func addNote(from note: Note) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm {
                do {
                    try realm.safeWrite {
                        realm.create(Note.self, value: note, update: .modified)
                        completion(.success(true))
                    }
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func removeNote(idNote: String) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm {
                if let note = {
                    realm.objects(Note.self).filter("id = \(idNote)")
                }().first {
                    do {
                        try realm.write {
                            realm.delete(note)
                            completion(.success(true))
                        }
                    } catch {
                        completion(.failure(DatabaseError.requestFailed))
                    }
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
}
