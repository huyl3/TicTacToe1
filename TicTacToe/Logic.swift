//
//  Logic.swift
//  TicTacToe
//
//  Created by Jeffrey Kim on 1/18/19.
//  Copyright © 2019 Jeffrey Kim. All rights reserved.
//

import Foundation

//this new function compares one array to a larger array, returning true if every single element of the first array is present in the larger array.
//syntax from stackExchange
extension Array where Element: Equatable {
    func containsArray(array: [Element]) -> Bool {
        for item in array {
            if !self.contains(item) { return false }
        }
        return true
    }
}

//if this variable is true, X is playing. if it is false, O is playing. X always begins first.

var gamePlayerTracker : Bool! = true

//Describes the states of a given tile: owned by X, O, or blank, or is not valid for play (usually owned by the other player)

enum Tile {
    case X
    case O
    case isBlank
    case isInvalid
}

//Describes the state of the whole game: whether X or O won. Maybe StillPlaying is unnecessary.

enum GameState {
    case XWon
    case OWon
    case StillPlaying
}

struct Board {
    
    //These arrays will be populated with the sender.tags of the buttons that were pressed by each player, then referenced with possibleWinCombinations to show who won.
    public var takenByO: [Int] = []
    public var takenByX: [Int] = []

    //a 2D array describing all possible winning combinations
    private let possibleWinCombinations =
        [
            [0,1,2],
            [0,3,6],
            [0,4,8],
            [1,4,7],
            [2,5,8],
            [3,4,5],
            [6,7,8],
            [2,4,6]
        ]

    //function that takes the sender.tag value of the button pressed and then returns the player who took the tile
    mutating func checkTile(tester: Int) -> Tile {
            if gamePlayerTracker == true {
                //if X is playing.
                if takenByX.contains(tester) {
                    takenByX.append(tester)
                    print("X played.")
                    gamePlayerTracker = false

                    return .X
                }
                    //if O already has this tile, prevent X from taking it.
                else if takenByO.contains(tester) {
                    return .isInvalid
                }
                    //need this to allow the first tile to be taken.
                else {
                    takenByX.append(tester)
                    print("X played.")
                    gamePlayerTracker = false

                    return .X
                }
            }
        else if gamePlayerTracker == false {
                //if O is playing.
                if takenByO.contains(tester) {
                    takenByO.append(tester)
                    print("O played.")
                    gamePlayerTracker = true

                    return .O

                }
                    //if X has this tile, prevent O from taking it.
                else if takenByX.contains(tester) {
                    return .isInvalid
                }
                    //need this to allow the first tile to be taken.
                else {
                    takenByO.append(tester)
                    print("O played.")
                    gamePlayerTracker = true

                    return .O

                }
            }
        
        print("something went wrong")
        return .isInvalid
    }
    
    // this function will be run to check if there is a winner after every move.
    func checkForWinner() -> GameState {
        print("O owns \(takenByO)")
        print("X owns \(takenByX)")

        // compare each winning combination to the current array of "Tiles taken by X or O". If the current array contains all elements of the winning combination, we know that the player won the game.
        if takenByX.count >= 3 {
            for testXArray in possibleWinCombinations {
                if takenByX.containsArray(array: testXArray) {
                    print("Winner is X")
                    return .XWon
                }
              
            }
           
        }
        if takenByO.count >= 3 {
            for testOArray in possibleWinCombinations {
                if takenByO.containsArray(array: testOArray) {
                    print("Winner is O")
                    return .OWon
                }
              
            }
            
        }
        //continue playing game
        return .StillPlaying
    }
    
    
    //this function is used when the reset button is tapped and sets the first player to be X again.
    mutating func reset() {
        takenByO.removeAll()
        takenByX.removeAll()
        gamePlayerTracker = true }
        
    init() {
        gamePlayerTracker = true
        }
    
    }


