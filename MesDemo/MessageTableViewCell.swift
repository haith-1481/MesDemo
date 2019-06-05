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
        messageLabel.preferredMaxLayoutWidth = 218
        messageLabel.setContentHuggingPriority(UILayoutPriority.required, for:.horizontal)

        contentView.addConstraint(NSLayoutConstraint(item: bubbleImageView, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 4.5))
        contentView.addConstraint(NSLayoutConstraint(item: bubbleImageView, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: -4.5))

        bubbleImageView.addConstraint(NSLayoutConstraint(item: bubbleImageView, attribute: .width, relatedBy: .equal, toItem: messageLabel, attribute: .width, multiplier: 1, constant: 50))
        bubbleImageView.addConstraint(NSLayoutConstraint(item: messageLabel, attribute: .centerX, relatedBy: .equal, toItem: bubbleImageView, attribute: .centerX, multiplier: 1, constant: -0.5))
        bubbleImageView.addConstraint(NSLayoutConstraint(item: messageLabel, attribute: .centerY, relatedBy: .equal, toItem: bubbleImageView, attribute: .centerY, multiplier: 1, constant: -0.5))
        bubbleImageView.addConstraint(NSLayoutConstraint(item: messageLabel, attribute: .height, relatedBy: .equal, toItem: bubbleImageView, attribute: .height, multiplier: 1, constant: -15))

//        let widthConstraint = NSLayoutConstraint(item: bubbleImageView, attribute: .width, relatedBy: .equal, toItem: messageLabel, attribute: .width, multiplier: 1, constant: 50)
//        widthConstraint.priority = .required
//        widthConstraint.isActive = true



//        NSLayoutConstraint.activate([
//            contentView.topAnchor.constraint(equalTo: bubbleImageView.topAnchor, constant: 4.5),
//            contentView.bottomAnchor.constraint(equalTo: bubbleImageView.bottomAnchor, constant: -4.5),
//
//            bubbleImageView.widthAnchor.constraint(equalTo: messageLabel.widthAnchor, constant: 50),
//            bubbleImageView.heightAnchor.constraint(equalTo: messageLabel.heightAnchor, constant: -15),
//            bubbleImageView.centerXAnchor.constraint(equalTo: messageLabel.centerXAnchor, constant: -0.5),
//            bubbleImageView.centerYAnchor.constraint(equalTo: messageLabel.centerYAnchor, constant: -0.5)
//        ])
    }

    func setCell(message: Message) {
        messageLabel.text = message.content
        var layoutAttribute: NSLayoutConstraint.Attribute
        var layoutConstant: CGFloat
        if message.sender {
            bubbleImageView.image = #imageLiteral(resourceName: "bubble1")
            messageLabel.textColor = UIColor.black
            layoutAttribute = .left
            layoutConstant = 50
        } else {
            bubbleImageView.image = #imageLiteral(resourceName: "bubble")
            messageLabel.textColor = UIColor.white
            layoutAttribute = .right
            layoutConstant = -50
        }
        messageLabel.setContentHuggingPriority(UILayoutPriority.defaultHigh, for:.horizontal)
        contentView.addConstraint(NSLayoutConstraint(item: bubbleImageView, attribute: layoutAttribute, relatedBy: .equal, toItem: contentView, attribute: layoutAttribute, multiplier: 1, constant: layoutConstant))
    }
}
