//
//  Note.swift
//  InkNote-IOS
//
//  Created by Uwais Alqadri on 24/04/21.
//

import Foundation
import RealmSwift

public class Note: Object, Identifiable {
    @objc dynamic public var id = 0
    @objc dynamic var title: String = ""
    @objc dynamic var desc: String = ""
    @objc dynamic var date: String = ""
    @objc dynamic var isRemove: Bool = false
    @objc dynamic var imageUrl: String = ""
    
    public override class func primaryKey() -> String? {
        return "id"
    }
    
//    func IncrementaID() -> Int {
//        let realm = try! Realm()
//        if let retNext = realm.objects(Note.self).map{ $0.id }.maxE {
//            return retNext + 1
//        }else {
//            return 1
//        }
//    }
    
    func nextId() -> Int { return (realm?.objects(Note.self).map{$0.id}.max() ?? 0) + 1 }
}
