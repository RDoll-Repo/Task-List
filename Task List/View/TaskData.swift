//
//  TaskData.swift
//  Task List
//
//  Created by Roland Doll on 3/2/22.
//

import SwiftUI
import Alamofire

struct TaskData: View {
    @State var todos: [ToDo] = []
    
    var body: some View {
        VStack {
            List(todos) { todo in
                VStack {
                    Text(todo.taskDescription)
                        .multilineTextAlignment(.center)
                    Text("Due: " + todo.dueDate)
                        .multilineTextAlignment(.leading)
                    Text("Created: " + todo.createdAt)
                    Text(String(todo.completed))
                }
            }
            .task {
                todos = await API().getToDos()
            }
            Button("New Task"){
                Task {
                    await API().createToDo(NewToDo(taskDescription: "Work appropriate todo", dueDate: "2022-03-06", completed: true))
                }
            }
        }
    }
}

struct TaskData_Previews: PreviewProvider {
    static var previews: some View {
        TaskData()
    }
}
