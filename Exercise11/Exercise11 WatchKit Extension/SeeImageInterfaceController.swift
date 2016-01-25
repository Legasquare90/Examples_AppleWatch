//
//  SeeImageInterfaceController.swift
//  Exercise11
//
//  Created by Jose Angel Cuadrado on 26/1/16.
//  Copyright © 2016 UPSA. All rights reserved.
//

import WatchKit
import Foundation


class SeeImageInterfaceController: WKInterfaceController {

    @IBOutlet var image: WKInterfaceImage!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        if let imageData = NSUserDefaults.standardUserDefaults().objectForKey("imageData") {
            self.image.setImageData(imageData as? NSData)
        }
    }

}
