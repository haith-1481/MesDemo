//
//  extensions.swift
//  MesDemo
//
//  Created by trinh.hoang.hai on 6/7/19.
//  Copyright © 2019 trinh.hoang.hai. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {

    func setRounded() {
        self.layer.borderWidth = 0.5
        self.layer.masksToBounds = false
        self.layer.cornerRadius = self.frame.height/2
        self.layer.masksToBounds = true
    }
}
