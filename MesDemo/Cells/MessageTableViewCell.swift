//
//  MessageTableViewCell.swift
//  MesDemo
//
//  Created by trinh.hoang.hai on 6/4/19.
//  Copyright © 2019 trinh.hoang.hai. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {

    @IBOutlet weak var messageView: UIView!
    var message: Message?
    var bubbleImageView = UIImageView()
    var messageLabel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
        // Initialization code
    }

    func setup() {
        bubbleImageView = UIImageView(image: #imageLiteral(resourceName: "bubble1"), highlightedImage: #imageLiteral(resourceName: "bubble1"))
        bubbleImageView.isUserInteractionEnabled = true
        messageLabel.font = UIFont.systemFont(ofSize: 15)
        messageLabel.numberOfLines = 0
        messageLabel.isUserInteractionEnabled = true
        selectionStyle = .none
        contentView.addSubview(bubbleImageView)
        bubbleImageView.addSubview(messageLabel)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        bubbleImageView.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.preferredMaxLayoutWidth = 180
        messageLabel.setContentHuggingPriority(UILayoutPriority.required, for:.horizontal)

        contentView.addConstraint(NSLayoutConstraint(item: bubbleImageView, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 4.5))
        contentView.addConstraint(NSLayoutConstraint(item: bubbleImageView, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: -4.5))

        bubbleImageView.addConstraint(NSLayoutConstraint(item: bubbleImageView, attribute: .width, relatedBy: .equal, toItem: messageLabel, attribute: .width, multiplier: 1, constant: 50))
        bubbleImageView.addConstraint(NSLayoutConstraint(item: messageLabel, attribute: .centerX, relatedBy: .equal, toItem: bubbleImageView, attribute: .centerX, multiplier: 1, constant: -0.5))
        bubbleImageView.addConstraint(NSLayoutConstraint(item: messageLabel, attribute: .centerY, relatedBy: .equal, toItem: bubbleImageView, attribute: .centerY, multiplier: 1, constant: -0.5))
        bubbleImageView.addConstraint(NSLayoutConstraint(item: messageLabel, attribute: .height, relatedBy: .equal, toItem: bubbleImageView, attribute: .height, multiplier: 1, constant: -15))

    }

    func setCell(message: Message) {
        messageLabel.text = message.content
        var layoutAttribute: NSLayoutConstraint.Attribute
        var layoutConstant: CGFloat
        var maxLayoutAttribute: NSLayoutConstraint.Attribute
        var maxLayoutConstant: CGFloat
        if message.sender == .friend {
            changeImage("bubble1") //sent
            messageLabel.textColor = UIColor.black
            layoutAttribute = .left
            maxLayoutAttribute = .right
            layoutConstant = 50
            maxLayoutConstant = -100
        } else {
            changeImage("bubble") //receive
            messageLabel.textColor = UIColor.white
            layoutAttribute = .right
            maxLayoutAttribute = .left
            layoutConstant = -50
            maxLayoutConstant = 100
        }
        contentView.addConstraint(NSLayoutConstraint(item: bubbleImageView, attribute: layoutAttribute, relatedBy: .equal, toItem: contentView, attribute: layoutAttribute, multiplier: 1, constant: layoutConstant))
        messageLabel.setContentHuggingPriority(UILayoutPriority.defaultHigh, for:.horizontal)
        let widthConstraint = NSLayoutConstraint(item: bubbleImageView, attribute: maxLayoutAttribute, relatedBy: .equal, toItem: contentView, attribute: maxLayoutAttribute, multiplier: 1, constant: maxLayoutConstant)
        widthConstraint.priority = UILayoutPriority(rawValue: 100)
        widthConstraint.isActive = true
    }

    func changeImage(_ name: String) {
        guard let image = UIImage(named: name) else { return }
        bubbleImageView.image = image
               .resizableImage(withCapInsets:
                                UIEdgeInsets(top: 17, left: 30, bottom: 17, right: 30),
                                resizingMode: .stretch)
     }
}
