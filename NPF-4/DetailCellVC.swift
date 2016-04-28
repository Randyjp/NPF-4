//
//  DetailCellVC.swift
//  NPF-4
//
//  Created by Randy Perez on 4/27/16.
//  Copyright © 2016 Randy Perez. All rights reserved.
//

import UIKit

class DetailCellVC: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var locaiton: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
