//
//  UsersTableViewCell.swift
//  TechieButlerAPITask
//
//  Created by Srinivas on 30/04/24.
//

import UIKit

class UsersTableViewCell: UITableViewCell {

    @IBOutlet weak var userIdLbl : UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
