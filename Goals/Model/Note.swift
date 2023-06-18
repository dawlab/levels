//
//  Note.swift
//  Goals
//
//  Created by Dawid Łabno on 05/06/2023.
//

import Foundation
import RealmSwift

class Note: Object {
    @Persisted var content: String
    @Persisted var date: Date
    @Persisted var imageData: Data?

    convenience init(content: String, date: Date, imageData: Data? = nil) {
        self.init()
        self.content = content
        self.date = date
        self.imageData = imageData
    }
}

