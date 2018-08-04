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
    
    @IBAction func onPokeBallPan(_ sender: UIPanGestureRecognizer) {
        
        switch sender.state {
        case .began:
            // keep original point for later calculation
            ballOriginalCenter = pokeBallView.center
            
        case .changed:
            let translation = sender.translation(in: view)
            pokeBallView.center = CGPoint(x: ballOriginalCenter.x + translation.x,
                                              y: ballOriginalCenter.y + translation.y)
            
        case .ended:
            if pokeBallView.frame.intersects(pokemonView.frame) {
                // alert gotcha
                let alert = UIAlertController(title: "PonkemonGo", message: "GOTCHA!!! WELLDONE!!!", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: {(action) in
                    // move back to original place
                    UIView.animate(withDuration: 0.6, animations: {
                        self.pokeBallView.center = self.ballOriginalCenter
                        }, completion: nil)
                }))
                present(alert, animated: true, completion:nil)
            } else {
                // move back to original place
                UIView.animate(withDuration: 0.6, animations: {
                    self.pokeBallView.center = self.ballOriginalCenter
                    }, completion: nil)
            }
            
        default:
            break
        }
    }
}
