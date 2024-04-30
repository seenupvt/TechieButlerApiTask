//
//  UsersViewModel.swift
//  TechieButlerAPITask
//
//  Created by Srinivas on 30/04/24.
//

import Foundation

class UsersViewModel{
    var users = [UserModel]()
    func getUsers(page: Int, pageSize: Int , completion: @escaping () -> Void){
        let urlString = "https://jsonplaceholder.typicode.com/posts?_page=\(page)&_limit=\(pageSize)"
        
        NetworkManager.shared.fetchData(urlString: urlString) { Users, error in
            if let Users{
                self.users.append(contentsOf: Users)
                self.users.sort { $0.id < $1.id }
               // NotificationCenter.default.addObserver(self, selector: #selector(reloadTableView), name: Notification.Name("ReloadData"), object: nil)
                completion()
            }
        }
    }
}
