//
//  TallyCollectionViewCell.swift
//  Tally
//
//  Created by Matt Beaney on 29/10/2016.
//  Copyright © 2016 Matt Beaney. All rights reserved.
//

import Foundation
import UIKit

class TallyCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var number: UILabel!
    
    var tally: Tally? {
        didSet {
            self.configure()
        }
    }
    
    func configure() {
        self.bgView.backgroundColor = UIColor.lightGray
        self.type.text = self.tally!.type
        self.number.text = String(self.tally!.count)
        
        UIView.animate(withDuration: 0.5) {
            self.bgView.backgroundColor = self.tally!.backgroundColor ?? UIColor.lightGray
        }
        
        bgView.layer.shadowColor = UIColor.black.cgColor
        bgView.layer.shadowOpacity = 0.7
        bgView.layer.shadowOffset = CGSize.zero
        bgView.layer.shadowRadius = 2
    }
}
