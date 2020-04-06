//
//  DetailVC.swift
//  MehilainenAssignment
//
//  Created by Joni Tefke on 1.4.2020.
//  Copyright © 2020 jonitefke. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {

    var detailView = DetailView()
    var program: Program?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configDetail()
    }
    
    func configDetail() {
        view.addSubview(detailView)
        detailView.pin(to: view)
        detailView.program = program
    }
}
