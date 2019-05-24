//
//  ViewController.swift
//  TicTacToe
//
//  Created by Jeffrey Kim on 1/18/19.
//  Copyright © 2019 Jeffrey Kim. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    let possibleLabelStrings = ["Team X's turn", "Team O's turn", "Invalid Move", "Team X Won", "Team O Won"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        gameAnnouncer.text = possibleLabelStrings[0]
    }
    
    //initialize the Board struct.
    var instanceOfBoard = Board()

    //Simple label for showing whose turn it is to player
    @IBOutlet weak var gameAnnouncer: UILabel!
    
    //All buttons on screen are linked to this function, separated by tag.
    @IBAction func gamePlayer(_ sender: UIButton) {
     
        //based on the outcome of the model checkTile function, change the text field of the button appropriately and switch turns
            switch instanceOfBoard.checkTile(tester: sender.tag) {
            case .O :
                sender.setTitle("O", for: UIControl.State.normal)
                gameAnnouncer.text = possibleLabelStrings[0]
            case .X :
                sender.setTitle("X", for: UIControl.State.normal)
                gameAnnouncer.text = possibleLabelStrings[1]
            case .isInvalid:
                gameAnnouncer.text = possibleLabelStrings[2]
            default:
                print("nothing happened")
                
            }
        constantlyCheckForWinner()
        }
    
    //calls checkForWinner from model and changes text to reflect who won
    func constantlyCheckForWinner() {
        let result = instanceOfBoard.checkForWinner()
        switch result {
        case .OWon:
            gameAnnouncer.text = possibleLabelStrings[4]
        case .XWon:
            gameAnnouncer.text = possibleLabelStrings[3]
        case .StillPlaying:
            break
       
        }
    }
    
    //this is an array of all buttons on screen
    @IBOutlet var myButtons: [UIButton]!

    //clear text from all buttons, reset the player order, reset the announcer label
    @IBAction func resetButton(_ sender: UIButton) {
        gameAnnouncer.text = possibleLabelStrings[0]
        instanceOfBoard.reset()
        for button in myButtons {
            button.setTitle("", for: UIControl.State.normal)}
        print("Reset Game")
    }

}
