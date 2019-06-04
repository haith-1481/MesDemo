//
//  MessageModel.swift
//  MesDemo
//
//  Created by trinh.hoang.hai on 6/4/19.
//  Copyright © 2019 trinh.hoang.hai. All rights reserved.
//

import Foundation
import UIKit

class Message {
    let content: String
    let sender: Bool
    let attachment: UIImage?
    let date: Date

    init(content: String, sender: Bool, attachment: UIImage?, date: Date) {
        self.content = content
        self.sender = sender
        self.attachment = attachment
        self.date = date
    }
}
