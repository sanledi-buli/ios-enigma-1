//
//  HomeViewController.swift
//  Training1
//
//  Created by Sanledi Buli on 28/03/20.
//  Copyright © 2020 Working Home. All rights reserved.
//

import UIKit

internal final class HomeViewController: ViewController {
    
    @IBOutlet weak var homeButton: UIButton!
    
    
    private var viewModel: HomeViewModel?
    
    init(viewModel: HomeViewModel) {
        super.init(nibName: "HomeViewController", bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
