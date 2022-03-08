//
//  Cards.swift
//  Task List
//
//  Created by Roland Doll on 3/7/22.
//

import SwiftUI


struct Cards: View {
    @State private var showingUpdate = false
    @State var todo:ToDo
    
    var body: some View {
        ZStack {
            
            if (todo.completed == true) {
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .fill(Color(.gray))
                    .frame(width: 350, height: 100)
            } else {
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .fill(Color("cards"))
                    .frame(width: 350, height: 100)
            }
            
            VStack(alignment: .leading) {
                var _: String = todo.id
                Text(todo.taskDescription)
                    .frame(width: 330, alignment: .leading)
                Text("Due: " + todo.dueDate)
                    .multilineTextAlignment(.leading)
                Text("Created: " + todo.createdAt)
            }
            
            HStack() {
                HStack {
                    
                    Button {
                        showingUpdate.toggle()
                    } label: {
                        Image(systemName: "pencil.circle.fill")
                            .resizable(capInsets: EdgeInsets(top: 0.0, leading: 30.0, bottom: 0.0, trailing: 0.0))
                    }
                    .frame(width: 30.0, height: 30.0)
                    .sheet(isPresented: $showingUpdate) {
                        UpdateView(todo:todo, due: Date(), EditType: "Edit")
                    }
                    

                    
                    Button {
                        Task {
                            await API().deleteToDo(toDoID:todo.id)
                        }
                    } label: {
                        Image(systemName: "xmark.app.fill")
                            .resizable(capInsets: EdgeInsets(top: 0.0, leading: 30.0, bottom: 0.0, trailing: 0.0))
                    }
                    .frame(width: 30.0, height: 30.0)
                }
                
                Button {
                    Task {
                        todo.completed.toggle()
                        await API().updateToDo(updated: todo)
                    }
                } label: {
                    
                    if (todo.completed == false){
                        Image(systemName: "checkmark.circle.fill")
                            .resizable(capInsets: EdgeInsets(top: 0.0, leading: 60.0, bottom: 0.0, trailing: 0.0))
                    }
                    else {
                        Image(systemName: "arrow.uturn.forward.circle.fill")
                            .resizable(capInsets: EdgeInsets(top: 0.0, leading: 60.0, bottom: 0.0, trailing: 0.0))
                    }
                    
        
                }
                .frame(width: 60.0, height: 60.0)
                .controlSize(.large)
            
            }
            .frame(width: 330, alignment: .trailing)
            
        }
        .frame(width: 380, height: 100)
    }
}

struct Cards_Previews: PreviewProvider {
    
    static var previews: some View {
        Cards(todo:ToDo(id: "1", taskDescription: "Sample", dueDate: "2011-01-01", completed: true, createdAt: "2010-01-01"))
    }
}
