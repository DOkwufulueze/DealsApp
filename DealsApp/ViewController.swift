//
//  ViewController.swift
//  DealsApp
//
//  Created by Okwufulueze Daniel on 05/06/2016.
//  Copyright © 2016 Okwufulueze Daniel. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    var imagesCache = [String: UIImage]()
    var images = [String]()
    var deals = [[String: AnyObject]]()
    var variants = [Int: [String: AnyObject]]()
    var dealsCache = [Int: [String: AnyObject]]()
    var perSection = 1
    var perPage = 10
    var currentPage = 1
    var urlString = String()
    var totalEntries = 0
    var totalPages = 0
    var kk = [NSString]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSizeMake(130, 170)
        self.collectionView.setCollectionViewLayout(layout, animated: true)
        getJSON()
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "dealDetail") {
            if let destination = segue.destinationViewController as? DealDetailViewController {
                let selectedRow = collectionView.indexPathForCell(sender as! UICollectionViewCell)!.row
                let dealId = deals[selectedRow]["id"]! as? Int
                let discountedPrice = variants[dealId!]!["discounted_price"] as? Double
                destination.titleString = deals[selectedRow]["title"] as? String
                destination.shortTitle = deals[selectedRow]["title"] as? String
                destination.saving = variants[dealId!]!["saving"] as? Int
                destination.sold = variants[dealId!]!["bought_count"] as? Int
                destination.discountedPrice = discountedPrice!
                destination.percentOff = variants[dealId!]!["percent_discount"] as? String
                destination.hoverLocation = deals[selectedRow]["hover_location"] as? String
                destination.image = (imagesCache[(images[selectedRow])]!)
                destination.HTMLString = String(decodeHTMLString((variants[dealId!]!["highlights"] as? String)!)!)
            }
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: DealCell = collectionView.dequeueReusableCellWithReuseIdentifier("deal", forIndexPath: indexPath) as! DealCell
        if (imagesCache[deals[indexPath.row]["image"] as! String] == nil) {
            cacheDeal(deals[indexPath.row]["id"] as! Int, deal: deals[indexPath.row])
        } else {
            let image = imagesCache[images[indexPath.row]]
            let discountedPrice = dealsCache[deals[indexPath.row]["id"] as! Int]?["least_priced_variant"]!["discounted_price"] as? Double
            let listPrice = dealsCache[deals[indexPath.row]["id"] as! Int]?["least_priced_variant"]!["list_price"] as? Double
            let percentOff = Int(((listPrice! - discountedPrice!) / listPrice!) * 100)
            let shortTitle = dealsCache[deals[indexPath.row]["id"] as! Int]?["short_title"] as? String
            let hoverLocation = dealsCache[deals[indexPath.row]["id"] as! Int]?["hover_location"] as? String
//            let averageRating = RatingControl()
//            averageRating.setUpView()
//            averageRating.rating = (dealsCache[deals[indexPath.row]["id"] as! Int]?["average_rating"] as? Int)!
            cell.setLabels(image, shortTitle: shortTitle, discountedPrice: discountedPrice, listPrice: listPrice, percentOff: percentOff, hoverLocation: hoverLocation)
        }
        return cell
    }
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func cacheVariant(dealId: Int) {
        let urlString = ["http://localhost:3000/api/v1/deals/\(dealId)?access_key=android-testing", "http://pre-multi.dealdey.com/api/v1/deals/\(dealId)?access_key=android-testing"][0]
        let url: NSURL = NSURL(string: urlString)!
        let request = NSMutableURLRequest(URL: url)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) {
            (let data, let response, let error) in
            guard let _:NSData = data, let _:NSURLResponse = response  where error == nil else {
                return
            }
            
            let dataString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            self.extractVariantJSONData(dataString!, dealId: dealId)
        }
        task.resume()
    }
    
    func cacheDeal(dealId: Int, deal: [String: AnyObject]) {
        dealsCache[dealId] = deal
        useAndCacheImage(deal["image"] as! String, deal: deal)
        cacheVariant(dealId)
    }
    
    func useAndCacheImage(imageURLString: String, deal: [String: AnyObject]) {
        let session = NSURLSession.sharedSession()
        let url: NSURL = NSURL(string: imageURLString)!
        let request = NSMutableURLRequest(URL: url)
        request.timeoutInterval = 10
        let task = session.dataTaskWithRequest(request) {
            (let data, let response, let error) in
            guard let _:NSData = data, let _:NSURLResponse = response  where error == nil else {
                return
            }
            let image = UIImage(data: data!)
            if (image != nil) {
                self.imagesCache[deal["image"] as! String] = image
            } else {
                self.imagesCache[deal["image"] as! String] = UIImage(named: "defaultDeal")
            }
            
            dispatch_async(dispatch_get_main_queue(), self.refresh)
        }
        
        task.resume()
    }
    
    func extractJSONData(data: NSString) {
        let jsonData:NSData = data.dataUsingEncoding(NSASCIIStringEncoding)!
        let json: AnyObject?
        do {
            json = try NSJSONSerialization.JSONObjectWithData(jsonData, options: [])
        } catch {
            print(":::Error with JSON")
            return
        }
        
        guard let dealsArray = json?.valueForKey("deals") as? [[String: AnyObject]] else {
            print(":::Error")
            return
        }
        
        self.perPage = (json?.valueForKey("per_page") as? Int)!
        self.currentPage = (json?.valueForKey("current_page") as? Int)!
        self.totalEntries = (json?.valueForKey("total_entries") as? Int)!
        self.totalPages = (json?.valueForKey("total_pages") as? Int)!
        
        for deal in dealsArray {
            deals.append(deal)
            images.append(deal["image"] as! String)
        }
        
        dispatch_async(dispatch_get_main_queue(), refresh)
    }
    
    func extractVariantJSONData(data: NSString, dealId: Int) {
        if let jsonData:NSData = data.dataUsingEncoding(NSASCIIStringEncoding) {
            let json: AnyObject?
            do {
                json = try NSJSONSerialization.JSONObjectWithData(jsonData, options: [])
            } catch {
                print(":::Error with JSON")
                return
            }
        
            guard let variants = json?.valueForKey("deal") as? [String: AnyObject] else {
                print(":::Error")
                return
            }
            
            self.variants[dealId] = variants
//          dispatch_async(dispatch_get_main_queue(), refresh)
        }
    }
    
    func refresh() {
        self.collectionView.reloadData()
    }
    
    func getJSON() {
        urlString = ["http://localhost:3000/api/v1/deals?access_key=android-testing&page=\(self.currentPage)&per_page=\(self.perPage)", "http://pre-multi.dealdey.com/api/v1/deals?access_key=android-testing&page=\(self.currentPage)&per_page=\(self.perPage)"][0]
        let url: NSURL = NSURL(string: urlString)!
        let session = NSURLSession.sharedSession()
        let request = NSMutableURLRequest(URL: url)
        request.timeoutInterval = 10
        let task = session.dataTaskWithRequest(request) {
            (let data, let response, let error) in
            guard let _:NSData = data, let _:NSURLResponse = response  where error == nil else {
                return
            }
            
            let dataString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            self.extractJSONData(dataString!)
        }
        task.resume()
    }
    
    func decodeHTMLString(HTMLString: String) -> NSAttributedString? {
        let encodedData = HTMLString.dataUsingEncoding(NSUTF8StringEncoding)!
        do {
            return try NSAttributedString(data: encodedData, options: [NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType,NSCharacterEncodingDocumentAttribute:NSUTF8StringEncoding], documentAttributes: nil)
        } catch let error as NSError {
            print(error.localizedDescription)
            return nil
        }
    }
}

