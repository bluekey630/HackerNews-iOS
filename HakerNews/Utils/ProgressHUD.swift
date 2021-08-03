//
//  ProgressHUD.swift
//  HakerNews
//
//  Created by Admin on 2021/8/3.
//

import Foundation
import JGProgressHUD
import UIKit

class ProgressHUD {
    static let shared = ProgressHUD()
    let hud = JGProgressHUD(style: .light)
    
    private init() {}
    
    func show(view: UIView, msg: String) {
        hud.textLabel.text = msg
        hud.show(in: view)
    }
    
    func dismiss() {
        //hud.dismiss(afterDelay: 3.0)
        hud.dismiss()
    }
}
