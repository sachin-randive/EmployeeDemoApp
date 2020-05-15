//
//  TableCellOfEmployeeList.swift
//  EmployeeDemoApp
//
//  Created by Sachin Randive on 14/05/20.
//  Copyright © 2020 Sachin Randive. All rights reserved.
//

import UIKit

class TableCellOfEmployeeList: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var lblNameOfEmployee: UILabel!
    @IBOutlet weak var lblSalaryOfEmployee: UILabel!
    @IBOutlet weak var lblAgeOfEmployee: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    init(style: UITableViewCell.CellStyle, reuseIdentifier: String) {
           super.init(style: style, reuseIdentifier: reuseIdentifier)
       }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
