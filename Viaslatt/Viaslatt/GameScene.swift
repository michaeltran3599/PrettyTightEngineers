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
        worldNode = self.childNode(withName: "WorldNode") as! SKTileMapNode;
        player = SKSpriteNode(color: UIColor.cyan, size: CGSize(width: 90, height: 90));
        player.anchorPoint = CGPoint(x: 0.5, y: 0.5);
        player.position = CGPoint(x: 0, y: 0);
        self.addChild(player)
        player.addChild(cam);
        
        setupJoyStick()
        character.position.x = 0;
        character.position.y = 0;
        character.color = UIColor.red;
        character.size.height = 1000;
        character.size.width = 1000;


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
        joystick.position.x = player.position.x - tileSize.width * 3.5;
        joystick.position.y = player.position.y - tileSize.height * 1.5;
    }

}
