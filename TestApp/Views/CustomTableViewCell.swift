//
//  CustomTableViewCell.swift
//  TestApp
//
//  Created by 123 on 15.10.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var userImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        userImageView.layer.cornerRadius = 40
        userImageView.layer.masksToBounds = true
        

    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

extension CustomTableViewCell: ReuseIdentifierProtocol { }
