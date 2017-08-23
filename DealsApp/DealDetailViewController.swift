//
//  DealDetailViewController.swift
//  DealsApp
//
//  Created by Okwufulueze Daniel on 06/06/2016.
//  Copyright © 2016 Okwufulueze Daniel. All rights reserved.
//

import UIKit

class DealDetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var dealTitle: UILabel!
    @IBOutlet weak var discountPriceLabel: UILabel!
    @IBOutlet weak var percentOffLabel: UILabel!
    @IBOutlet weak var hoverLocationLabel: UILabel!
    @IBOutlet weak var savingLabel: UILabel!
    @IBOutlet weak var soldLabel: UILabel!
    @IBOutlet weak var gpsIcon: UIImageView!
    @IBOutlet weak var HTMLStringLabel: UILabel!
    
    var image: UIImage?
    var shortTitle: String?
    var titleString: String?
    var saving: Int?
    var sold: Int?
    var discountedPrice: Double?
    var percentOff: String?
    var hoverLocation: String?
    var HTMLString: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.autoresizingMask = [UIViewAutoresizing.FlexibleBottomMargin, UIViewAutoresizing.FlexibleTopMargin, UIViewAutoresizing.FlexibleLeftMargin, UIViewAutoresizing.FlexibleRightMargin, UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        imageView.image = image!
        
        gpsIcon.autoresizingMask = [UIViewAutoresizing.FlexibleBottomMargin, UIViewAutoresizing.FlexibleTopMargin, UIViewAutoresizing.FlexibleLeftMargin, UIViewAutoresizing.FlexibleRightMargin, UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        gpsIcon.contentMode = UIViewContentMode.ScaleAspectFit
        gpsIcon.image = UIImage(named: "gpsIcon")
        
        dealTitle.text = shortTitle!
        savingLabel.text = "₦\(saving!)"
        soldLabel.text = String(sold!)
        discountPriceLabel.text = "₦\(discountedPrice!)"
        percentOffLabel.text = "\(percentOff!)%"
        hoverLocationLabel.text = hoverLocation!
        HTMLStringLabel.text = HTMLString!
        title = titleString!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
