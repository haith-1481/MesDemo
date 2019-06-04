//
//  BubbleChatView.swift
//  MesDemo
//
//  Created by trinh.hoang.hai on 6/4/19.
//  Copyright © 2019 trinh.hoang.hai. All rights reserved.
//

import Foundation
import UIKit

class BubbleChatView: UIImage {

    var messageLabel: UILabel?
    var backGround: UIImageView?
    var attachment: UIImageView?

    init(message: Message) {
        let sender = message.sender

    }

    func changeImage(_ name: String) {
        guard let image = UIImage(named: name) else { return }
        BubbleChatView.image = image
            .resizableImage(withCapInsets:
                UIEdgeInsetsMake(17, 21, 17, 21),
                            resizingMode: .stretch)
            .withRenderingMode(.alwaysTemplate)
    }

}
