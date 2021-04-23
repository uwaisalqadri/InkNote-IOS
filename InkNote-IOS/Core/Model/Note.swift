//
//  Note.swift
//  InkNote-IOS
//
//  Created by Uwais Alqadri on 24/04/21.
//

import Foundation
import RealmSwift

public class Note: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var desc: String = ""
    @objc dynamic var date: String = ""
    @objc dynamic var isRemove: Bool = false
    @objc dynamic var imageUrl: String = ""
    
    public override class func primaryKey() -> String? {
        return "id"
    }
}
