//
//  ReleasesInterfaceController.swift
//  HBO
//
//  Created by Jose Angel Cuadrado on 18/1/17.
//  Copyright © 2017 UPSA. All rights reserved.
//

import WatchKit
import Foundation
import Alamofire

class ReleasesInterfaceController: WKInterfaceController {

    @IBOutlet var table: WKInterfaceTable!
    @IBOutlet var movie: WKInterfaceMovie!
    @IBOutlet var separator: WKInterfaceSeparator!
    @IBOutlet var loadingLabel: WKInterfaceLabel!
    
    var releases: [[String: String]] = []

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        setTitle("Estrenos")
        table.setHidden(true)
        movie.setHidden(true)
        separator.setHidden(true)
        loadingLabel.setHidden(false)
        
        let movieURL = Bundle.main.url(forResource: "got", withExtension: "mov")
        movie.setMovieURL(movieURL!)

        Alamofire.request(URL(string: "http://private-a6537-hboupsa.apiary-mock.com/releases")!, method: .get, parameters: nil).responseJSON { (dataResponse) in
            guard dataResponse.result.isSuccess else {
                print("Error while fetching releases: \(dataResponse.result.error)")
                return
            }
            
            guard let releasesList = dataResponse.result.value as? [[String: String]] else {
                print("Malformed data received")
                return
            }
            
            print(releasesList)
            self.releases = releasesList
            self.loadingLabel.setHidden(true)
            self.movie.setHidden(false)
            self.separator.setHidden(false)
            self.table.setHidden(false)
            self.setupTable()
        }
    }
    
    func setupTable() {
        table.setNumberOfRows(releases.count, withRowType: "RowRelease")
        for i in 0 ..< releases.count {
            let row = table.rowController(at: i) as! RowReleaseController
            let release = releases[i]
            row.titleRelease.setText(release["title"]!)
            row.dateRelease.setText(release["date"]!)
        }
    }

}

class RowReleaseController: NSObject {
    
    @IBOutlet var titleRelease: WKInterfaceLabel!
    @IBOutlet var dateRelease: WKInterfaceLabel!
    
}
