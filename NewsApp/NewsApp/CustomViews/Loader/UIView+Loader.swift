//
//  UIView+Loader.swift
//  NewsApp
//
//  Created by ABDO on 30/10/2022.
//

import UIKit
extension UIView {
 
    func showLoader() {
        let hud = MBProgressHUD.showAdded(to: self, animated: true)

        hud.backgroundView.style = MBProgressHUDBackgroundStyle.solidColor
        hud.backgroundView.color = UIColor.black.withAlphaComponent(0.1)
        hud.bezelView.backgroundColor = UIColor.white
        hud.contentColor = UIColor.gray
        hud.mode = MBProgressHUDMode.indeterminate
    }
    
    func hideLoader() {
        MBProgressHUD.hide(for: self, animated: true)
    }
}
