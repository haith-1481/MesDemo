//
//  TableViewCell.swift
//  MesDemo
//
//  Created by trinh.hoang.hai on 6/6/19.
//  Copyright © 2019 trinh.hoang.hai. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var bubbleImageView: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var rightConstraint: NSLayoutConstraint!
    @IBOutlet weak var leftContraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setup(message: Message) {
        messageLabel.text = message.content
        messageLabel.preferredMaxLayoutWidth = 180
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        bubbleImageView.translatesAutoresizingMaskIntoConstraints = false
        bubbleImageView.contentMode = .scaleToFill
        if message.sender {
            changeImage("bubble1") //sent
            messageLabel.textColor = UIColor.black
            rightConstraint.constant = 100
            rightConstraint.priority = UILayoutPriority(rawValue: 200)
            leftContraint.constant = 50
            leftContraint.priority = UILayoutPriority(rawValue: 201)
        } else {
            changeImage("bubble") //receive
            messageLabel.textColor = UIColor.white
            rightConstraint.constant = 50
            rightConstraint.priority = UILayoutPriority(rawValue: 201)
            leftContraint.constant = 100
            leftContraint.priority = UILayoutPriority(rawValue: 200)
        }
    }

    func changeImage(_ name: String) {
        guard let image = UIImage(named: name) else { return }
        bubbleImageView.image = image
            .resizableImage(withCapInsets:
                UIEdgeInsets(top: 17, left: 30, bottom: 17, right: 30),
                            resizingMode: .stretch)
    }
    
}
