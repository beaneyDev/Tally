//
//  ViewController.swift
//  Tally
//
//  Created by Matt Beaney on 29/10/2016.
//  Copyright © 2016 Matt Beaney. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let tally = TallyController.shared.retrieveTallies()[indexPath.row]
        TallyController.shared.incrementTally(tally: tally)
        self.collectionView.reloadItems(at: [indexPath])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return TallyController.shared.retrieveTallies().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell: TallyCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "tallyCell", for: indexPath) as? TallyCollectionViewCell {
            cell.tally = TallyController.shared.retrieveTallies()[indexPath.row]
            return cell
        }
        
        return UICollectionViewCell()
    }
}

