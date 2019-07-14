//
//  ScannerButton.swift
//  Viaslatt
//
//  Created by Michael Tran on 7/14/19.
//  Copyright © 2019 Michael Tran. All rights reserved.
//

import UIKit
import SpriteKit

class ScannerButton: SKSpriteNode {
    
    init() {
       
        // super.init(imageNamed:"bubble") You can't do this because you are not calling a designated initializer.
        let texture = SKTexture(imageNamed: "QRCodeScan.png")
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        self.color = UIColor.black;
        self.size.width = 100;
        self.size.height = 100;
        self.position.x = 0;
        self.position.y = 650;
        self.isHidden = true;
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override var isUserInteractionEnabled: Bool {
        set {
            // ignore
        }
        get {
            return true
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.scene?.view?.window?.rootViewController?.performSegue(withIdentifier: "GoToScanner", sender: nil)
    }
}
