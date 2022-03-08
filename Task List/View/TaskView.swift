//
//  TaskData.swift
//  Task List
//
//  Created by Roland Doll on 3/2/22.
//

import SwiftUI
import Alamofire

struct TaskView: View {
    @State var todos: [ToDo] = []
    @State private var showingUpdate = false
    @State private var showingOptions = false
    public let api = API()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black
                    .ignoresSafeArea()
                VStack {
                    HStack {
                        Button {
                            showingUpdate.toggle()
                        } label: {
                            Image(systemName: "plus.circle")
                        }
                        .sheet(isPresented: $showingUpdate) {
                            UpdateView(todo:ToDo(id:"",taskDescription: "",dueDate: "",completed: false,createdAt: ""),
                                       due: Date(),
                                       EditType: "Create")
                        }
                        Button {
                            showingOptions.toggle()
                        } label: {
                            Image(systemName: "list.bullet")
                        }
                        .sheet(isPresented: $showingOptions) {
                            OptionsView()
                        }
                    }
                    .navigationTitle("Tasks")
                    ScrollView {
                        ForEach(todos) { todo in
                            Cards(todo: todo)
                        }
                    }
                }
                .task {
                    todos = await api.getToDos()
                }
            }
        }
    }
}


struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView()
    }
}


// Just keeping this logic around for now. Might come in handy.

//Button("Fetch Task") {
//    // Utility
//    Task {
//        guard let currentToDo:ToDo = await API().fetchToDo(toDoID: "d08b6f-a4f8c40f8fa751c")
//        else {print("Task not found");return}
//
//        print(currentToDo.taskDescription)
//    }
//}
