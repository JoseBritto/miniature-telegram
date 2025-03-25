//
//  ContentView.swift
//  NavigationInSwiftUI
//
//  Created by Hardik Kumar . on 2025-02-14.
//

import SwiftUI


struct SecondView:View{
    
    var choice:Choice
    
    var body: some View{
        Text("Your choice \(choice.name)")
    }
}






struct ContentView: View {
    var choices:[Choice] = [
    Choice(name: "One"),
    Choice(name: "Two"),
    Choice(name: "Three")
    ]
    
    var body: some View {
        NavigationView{
            List(choices){
                c in
                NavigationLink(destination: SecondView(choice:c)){
                    Text(c.name)
                }
            }
        .navigationTitle("Home")
        .navigationBarTitleDisplayMode(.inline)
            
        }
        
        
    }
}

#Preview {
    ContentView()
}
