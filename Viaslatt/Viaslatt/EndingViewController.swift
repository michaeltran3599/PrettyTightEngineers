//
//  EndingViewController.swift
//  Viaslatt
//
//  Created by Michael Tran on 7/14/19.
//  Copyright © 2019 Michael Tran. All rights reserved.
//

import UIKit

class EndingViewController: UIViewController {

    @IBOutlet var endingScene: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        endingScene.loadGif(name: "safe_image.gif");
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
