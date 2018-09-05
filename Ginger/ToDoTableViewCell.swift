//
//  ToDoTableViewCell.swift
//  Ginger
//
//  Created by Sabrina Ren on 2018-08-27.
//  Copyright © 2018 Sabrina Ren. All rights reserved.
//

import UIKit

class ToDoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var todoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cardView?.layer.shadowOpacity = 0.2
        cardView?.layer.shadowRadius = 1
        cardView?.layer.shadowOffset = CGSize(width: 0, height: 1)
        cardView?.layer.shadowColor = UIColor.lightGray.cgColor
        cardView?.layer.cornerRadius = 6
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        self.contentView.backgroundColor = Colours.Grey
    }

}
