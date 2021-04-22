//
//  MenuScene.swift
//  R Shooter
//
//  Created by Keith Davis on 11/15/16.
//  Copyright © 2016 ZuniSoft. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene {
    var starfield: SKEmitterNode!
    var newGameButtonNode: SKSpriteNode!
    var difficultyButtonNode: SKSpriteNode!
    var difficultyLabelNode: SKLabelNode!
    var scoreLabelNode: SKLabelNode!
    var score: Int = 0
    
    override func didMove(to view: SKView) {
        starfield = self.childNode(withName: "starfield") as? SKEmitterNode
        starfield.advanceSimulationTime(10)
        
        newGameButtonNode = self.childNode(withName: "newGameButton") as? SKSpriteNode
        difficultyButtonNode = self.childNode(withName: "difficultyButton") as? SKSpriteNode
        difficultyLabelNode = self.childNode(withName: "difficultyLabel") as? SKLabelNode
        scoreLabelNode = self.childNode(withName: "scoreLabel") as? SKLabelNode
        
        let userDefaults = UserDefaults.standard
        
        if userDefaults.bool(forKey: "hard") {
            difficultyLabelNode.text = "Hard"
        } else {
            difficultyLabelNode.text = "Easy"
        }
        
        scoreLabelNode.text = "Score: " + String(self.score)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        
        if let location = touch?.location(in: self) {
            let nodesArray = self.nodes(at: location)
            
            if nodesArray.last?.name == "newGameButton" {
                let transition = SKTransition.flipHorizontal(withDuration: 0.5)
                let gameScene = GameScene(size: self.size)
                gameScene.backgroundColor = UIColor.black
                self.view?.presentScene(gameScene, transition: transition)
            } else if nodesArray.last?.name == "difficultyButton" {
                changeDifficulty()
            }
        }
    }
    
    func changeDifficulty(){
        let userDefaults = UserDefaults.standard
        
        if difficultyLabelNode.text == "Easy" {
            difficultyLabelNode.text = "Hard"
            userDefaults.set(true, forKey: "hard")
        } else {
            difficultyLabelNode.text = "Easy"
            userDefaults.set(false, forKey: "hard")
        }
        
        userDefaults.synchronize()
    }
}
