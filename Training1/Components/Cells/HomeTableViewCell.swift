
//
//  HomeTableviewCell.swift
//  Training1
//
//  Created by Sanledi Buli on 29/03/20.
//  Copyright © 2020 Working Home. All rights reserved.
//

import UIKit
import Reusable

class HomeTableViewCell: UITableViewCell, NibReusable{
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var contactLabel: UILabel!
    
    var cellModel: ContactModel? {
        didSet {
            updateUI()
        }
    }

    func updateUI() {
        guard let cellModel = cellModel else {
            return
        }
        
        statusLabel.text = cellModel.contact
        statusLabel.text = cellModel.status
    }
}
