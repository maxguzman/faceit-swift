//
//  FaceViewController.swift
//  FaceIt
//
//  Created by Max Guzman on 5/9/16.
//  Copyright © 2016 Robot Dream. All rights reserved.
//

import UIKit

class FaceViewController: UIViewController {

    // MARK: MODEL
    
    var expression = FacialExpression(eyes: .open, eyeBrows: .furrowed, mouth: .grin) { didSet { updateUI() } }

    // MARK: VIEW
    
    @IBOutlet weak var faceView: FaceView! {
        didSet {
            faceView.addGestureRecognizer(
                UIPinchGestureRecognizer(target: faceView, action: #selector(FaceView.changeScale(_:)))
            )
            let happierSwipeGestureRecognizer = UISwipeGestureRecognizer(
                target: self, action: #selector(FaceViewController.increaseHappiness)
            )
            happierSwipeGestureRecognizer.direction = .down
            faceView.addGestureRecognizer(happierSwipeGestureRecognizer)
            
            let sadderSwipeGestureRecognizer = UISwipeGestureRecognizer(
                target: self, action: #selector(FaceViewController.decreaseHappiness)
            )
            sadderSwipeGestureRecognizer.direction = .up
            faceView.addGestureRecognizer(sadderSwipeGestureRecognizer)
            
            updateUI()
        }
    }
    
    @IBAction func toggleEyes(_ recognizer: UITapGestureRecognizer) {
        if recognizer.state == .ended {
            switch expression.eyes {
            case .open: expression.eyes = .closed
            case .closed: expression.eyes = .open
            case .squinting : break
            }
        }
    
    }
    
    // MARK: Gesture Handlers
    
    func increaseHappiness() {
        expression.mouth = expression.mouth.happierMouth()
    }
    func decreaseHappiness() {
        expression.mouth = expression.mouth.sadderMouth()
    }
    
    fileprivate var mouthCurvatures = [FacialExpression.Mouth.frown: -1.0,
                                   .grin: 0.5,
                                   .smile: 1.0,
                                   .smirk: -0.5,
                                   .neutral: 0.0]
    
    fileprivate var eyeBrowTilts = [FacialExpression.EyeBrows.relaxed: 0.5,
                                 .furrowed: -0.5,
                                 .normal: 0.0]
    
    fileprivate func updateUI() {
        if faceView != nil {
            switch expression.eyes {
            case .open: faceView.eyesOpen = true
            case .closed: faceView.eyesOpen = false
            case .squinting: faceView.eyesOpen = false
        }
        faceView.mouthCurvature = mouthCurvatures[expression.mouth] ?? 0.0
        faceView.eyeBrowTilt = eyeBrowTilts[expression.eyeBrows] ?? 0.0
        }
    }
}

