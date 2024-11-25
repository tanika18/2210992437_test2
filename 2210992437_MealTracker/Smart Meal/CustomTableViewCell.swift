//
//  CustomTableViewCell.swift
//  Smart Meal
//
//  Created by Uddeshya Singh on 24/11/24.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var calories: UILabel!
    
    static var identifier: String = "CustomTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
