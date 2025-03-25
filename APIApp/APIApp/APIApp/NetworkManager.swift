//
//  NetworkManager.swift
//  APIApp
//
//  Created by Tech on 2025-03-20.
//

import Foundation

class NetworkManager:ObservableObject {
    @Published var tasks: [ToDo] = []
    
    let address = "https://jsonplaceholder.typicode.com"
    
    func fetchAllTasks(completionHandler: @escaping([ToDo]) -> Void) {
        let url = URL(string: address+"/todos")!
        
        let task = URLSession.shared.dataTask(with: url){
            (data, response, error) in
            
            if let error=error {
                print("Error fetching data: \(error.localizedDescription)")
                completionHandler([])
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Server error fetching data: \(String(describing: response))")
                completionHandler([])
                return
            }
            
            if let data = data {
                let res = try? JSONDecoder().decode([ToDo].self, from: data)
                self.tasks = res ?? []
                completionHandler(self.tasks)
            }
        }
        task.resume()
    }
    
    func fetchTask(with id: Int, completionHandler: @escaping(ToDo?) -> Void) {
        let url = URL(string: address+"/todos/\(id)")!
        
        let task = URLSession.shared.dataTask(with: url){
            (data, response, error) in
            
            if let error=error {
                print("Error fetching data: \(error.localizedDescription)")
                completionHandler(nil)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Server error fetching data: \(String(describing: response))")
                completionHandler(nil)
                return
            }
            
            if let data = data {
                let res = try? JSONDecoder().decode(ToDo.self, from: data)
                completionHandler(res)
            }
        }
        task.resume()
    }
    
    func fetchTasks(for user:Int, completionHandler: @escaping([ToDo]) -> Void) {
        let url = URL(string: address+"/todos?userId=\(user)")!
        
        let task = URLSession.shared.dataTask(with: url){
            (data, response, error) in
            
            if let error=error {
                print("Error fetching data: \(error.localizedDescription)")
                completionHandler([])
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Server error fetching data: \(String(describing: response))")
                completionHandler([])
                return
            }
            
            if let data = data {
                let res = try? JSONDecoder().decode([ToDo].self, from: data)
                self.tasks = res ?? []
                completionHandler(self.tasks)
            }
        }
        task.resume()
    }
    

}
