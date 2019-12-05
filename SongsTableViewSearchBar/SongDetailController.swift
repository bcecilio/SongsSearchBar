//
//  SongDetailController.swift
//  SongsTableViewSearchBar
//
//  Created by Brendon Cecilio on 12/5/19.
//  Copyright © 2019 C4Q . All rights reserved.
//

import UIKit

class SongDetailController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var songLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
   
    var songDetail: Song!

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        
        songLabel.text = songDetail.name
        artistLabel.text = songDetail.artist
        imageView.image = UIImage(imageLiteralResourceName: "loveSongs")
    }
}
