//
//  Tasks.swift
//  Task List
//
//  Created by Roland Doll on 3/2/22.
//

import Foundation
import Alamofire
import SwiftUI


// TODO in this file:
// protocol {new TODO extends FullToDo}
// API Calls {Fetch, Update, Delete}


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
    var completed:Bool
}

struct Nothing: Codable {
    
}




class API {
    func getToDos() async -> [ToDo] {
        let req = AF.request("http://localhost:3000/tasks", method: .get , parameters: nil)
        let todos = try! await req.serializingDecodable([ToDo].self).value
        return todos
    }
    
    func createToDo(_ newToDo: NewToDo) async {
        let req = AF.request("http://localhost:3000/tasks", method: .post, parameters: newToDo, encoder: JSONParameterEncoder.default)
        _ = req.serializingDecodable(Nothing.self, emptyResponseCodes:[201,204,205])
    }
    
    func fetchToDo(toDoID:String) async -> ToDo?{
        let req = AF.request("http://localhost:3000/tasks/\(toDoID)", method: .get)
        let todo = try? await req.serializingDecodable([ToDo].self).value
        guard let todo = todo else {
            return nil
        }
        return todo[0]
    }
    
    func updateToDo(updated:ToDo) async {
        let req = AF.request("http://localhost:3000/tasks/\(updated.id)", method: .put, parameters: updated, encoder: JSONParameterEncoder.default)
        _ = req.serializingDecodable(Nothing.self, emptyResponseCodes: [200])
    }
    
    func deleteToDo(toDoID:String) async {
        let req = AF.request("http://localhost:3000/tasks/\(toDoID)", method: .delete)
        _ = req.serializingDecodable(Nothing.self, emptyResponseCodes: [200])
    }
}


