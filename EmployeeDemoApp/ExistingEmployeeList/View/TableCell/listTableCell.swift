//
//  listTableCell.swift
//  EmployeeDemoApp
//
//  Created by Sachin Randive on 15/05/20.
//  Copyright © 2020 Sachin Randive. All rights reserved.
//

import UIKit

class listTableCell: UITableViewCell {
    //MARK: - Outlets
    @IBOutlet weak var backGroundView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var lblNameOfEmployee: UILabel!
    @IBOutlet weak var lblSalaryOfEmployee: UILabel!
    @IBOutlet weak var lblAgeOfEmployee: UILabel!
    
    //MARK: - Initializers
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backGroundView.layer.cornerRadius = 10
    }
    
}
