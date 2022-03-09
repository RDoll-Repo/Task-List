//
//  TaskViewModel.swift
//  Task List
//
//  Created by Roland Doll on 3/8/22.
//

import Foundation
import SwiftUI

//extension TaskView {
    @MainActor class TaskViewModel: ObservableObject {
        @Published var todos: [ToDo] = []
        @Published var showingUpdate = false
        @Published var showingOptions = false
        let todoApi = API()
        func getAllTodos() async {
            let allTodos = await todoApi.getToDos()
            self.todos = allTodos
        }
    }
//}
