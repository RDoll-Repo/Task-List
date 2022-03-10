//
//  TaskData.swift
//  Task List
//
//  Created by Roland Doll on 3/2/22.
//

import SwiftUI
import Alamofire

struct TaskView: View {
    @StateObject private var viewModel = TaskViewModel()
    let api = API()
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    ForEach(viewModel.todos) { todo in
                        CardView(todo: todo, viewModel:viewModel, api:api)
                    }
                .toolbar {
                    HStack(spacing: 18.0) {
                        Button {
                            viewModel.showingOptions.toggle()
                        } label: {
                            Image(systemName: "list.bullet")
                                .resizable(capInsets: EdgeInsets(top: 0.0, leading: 0.0, bottom: 0.0, trailing: 40))
                        }
                        .sheet(isPresented: $viewModel.showingOptions, onDismiss: {
                            Task {
                                viewModel.todos = await api.getToDos()
                            }
                        }) {
                            OptionsView(api:api)
                        }
                        .frame(width: 40, height: 40)
                        .padding()
                        
                        Spacer()
                        
                        Text("Task List")
                            .font(.largeTitle)
                        
                        Spacer()
                        
                        Button {
                            viewModel.showingUpdate.toggle()
                        } label: {
                            Image(systemName: "plus.circle")
                                .resizable(capInsets: EdgeInsets(top: 0.0, leading: 40.0, bottom: 0.0, trailing: 0.0))
                        }
                        .sheet(isPresented: $viewModel.showingUpdate, onDismiss: {
                            Task {
                                viewModel.todos = await api.getToDos()
                            }
                        }) {
                            UpdateView(todo:ToDo(id:"",taskDescription: "",dueDate: "",completed: false,createdAt: ""),
                                       due: Date(),
                                       EditType: "Create", viewModel: viewModel, api:api)
                        }
                        .frame(width: 45, height: 45)
                        .padding()
                    }
                }

                }
            }
            .task {
                viewModel.todos = await api.getToDos()
            }
        }
    }
}

struct PrintView: View {
    init(_ str: String) {
        print(str)
    }
    
    let body = EmptyView()
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
