//
//  TaskModel.swift
//  Task List
//
//  Created by Roland Doll on 3/2/22.
//

import Foundation
import Alamofire
import SwiftUI

struct ToDo: Codable, Identifiable {
    var id: String
    var taskDescription: String
    var dueDate: String
    var completed: Bool
    var createdAt: String
}



struct NewToDo: Codable {
    var taskDescription:String
    var dueDate:String
    var completed:Bool = false
}

