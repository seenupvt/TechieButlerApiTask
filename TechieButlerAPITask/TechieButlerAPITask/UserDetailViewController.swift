//
//  UserDetailViewController.swift
//  TechieButlerAPITask
//
//  Created by Srinivas on 30/04/24.
//

import UIKit

class UserDetailViewController: UIViewController {
    var userDetailModel: UserModel!
    
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var bodyLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.title = "User \(userDetailModel.id) Detail "
        
        titleLbl.text = "Title: \n \(userDetailModel.id) :- \(userDetailModel.title)"
        bodyLbl.text = "Description: \n \(userDetailModel.body)"

            // Do any additional setup after loading the view.
    }
    
    @IBAction func tappedOnBack(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
