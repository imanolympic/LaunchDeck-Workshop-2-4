//
//  File.swift
//  TaskDeck
//
//  Created by Theron Mansilla on 10/15/20.
//

import UIKit
import RealmSwift

class Task: Object {
    @objc dynamic var taskDescription: String = ""
    @objc dynamic var isCompleted: Bool = false
    @objc dynamic var dueDate: Date? = nil
}
