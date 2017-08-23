//
//  DealCollectionViewCell.swift
//  DealsApp
//
//  Created by Okwufulueze Daniel on 05/06/2016.
//  Copyright © 2016 Okwufulueze Daniel. All rights reserved.
//

import UIKit

class DealCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var shortTitleLabel: UILabel!
    @IBOutlet weak var discountedPriceLabel: UILabel!
    @IBOutlet weak var listPriceLabel: UILabel!
    @IBOutlet weak var percentOffLabel: UILabel!
    @IBOutlet weak var hoverLocationLabel: UILabel!
    @IBOutlet weak var merchantImage: UIImageView!
    @IBOutlet weak var wishlistImage: UIImageView!
    @IBOutlet weak var shareImage: UIImageView!

    func setLabels(image: UIImage?, shortTitle: String?, discountedPrice: Double?, listPrice: Double?, percentOff: Int?, hoverLocation: String?) {
//        let attributes = [
//            NSFontAttributeName: UIFont(name: "Georgia", size: 14.0)!,
//            NSForegroundColorAttributeName: UIColor.orangeColor(),
//            NSStrikethroughStyleAttributeName: NSNumber(integer: NSUnderlineStyle.StyleSingle.rawValue)
//        ]
        imageView.autoresizingMask = [UIViewAutoresizing.FlexibleBottomMargin, UIViewAutoresizing.FlexibleTopMargin, UIViewAutoresizing.FlexibleRightMargin, UIViewAutoresizing.FlexibleLeftMargin, UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        imageView.image = image!
        
        merchantImage.autoresizingMask = [UIViewAutoresizing.FlexibleBottomMargin, UIViewAutoresizing.FlexibleTopMargin, UIViewAutoresizing.FlexibleRightMargin, UIViewAutoresizing.FlexibleLeftMargin, UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        merchantImage.contentMode = UIViewContentMode.ScaleAspectFit
        merchantImage.image = UIImage(named: "merchantImage")
        
        wishlistImage.autoresizingMask = [UIViewAutoresizing.FlexibleBottomMargin, UIViewAutoresizing.FlexibleTopMargin, UIViewAutoresizing.FlexibleRightMargin, UIViewAutoresizing.FlexibleLeftMargin, UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        wishlistImage.contentMode = UIViewContentMode.ScaleAspectFit
        wishlistImage.image = UIImage(named: "wishlistImage")
        
        shareImage.autoresizingMask = [UIViewAutoresizing.FlexibleBottomMargin, UIViewAutoresizing.FlexibleTopMargin, UIViewAutoresizing.FlexibleRightMargin, UIViewAutoresizing.FlexibleLeftMargin, UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        shareImage.contentMode = UIViewContentMode.ScaleAspectFit
        shareImage.image = UIImage(named: "shareImage")
        
        shortTitleLabel.text = shortTitle!
        discountedPriceLabel.text = "₦\(discountedPrice!)" //String(discountedPrice!)
        listPriceLabel.text = "-₦\(listPrice!)-" //String(NSAttributedString(string: String(listPrice!), attributes: attributes))
        percentOffLabel.text = "\(percentOff!)% Off"
        hoverLocationLabel.text = hoverLocation!
    }
}
