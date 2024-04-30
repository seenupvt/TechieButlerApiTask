//
//  ViewController.swift
//  TechieButlerAPITask
//
//  Created by Srinivas on 30/04/24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView : UITableView!
    
    var usersViewModel = UsersViewModel()
    var users: [UserModel] = []
    var currentPage = 1
    let pageSize = 15
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.backgroundColor = UIColor(red: 17/255.0, green: 49/255.0, blue: 84/255.0, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.tableView.dataSource = self
        self.tableView.reloadData()
        currentPage = 1
       // users = []
       // fetchData()
        loadUserData(currentPage: currentPage, size: pageSize)
       // NotificationCenter.default.addObserver(self, selector: #selector(reloadTableView), name: Notification.Name("ReloadData"), object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.backgroundColor = UIColor(red: 17/255.0, green: 49/255.0, blue: 84/255.0, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        super.viewWillAppear(animated)
    }
    func loadUserData(currentPage: Int , size: Int){
        usersViewModel.getUsers(page: currentPage, pageSize: size) {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    func reloadTableView(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    func fetchData() {
            guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts?_page=\(currentPage)&_limit=\(pageSize)") else {
                return
            }
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else {
                    print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                do {
                    let fetchedPosts = try JSONDecoder().decode([UserModel].self, from: data)
                    self.users.append(contentsOf: fetchedPosts)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } catch {
                    print("Error decoding data: \(error.localizedDescription)")
                }
            }.resume()
        }
}

extension ViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersViewModel.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UsersTableViewCell", for: indexPath) as! UsersTableViewCell
        if usersViewModel.users.count > indexPath.row {
            let user = usersViewModel.users[indexPath.row]
            cell.userIdLbl.text = String(user.id)
            cell.titleLbl.text = user.title
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "UserDetailViewController") as? UserDetailViewController
        viewController?.userDetailModel = self.usersViewModel.users[indexPath.row]
        navigationController?.pushViewController(viewController!, animated: true)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let offsetY = scrollView.contentOffset.y
            let contentHeight = scrollView.contentSize.height
            if offsetY > contentHeight - scrollView.frame.height {
                currentPage += 1
                loadUserData(currentPage: currentPage, size: pageSize)
            }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "User Id          Title"
    }
}

