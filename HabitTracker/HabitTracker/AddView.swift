//
//  AddView.swift
//  HabitTracker
//
//  Created by Neloy Kundu on 6/4/20.
//  Copyright © 2020 Neloy Kundu. All rights reserved.
//

import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var activities: Activities
    @State private var name = ""
    @State private var description = ""
    @State private var completionCount = 0
    @State private var units = ""
    var body: some View {
        NavigationView {
            Form{
                Section(header: Text("Name")){
                    TextField("Type a name...", text: $name)
                }
                Section(header: Text("Description")){
                    TextField("Type info about habit...", text: $description)
                }
                Section(header: Text("How should progress be measured?")){
                    TextField("Units...", text: $units)
                }
                Section(header: Text("Completion (measured in above units)")) {
                    Picker(selection: $completionCount, label: Text("Progress so far")){
                        ForEach(0..<1000){
                            Text("\($0)")
                        }
                    }
                }
            }
            .navigationBarTitle("Add Activity")
            .navigationBarItems(leading: Button("Cancel"){
                self.presentationMode.wrappedValue.dismiss()
            },trailing: Button("Add"){
                self.activities.habits.append(Activity(name: self.name, description: self.description, completionCount: self.completionCount,units: self.units))
                self.presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(activities: Activities())
    }
}
