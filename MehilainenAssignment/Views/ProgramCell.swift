//
//  ProgramCell.swift
//  MehilainenAssignment
//
//  Created by Joni Tefke on 1.4.2020.
//  Copyright © 2020 jonitefke. All rights reserved.
//

import UIKit

class ProgramCell: UITableViewCell {
    
    var program: Program? {
        didSet {
            configTitle()
            configTime()
            configYleImageView()
        }
    }
    
    private let yleImageView = UIImageView()
    private let titleLabel = UILabel()
    private let timeLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(yleImageView)
        addSubview(titleLabel)
        addSubview(timeLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configYleImageView() {
        yleImageView.translatesAutoresizingMaskIntoConstraints                                  = false
        
        yleImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive                  = true
        yleImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive     = true
        
        yleImageView.heightAnchor.constraint(equalToConstant: 40).isActive                      = true
        yleImageView.widthAnchor.constraint(equalToConstant: 76.5).isActive                     = true

        yleImageView.image = UIImage(named: "yle-tv1")
    }
    
    func configTitle() {
        titleLabel.translatesAutoresizingMaskIntoConstraints                                                = false
        
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive                           = true
        titleLabel.leadingAnchor.constraint(equalTo: yleImageView.trailingAnchor, constant: 16).isActive    = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive                = true
        titleLabel.bottomAnchor.constraint(equalTo: timeLabel.topAnchor, constant: -8).isActive             = true
        
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        titleLabel.text = program?.title["fi"] as? String
        
    }
    
    func configTime() {
        timeLabel.translatesAutoresizingMaskIntoConstraints                                                = false
        
        timeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive             = true
        timeLabel.leadingAnchor.constraint(equalTo: yleImageView.trailingAnchor, constant: 16).isActive    = true
        timeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive                = true
        timeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive                    = true
        
        timeLabel.numberOfLines = 0

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        if let date = dateFormatter.date(from:program?.publisher.startTime ?? "") {
            dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
            let dateString = dateFormatter.string(from: date)
                    
            timeLabel.text = dateString
        } else {
            timeLabel.text = ""
        }
    }
}
