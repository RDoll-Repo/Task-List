//
//  CreateView.swift
//  Task List
//
//  Created by Roland Doll on 3/7/22.
//

import SwiftUI

// Genericizing this view for use with both create and update since there's a lot of overlap
struct UpdateView: View {
    @Environment(\.dismiss) var dismiss
    @State var todo: ToDo
    @State var due: Date
    @State var EditType: String
    var viewModel: TaskViewModel
    var api:API
    
    
    var body: some View {
        Form {
            Text(EditType)
                .font(.largeTitle)
                .fontWeight(.heavy)
                .frame(alignment: .center )
            TextField("Task Name", text: $todo.taskDescription)
                .padding()
                .multilineTextAlignment(.center)
            DatePicker("Due Date", selection: $due, displayedComponents: .date)
                .datePickerStyle(WheelDatePickerStyle())
                .padding()
                .multilineTextAlignment(.center)
            Button("Submit") {
                Task {
                    if (EditType == "Create") {
                        await API().createToDo(NewToDo(
                            taskDescription: todo.taskDescription,
                            dueDate: "\(due)",
                            completed: false))
                    } else if (EditType == "Edit") {
                        await api.updateToDo(updated: ToDo(
                            id: todo.id,
                            taskDescription: todo.taskDescription,
                            dueDate: "\(due)",
                            completed: false,
                            createdAt: todo.createdAt))
                        viewModel.todos = await api.getToDos()
                    }
                    dismiss()
                }
            }
        }
    }
    
    func stringtoDate(due:String) -> Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-DD"
        let dueParsed = dateFormatter.date(from: due)!
        
        return dueParsed
    }

}



//struct UpdateView_Previews: PreviewProvider {
//    static var previews: some View {
//        UpdateView(todo: <#ToDo#>, id: "", desc: "", due: Date(), isPresented: true, EditType: "Edit")
//    }
//}
