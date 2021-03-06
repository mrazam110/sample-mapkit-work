//
//  ImagesViewController.swift
//  SampleMapKit
//
//  Created by Muhammad Raza on 08/08/2015.
//  Copyright (c) 2015 Muhammad Raza. All rights reserved.
//

import UIKit

class ImagesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var pavilionId = ""
    
    var images:[UIImage] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.navigationItem.title = pavilionId
        
        if pavilionId == "Pavilion 1" {
            images.append(UIImage(named: "01")!)
            images.append(UIImage(named: "02")!)
        }else if pavilionId == "Pavilion 2" {
            images.append(UIImage(named: "03")!)
            images.append(UIImage(named: "04")!)
        }
        
        self.collectionView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("imgcell", forIndexPath: indexPath) as! ImageCollectionViewCell
        
        cell.imgView.image = self.images[indexPath.row]
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
}
