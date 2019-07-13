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
    var waterTestNode:SKTileMapNode = SKTileMapNode();
    var character:SKSpriteNode = SKSpriteNode();
    let tileSet = SKTileSet(named: "Sample Grid Tile Set")!;
    let tileSize = CGSize(width: 128, height: 128)
    let columns = 128
    let rows = 128
    
    override func sceneDidLoad() {
        character.position.x = 0;
        character.position.y = 0;
        character.color = UIColor.red;
        character.size.height = 50;
        character.size.width = 50;
        self.addChild(character);
        let waterTiles = tileSet.tileGroups.first { $0.name == "Water" }
        let grassTiles = tileSet.tileGroups.first { $0.name == "Grass"}
        let sandTiles = tileSet.tileGroups.first { $0.name == "Sand"}
        
        let bottomLayer = SKTileMapNode(tileSet: tileSet, columns: columns, rows: rows, tileSize: tileSize)
        bottomLayer.fill(with: sandTiles)
        
        for node in self.children {
            if node.name == "Water Test" {
                waterTestNode = node as! SKTileMapNode;
            }
        }
        print(waterTestNode.tileDefinition(atColumn: 4, row: 5));
    }
    
    private func moveCharacterLeft() {
        var newLocation = CGPoint(x: character.position.x + tileSize.width, y: character.position.y);
        SKAction.move(to: newLocation, duration: 0.5s);
    }
    
    private func moveCharacterRight() {
        character.position.x += tileSize.width;
    }
    
    private func moveCharacterUp() {
        character.position.y += tileSize.height;
    }
    
    private func moveCharacterDown() {
        character.position.y -= tileSize.height;
    }
    
    keydown
}
