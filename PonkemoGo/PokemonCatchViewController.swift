//
//  PokemonCatchViewController.swift
//  PonkemoGo
//
//  Created by Dang Quoc Huy on 8/15/16.
//  Copyright © 2016 Dang Quoc Huy. All rights reserved.
//

import UIKit

class PokemonCatchViewController: UIViewController {

    @IBOutlet weak var pokeBallView: UIImageView!
    @IBOutlet weak var pokemonView: UIImageView!
    
    var pokemonName = "Pikachu"
    var ballOriginalCenter: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        pokemonView.image = UIImage(named: pokemonName)
    }
    
    @IBAction func onPokeBallPan(sender: UIPanGestureRecognizer) {
        
        switch sender.state {
        case .Began:
            // keep original point for later calculation
            ballOriginalCenter = pokeBallView.center
            
        case .Changed:
            let translation = sender.translationInView(view)
            pokeBallView.center = CGPoint(x: ballOriginalCenter.x + translation.x,
                                              y: ballOriginalCenter.y + translation.y)
            
        case .Ended:
            if CGRectIntersectsRect(pokeBallView.frame, pokemonView.frame) {
                // alert gotcha
                let alert = UIAlertController(title: "PonkemonGo", message: "GOTCHA!!! WELLDONE!!!", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .Default, handler: {(action) in
                    // move back to original place
                    UIView.animateWithDuration(0.6, animations: {
                        self.pokeBallView.center = self.ballOriginalCenter
                        }, completion: nil)
                }))
                presentViewController(alert, animated: true, completion:nil)
            } else {
                // move back to original place
                UIView.animateWithDuration(0.6, animations: {
                    self.pokeBallView.center = self.ballOriginalCenter
                    }, completion: nil)
            }
            
        default:
            break
        }
    }
}
