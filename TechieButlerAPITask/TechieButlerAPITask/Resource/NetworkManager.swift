//
//  NetworkManager.swift
//  TechieButlerAPITask
//
//  Created by Srinivas on 30/04/24.
//

import Foundation

class NetworkManager{
    static var shared = NetworkManager()
    private init(){
        
    }
    
    func fetchData(urlString: String , completion: @escaping ([UserModel]?,String?) -> Void){
        
        guard let url = URL(string: urlString) else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            do {
                let dataModels = try JSONDecoder().decode([UserModel].self, from: data)
                completion(dataModels,nil)
            } catch {
                completion(nil,"Error")
                print("Error decoding data: \(error.localizedDescription)")
            }
        }.resume()
    }
}
