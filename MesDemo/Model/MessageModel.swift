//
//  MessageModel.swift
//  MesDemo
//
//  Created by trinh.hoang.hai on 6/4/19.
//  Copyright © 2019 trinh.hoang.hai. All rights reserved.
//

import Foundation
import UIKit

enum Position {
    case alone
    case first
    case mid
    case last
}

enum Sender {
    case me
    case friend
}

class Message {
    var content: String
    let sender: Sender
    let attachment: UIImage?
    let date: Date
    var position: Position = .alone

    init(content: String, sender: Sender, attachment: UIImage?, date: Date, position: Position) {
        self.content = content
        self.sender = sender
        self.attachment = attachment
        self.date = date
        self.position = position
    }
}
