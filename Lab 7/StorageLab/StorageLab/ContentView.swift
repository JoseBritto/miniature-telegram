//
//  ContentView.swift
//  StorageLab
//
//  Created by Tech on 2025-03-11.
//

import SwiftUI
import CoreData

class RandomGen {
    static func userName() -> String {
        let names = ["Alice", "Bob", "Charlie", "David", "Eve", "Frank", "Grace", "Hannah", "Isaac", "Jack"]
        let id1 = Int.random(in: 0..<names.count)
        let id2 = Int.random(in: 0..<names.count)
        return "\(names[id1]) \(names[id2])"
    }

    static func postTitle() -> String {
        let titles = ["The Future of Technology", "A Day in the Life of a Developer", "Exploring Swift 5", "Understanding AI and ML", "Best Practices for Clean Code", "How to Build an iOS App", "The Power of Automation", "UI/UX Design Principles", "Mastering Algorithms", "The Evolution of Software Development"]
        
        let id1 = Int.random(in: 0..<titles.count)
        return "\(titles[id1])"
    }

}

struct ContentView: View {
    
    @Environment(\.managedObjectContext)
    var context
    
    @FetchRequest(sortDescriptors: [])
    var users:FetchedResults<User>
    
    //@FetchRequest(sortDescriptors: [NSSortDescriptor(key:
    //   "author.userName", ascending: true)], predicate:
    //    NSPredicate(format: "author.userName == %@", "Bob Alice"))
    // Will filter and show only posts by Bob Alice. Remove above predicate to show all posts
    
   // @FetchRequest(sortDescriptors: [NSSortDescriptor(key:
   //    "author.userName", ascending: true)], predicate:
   //     NSPredicate(format: "author.userName BEGINSWITH %@", "Eve"))
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(key:
       "author.userName", ascending: true)])
    var posts:FetchedResults<Post>
    
    
    var body: some View {
        VStack {
            Button(action: {
                let user = User(context: context)
                user.userName = RandomGen.userName()
                try? context.save()
            }, label: {
                Text("Add User")
            })
            
            Text("Users: ")
            List{
                ForEach(users, id: \.self){
                    user in
                    Text(user.userName ?? "-")
                        .onTapGesture {
                            let post = Post(context: context)
                            post.title = RandomGen.postTitle()
                            post.author = user
                            try? context.save()
                        }
                }.onDelete(perform: {
                    offsets in
                    context.delete(users[offsets.first ?? 0])
                    try? context.save()
                })
            }
            Text("Posts: ")
            List {
                ForEach(posts, id:\.self){
                    post in
                    HStack {
                        Text(post.title ?? "-")
                        Text(post.author?.userName ?? "-")
                    }
                }.onDelete(perform: {
                    offsets in
                    context.delete(posts[offsets.first ?? 0])
                    try? context.save()
                })
            }
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
    
}
