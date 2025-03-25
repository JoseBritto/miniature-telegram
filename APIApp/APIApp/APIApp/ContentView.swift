//
//  ContentView.swift
//  APIApp
//
//  Created by Tech on 2025-03-20.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var nm = NetworkManager()
    @State var id: Int = 1
    @State var task: ToDo? = nil
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            
            TextField("ID:", value: $id, formatter: NumberFormatter()).onSubmit {
                nm.fetchTasks(for: id, completionHandler: {
                    tasks in
                    print("Received \(tasks.count) tasks")
                })
            }
            
            Button("Get Task", action: {
                nm.fetchTask(with: id, completionHandler: {
                    t in
                    self.task = t
                })
            })
            Text(task?.title ?? "----")
            List(nm.tasks) {
                t in
                Text(t.title)
                    .listRowBackground(t.completed ? Color.green: Color.red)
            }.onAppear{
                nm.fetchTasks(for: id, completionHandler: {
                    tasks in
                    print("Received \(tasks.count) tasks")
                })
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
