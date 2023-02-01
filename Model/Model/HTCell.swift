//
//  HTCell.swift
//  Headache Tracker
//
//  Created by Nehal Jhala.
//

import UIKit

class HTCell: UITableViewCell {
    
    @IBOutlet weak var startTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
