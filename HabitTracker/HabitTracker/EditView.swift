//
//  EditView.swift
//  HabitTracker
//
//  Created by Neloy Kundu on 6/4/20.
//  Copyright © 2020 Neloy Kundu. All rights reserved.
//

import SwiftUI

struct EditView: View {
    @ObservedObject var activities: Activities
    let id: UUID
    
    func activity() ->  Activity  {
        for element in activities.habits {
            if element.id == id{
                return element
            }
        }
    
        return Activity(name: "Empty Activity", description: "Empty", completionCount: 0,units: "units")
    }
    
    var body: some View {
        VStack(spacing: 30){
            Spacer()
            Text(activity().name).font(.largeTitle).bold().multilineTextAlignment(.center)
            Text(activity().description).font(.title).multilineTextAlignment(.center)
            Spacer()
            VStack(spacing:30){
                Text("Current Progress: \(activity().completionCount) \(activity().units)").font(.title)
                Button(action: {
                    var index = 0
                    for element in self.activities.habits {
                        if element.id == self.id{
                            self.activities.habits[index] = Activity(name: self.activity().name, description: self.activity().description, completionCount: self.activity().completionCount + 1,units: self.activity().units)
                        }
                        index = index + 1
                    }
                }){
                    Text("ADD PROGRESS").font(.largeTitle).bold()
                }
            }
            Spacer()
            
            Spacer()
        }
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(activities: Activities(), id: UUID())
    }
}
