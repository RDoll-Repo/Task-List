//
//  OptionsView.swift
//  Task List
//
//  Created by Roland Doll on 3/8/22.
//

import SwiftUI

struct OptionsView: View {
    @State var filter = "All"
    @State var sort = "Due"
    @State var order = "Ascending"
    
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
            }
            .navigationTitle("Options")
        }
    }
}

struct OptionsView_Previews: PreviewProvider {
    static var previews: some View {
        OptionsView()
    }
}
