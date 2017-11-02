//
//  EmotionsViewController.swift
//  FaceIt
//
//  Created by Max Guzman on 5/14/16.
//  Copyright © 2016 Robot Dream. All rights reserved.
//

import UIKit

class EmotionsViewController: UIViewController, UISplitViewControllerDelegate {
    
    fileprivate let emotionalFaces: Dictionary<String,FacialExpression> = [
        "enojado" : FacialExpression(eyes: .closed, eyeBrows: .furrowed, mouth: .frown),
        "feliz" : FacialExpression(eyes: .open, eyeBrows: .normal, mouth: .smile),
        "preocupado" : FacialExpression(eyes: .open, eyeBrows: .relaxed, mouth: .smirk),
        "travieso" : FacialExpression(eyes: .open, eyeBrows: .furrowed, mouth: .grin),
    ]
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var destinationvc = segue.destination
        if let navcon = destinationvc as? UINavigationController {
            destinationvc = navcon.visibleViewController ?? destinationvc
        }
        if let facevc = destinationvc as? FaceViewController {
            if let identifier = segue.identifier {
                if let expression = emotionalFaces[identifier] {
                    facevc.expression = expression
                    if let sendingButton = sender as? UIButton {
                        facevc.navigationItem.title = sendingButton.currentTitle
                    }
                }
            }
        }
        
    }
//    
//    func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController: UIViewController, ontoPrimaryViewController primaryViewController: UIViewController) -> Bool {
//        if primaryViewController.contentViewController == self {
//            return true
//        }
//        return false
//    }
}

//extension UIViewController {
//    var contentViewController: UIViewController {
//        if let navcon = self as? UINavigationController {
//            return navcon.visibleViewController ?? self
//        } else {
//            return self
//        }
//    }
//}
