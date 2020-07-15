//
//  UIColorExtension.swift
//  LeagueOfWalk
//
//  Created by 요한 on 2020/07/14.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import Foundation

// MARK: - RGB

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}

