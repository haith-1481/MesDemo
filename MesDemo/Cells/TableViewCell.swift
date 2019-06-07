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
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var avaRightConstraint: NSLayoutConstraint!
    @IBOutlet weak var avaLeftConstraint: NSLayoutConstraint!
    
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
        if message.position == .alone || message.position == .first {
            avatarImageView.isHidden = false
            avatarImageView.setRounded()
            avatarImageView.contentMode = .scaleAspectFill
        } else {
            avatarImageView.isHidden = true
        }

        if message.sender == .friend {
            //receive
            switch message.position {
            case .alone:
                changeImage("bubble_received_alone")
            case .first:
                changeImage("bubble_received_first")
            case .mid:
                changeImage("bubble_received_mid")
            case .last:
                changeImage("bubble_received_last")
            }
            messageLabel.textColor = UIColor.black
            rightConstraint.constant = 100
            rightConstraint.priority = UILayoutPriority(rawValue: 200)
            leftContraint.constant = 50
            leftContraint.priority = UILayoutPriority(rawValue: 201)
            avatarImageView.image = #imageLiteral(resourceName: "Cat")
            avaLeftConstraint.priority = UILayoutPriority(rawValue: 201)
            avaRightConstraint.priority = UILayoutPriority(rawValue: 200)
        } else {
             //sent
            switch message.position {
            case .alone:
                changeImage("bubble_sent_alone")
            case .first:
                changeImage("bubble_sent_first")
            case .mid:
                changeImage("bubble_sent_mid")
            case .last:
                changeImage("bubble_sent_last")
            }
            messageLabel.textColor = UIColor.white
            rightConstraint.constant = 50
            rightConstraint.priority = UILayoutPriority(rawValue: 201)
            leftContraint.constant = 100
            leftContraint.priority = UILayoutPriority(rawValue: 200)
            avatarImageView.image = #imageLiteral(resourceName: "Owl")
            avaLeftConstraint.priority = UILayoutPriority(rawValue: 200)
            avaRightConstraint.priority = UILayoutPriority(rawValue: 201)
        }
        print("\(message.position)" + " ," + "\(message.sender)")
    }

    func changeImage(_ name: String) {
        guard let image = UIImage(named: name) else { return }
        bubbleImageView.image = image
            .resizableImage(withCapInsets:
                UIEdgeInsets(top: 17, left: 30, bottom: 17, right: 30),
                            resizingMode: .stretch)
    }
    
}
