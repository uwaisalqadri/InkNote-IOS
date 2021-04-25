//
//  Injection.swift
//  InkNote-IOS
//
//  Created by Uwais Alqadri on 24/04/21.
//

import Foundation
import RealmSwift

final class Injection: NSObject {
    
    func provideRepository() -> NoteRepositoryProtocol {
        let realm = try? Realm()
        let local: LocalDataSource = LocalDataSource.sharedInstance(realm)
        return NoteRepository.sharedInstance(local)
    }
}
