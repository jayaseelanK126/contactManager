//
//  ContactManagerTableViewCell.swift
//  Contact Manager
//
//  Created by Pyramid on 18/11/21.
//

import UIKit

class ContactManagerTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var contactImgView: UIImageView!
    
    @IBOutlet weak var contactnameLbl: UILabel!
    
    @IBOutlet weak var contactLocationLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
