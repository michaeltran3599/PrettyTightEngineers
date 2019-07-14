//
//  GameScene.swift
//  Viaslatt
//
//  Created by Michael Tran on 7/13/19.
//  Copyright © 2019 Michael Tran. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var worldNode:SKTileMapNode = SKTileMapNode();
    var character:SKSpriteNode = SKSpriteNode();
    let cam = SKCameraNode();
    let tileSet = SKTileSet(named: "Sample Grid Tile Set")!;
    let tileSize = CGSize(width: 128, height: 128)
    let columns = 128
    let rows = 128
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    var player = SKSpriteNode();
    var button = ScannerButton();
    
    let joystick = AnalogJoystick(diameters: (150, 75), colors: (UIColor.lightGray.withAlphaComponent(0.6), UIColor.gray.withAlphaComponent(0.6)), images: (UIImage(named: "substrate"), UIImage(named: "stick")))
    
    func setupJoyStick() {
        joystick.position = CGPoint(x: UIScreen.main.bounds.width * -0.5, y: UIScreen.main.bounds.height * -0.5)
        addChild(joystick)
        
        joystick.trackingHandler = { [unowned player] data in
            player.position = CGPoint(x: player.position.x + (data.velocity.x * 0.1), y: player.position.y + (data.velocity.y * 0.1))
            
        }
        
    }
    override func didMove(to view: SKView) {
        self.camera = cam;
        self.addChild(self.button);
        worldNode = self.childNode(withName: "WorldNode") as! SKTileMapNode;
        player = SKSpriteNode(imageNamed: "manBlue_hold");
        player.anchorPoint = CGPoint(x: 0.5, y: 0.5);
        player.position = CGPoint(x: 0, y: 0);
        self.addChild(player)
        
        // get the scene size as scaled by `scaleMode = .AspectFill`
        let scaledSize = CGSize(width: size.width * cam.xScale, height: size.height * cam.yScale)
        
        // get the frame of the entire level contents
        let boardContentRect = worldNode.calculateAccumulatedFrame()
        
        // inset that frame from the edges of the level
        // inset by `scaledSize / 2 - 100` to show 100 pt of black around the level
        // (no need for `- 100` if you want zero padding)
        // use min() to make sure we don't inset too far if the level is small
        let xInset = min((scaledSize.width / 2) - 100.0, boardContentRect.width / 2)
        let yInset = min((scaledSize.height / 2) - 100.0, boardContentRect.height / 2)
        let insetContentRect = boardContentRect.insetBy(dx: xInset, dy: yInset)
        
        // use the corners of the inset as the X and Y range of a position constraint
        let xRange = SKRange(lowerLimit: insetContentRect.minX + 1700, upperLimit: insetContentRect.maxX + 1000)
        let yRange = SKRange(lowerLimit: insetContentRect.minY + 1000, upperLimit: insetContentRect.maxY + 1000)
        let levelEdgeConstraint = SKConstraint.positionX(xRange, y: yRange)
        levelEdgeConstraint.referenceNode = worldNode
        let zeroRange = SKRange(constantValue: 0.0)
        let playerBotLocationConstraint = SKConstraint.distance(zeroRange, to: player.position)
        cam.constraints = [playerBotLocationConstraint, levelEdgeConstraint]

        player.addChild(cam);
        setupJoyStick()
    }
    
    private func moveCharacterLeft() {
        let newLocation = CGPoint(x: character.position.x + tileSize.width, y: character.position.y);
        SKAction.move(to: newLocation, duration: 0.5);
    }
    
    private func moveCharacterRight() {
        let newLocation = CGPoint(x: character.position.x - tileSize.width, y: character.position.y);
        SKAction.move(to: newLocation, duration: 0.5);
    }
    
    private func moveCharacterUp() {
        let newLocation = CGPoint(x: character.position.x, y: character.position.y + tileSize.height);
        SKAction.move(to: newLocation, duration: 0.5);
    }
    
    private func moveCharacterDown() {
        let newLocation = CGPoint(x: character.position.x, y: character.position.y - tileSize.height);
        SKAction.move(to: newLocation, duration: 0.5);
    }
    
    override func update(_ currentTime: TimeInterval) {
        let playerX = player.position.x;
        let playerY = player.position.y;

        let angle = joystick.data.angular
        if angle != 0 {
            self.camera!.zRotation = -angle - .pi / 2;
            self.player.zRotation = angle + .pi / 2;
        }
        self.button.isHidden = true;
        if (playerX > -300 && playerX < 300 && playerY > 350 && playerY < 950) {
            self.button.isHidden = false;
        }
        joystick.position.x = player.position.x - 350;
        joystick.position.y = player.position.y - 225;

    }

}
