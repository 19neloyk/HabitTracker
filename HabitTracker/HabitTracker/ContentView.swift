//
//  ContentView.swift
//  HabitTracker
//
//  Created by Neloy Kundu on 6/4/20.
//  Copyright © 2020 Neloy Kundu. All rights reserved.
//

import SwiftUI

struct Activity: Identifiable, Codable {
    let id = UUID()
    var name:String
    var description:String
    var completionCount:Int
    var units:String
}

class Activities : ObservableObject {
    @Published var habits = [Activity]() {
        didSet{ //whenever habits is changed
            let encoder = JSONEncoder()
            
            if let encoded = try? encoder.encode(habits){
                UserDefaults.standard.set(encoded,forKey: "Habits")
            }
        }
    }
    
    init() {
        if let habits = UserDefaults.standard.data(forKey: "Habits") {
            let decoder = JSONDecoder()
            
            if let decoded = try? decoder.decode([Activity].self, from: habits){
                self.habits = decoded
                return
            }
        }
    }
    
}

struct ContentView: View {
    @ObservedObject var activities = Activities()
    @State private var showingAdd = false
    
    var body: some View {
        NavigationView{
            Form{
                
                    ForEach(activities.habits){ habit in
                        NavigationLink(destination:EditView(activities: self.activities, id: habit.id)){
                        HStack{
                            Text(habit.name)
                        }
                        }
                    }.onDelete(perform: removeActivities)
                
                
            }
            
            .navigationBarTitle("Habit Tracker")
            .navigationBarItems(leading: EditButton(),trailing: Button(action:{
                    //Action
                    self.showingAdd = true
                }){
                    //Button Visual Content
                    Image(systemName: "plus")
                }).sheet(isPresented: $showingAdd) {
                    AddView(activities: self.activities)
            }
            
        }
    }
    func removeActivities(at offsets: IndexSet) {
        activities.habits.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
