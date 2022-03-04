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
    let api = API()
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack {
                ScrollView {
                    ForEach(todos) { todo in
                        ZStack {
                            RoundedRectangle(cornerRadius: 25, style: .continuous)
                                .fill(Color("cards"))
                                .frame(width: 375, height: 100)
                            
                            VStack(alignment: .leading) {
                                Text(todo.taskDescription)
                                Text("Due: " + todo.dueDate)
                                Text("Created: " + todo.createdAt)
                                Text(String(todo.completed))
                            }
                            .onTapGesture(count: 2) {
                                print("Update \(todo.taskDescription)")
                            }
                        }
                    }
                }
                .padding()

                
                
                HStack {
                    Button("+"){
                        Task {
                            await api.createToDo(NewToDo(taskDescription: "Delete This", dueDate: "2022-03-06", completed: true))
                        }
                    }
                    
                    Button("Fetch Task") {
                        Task {
                            guard let currentToDo:ToDo = await API().fetchToDo(toDoID: "d08b6f-a4f8c40f8fa751c")
                            else {print("Task not found");return}
                            
                            print(currentToDo.taskDescription)
                        }
                    }
                    Button("Update Task") {
                        Task {
                            await API().updateToDo(updated: ToDo(id: "c5692bb4-8fd8-4a33-99b0-e8f54eef2f1d", taskDescription: "Get on Bill's Level", dueDate: "2022-12-31", completed: false, createdAt: "2022-03-02"))
                        }
                    }
                    Button("Delete Task") {
                        Task {
                            await API().deleteToDo(toDoID: "8cc025ba-2b0b-4c8b-9912-0ed323b89ee5")
                        }
                    }
                }
            }
            .task {
                todos = await API().getToDos()
            }
        }
        
    }
}

struct TaskData_Previews: PreviewProvider {
    static var previews: some View {
        TaskData()
    }
}
