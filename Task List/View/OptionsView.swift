//
//  OptionsView.swift
//  Task List
//
//  Created by Roland Doll on 3/8/22.
//

import SwiftUI

struct OptionsView: View {
    @Environment(\.dismiss) var dismiss
    @State var filter = "All"
    @State var sort = "Due"
    @State var order = "Ascending"
    var api:API
    
    let filters = ["All", "Complete", "Incomplete"]
    let sorts = ["Due", "Created"]
    let orders = ["Ascending", "Descending"]
    
    var body: some View {
        
        NavigationView {
            Form {
                Section {
                    Picker("Filter", selection: $filter) {
                        ForEach(filters, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                Text("Filters")
                }
                Section {
                    Picker("Sort", selection: $sort) {
                        ForEach(sorts, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                Text("Sort By")
                }
                Section {
                    Picker("Order", selection: $order) {
                        ForEach(orders, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                Text("Sort Direction")
                }
                
                Button("Submit") {
                    var params:String
                    api.queryString = api.defaultQueryString
                    
                    switch filter {
                    case "Complete":
                        params = "?completed=true&"
                    case "Incomplete":
                        params = "?completed=false&"
                    default:
                        params = "?"
                    }
                    
                    if sort == "Created" {
                        params += "sort_by=createdAt&"
                    } else {
                        params += "sort_by=dueDate&"
                    }
                    
                    if order == "Descending" {
                        params += "order_by=desc"
                    } else {
                        params += "order_by=asc"
                    }
                    
                    api.queryString += params
                    
                    dismiss()
                
                }
            }
            .navigationTitle("Options")
        }
    }
}

//struct OptionsView_Previews: PreviewProvider {
//    static var previews: some View {
//        OptionsView()
//    }
//}
