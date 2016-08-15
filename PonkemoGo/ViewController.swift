//
//  ViewController.swift
//  PonkemoGo
//
//  Created by Dang Quoc Huy on 8/12/16.
//  Copyright © 2016 Dang Quoc Huy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var pokemon1Button: UIButton!
    @IBOutlet weak var pokemon2Button: UIButton!
    @IBOutlet weak var pokemon3Button: UIButton!
    
    var pokemons: [UIButton] = []
    var pokemonNames = ["Pikachu", "Dragon", "KhungLong"]
    var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        pokemons.append(pokemon1Button)
        pokemons.append(pokemon2Button)
        pokemons.append(pokemon3Button)
    }

    @IBAction func onSelectPokemon(sender: UIButton) {
        
        for (index, button) in pokemons.enumerate() {
            if sender == button {
                selectedIndex = index
                activeBoder(button)
            } else {
                inactiveBoder(button)
            }
        }
    }
    
    @IBAction func tapNotify(sender: AnyObject) {
        
        let notification = UILocalNotification()
        notification.fireDate = NSDate(timeIntervalSinceNow: 3)
        notification.alertBody = "\(pokemonNames[selectedIndex]) is nearby"
        notification.alertAction = "gotta catch them all!"
        notification.userInfo = ["SelectedPokemon": pokemonNames[selectedIndex]]
        notification.category = "CatchPokemonCategory"
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
    
    func activeBoder(button: UIButton) {
        
        button.layer.borderColor = UIColor.blueColor().CGColor
        button.layer.borderWidth = 1
    }
    
    func inactiveBoder(button: UIButton) {
        
        button.layer.borderWidth = 0
    }
}
