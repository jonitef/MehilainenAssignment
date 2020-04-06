//
//  ErrorView.swift
//  MehilainenAssignment
//
//  Created by Joni Tefke on 5.4.2020.
//  Copyright © 2020 jonitefke. All rights reserved.
//

import UIKit

class ErrorView: UIView {

    let errorLabel: UILabel = {
        let label = UILabel()
        label.text = "Jokin meni vikaan, emme löytäneet julkaisuja. Yritä myöhemmin uudelleen."
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configLabel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configLabel() {
        addSubview(errorLabel)
        errorLabel.pin(to: self)
    }
}
