//
//  HomeViewModel.swift
//  Training1
//
//  Created by Sanledi Buli on 28/03/20.
//  Copyright © 2020 Working Home. All rights reserved.
//

import RxSwift

class HomeViewModel {
    
    var arrayOfItems: [ContactModel] = []
    
    init() {
        var contact1 = ContactModel()
        contact1.contact = "Sanledi"
        contact1.status = "Active"
        
        var contact2 = ContactModel()
        contact2.contact = "Foo Bar"
        contact2.status = "Disable"
        arrayOfItems.append(contact1)
        arrayOfItems.append(contact2)
        
    }
}
