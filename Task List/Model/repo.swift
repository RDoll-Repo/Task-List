//
//  repo.swift
//  Task List
//
//  Created by Roland Doll on 3/8/22.
//

import Foundation
import Alamofire

struct Nothing: Codable {
    
}

protocol repo {
    func getToDos() async -> [ToDo]
    func createToDo(_ newToDo: NewToDo) async
    func fetchToDo(toDoID:String) async -> ToDo?
    func updateToDo(updated:ToDo) async
    func deleteToDo(toDoID:String) async
}


class API:repo {
    func getToDos() async -> [ToDo] {
        let req = AF.request("http://localhost:3000/tasks", method: .get , parameters: nil)
        let todos = try! await req.serializingDecodable([ToDo].self).value
        return todos
    }
    
    func createToDo(_ newToDo: NewToDo) async {
        let req = AF.request("http://localhost:3000/tasks", method: .post, parameters: newToDo, encoder: JSONParameterEncoder.default)
        _ = try? await req.serializingDecodable(Nothing.self, emptyResponseCodes:[201,204,205]).value
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
        _ = try? await req.serializingDecodable(Nothing.self, emptyResponseCodes: [200]).value
    }
    
    func deleteToDo(toDoID:String) async {
        let req = AF.request("http://localhost:3000/tasks/\(toDoID)", method: .delete)
        _ = try? await req.serializingDecodable(Nothing.self, emptyResponseCodes: [200]).value
    }
}
