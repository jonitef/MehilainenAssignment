//
//  DetailView.swift
//  MehilainenAssignment
//
//  Created by Joni Tefke on 1.4.2020.
//  Copyright © 2020 jonitefke. All rights reserved.
//

import UIKit

class DetailView: UIView {
    
    var program: Program? {
        didSet {
            configImage()
            configYleImageView()
            configTitleLabel()
            configService()
            configStartTime()
            configEndTime()
            configDescription()
            configPublisher()
        }
    }
    var scrollView = UIScrollView()
    let imageView = UIImageView()
    let yleImageView = UIImageView()
    let serviceLabel = UILabel()
    let startTimeLabel = UILabel()
    let endTimeLabel = UILabel()
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let publisherLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        addSubview(scrollView)
        configScrollView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(imageView)
        scrollView.addSubview(descriptionLabel)
        scrollView.addSubview(yleImageView)
        scrollView.addSubview(serviceLabel)
        scrollView.addSubview(startTimeLabel)
        scrollView.addSubview(endTimeLabel)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(publisherLabel)
        
        scrollView.pin(to: self)
    }
    
    func configImage() {
        imageView.translatesAutoresizingMaskIntoConstraints                                         = false
        
        imageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32).isActive   = true
        imageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16).isActive        = true
        imageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive              = true
        
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 3
        
        guard let url = URL(string: "https://images.cdn.yle.fi/image/upload/w_400,h_400,c_fit/\(program?.image["id"] as? String ?? "").png") else {
            return
        }
        if let data = try? Data(contentsOf: url) {
            if let image = UIImage(data: data) {
                imageView.image = image
            }
        }
    }
    
    func configYleImageView() {
        yleImageView.translatesAutoresizingMaskIntoConstraints                                      = false
        
        yleImageView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8).isActive    = true
        yleImageView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor).isActive            = true
        yleImageView.heightAnchor.constraint(equalToConstant: 88).isActive                          = true
        yleImageView.widthAnchor.constraint(equalToConstant: 88).isActive                           = true
        
        yleImageView.image = UIImage(named: "yle-areena")
    }
    
    func configTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints                                                = false
        
        titleLabel.topAnchor.constraint(equalTo: yleImageView.topAnchor).isActive                           = true
        titleLabel.leadingAnchor.constraint(equalTo: yleImageView.trailingAnchor, constant: 16).isActive    = true
        titleLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor).isActive                    = true
        
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        titleLabel.text = program?.title["fi"] as? String
    }
    
    func configService() {
        serviceLabel.translatesAutoresizingMaskIntoConstraints                                         = false
        
        serviceLabel.widthAnchor.constraint(equalTo: imageView.widthAnchor).isActive                   = true
        serviceLabel.topAnchor.constraint(equalTo: yleImageView.bottomAnchor, constant: 8).isActive    = true
        serviceLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive              = true
        
        serviceLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        serviceLabel.numberOfLines = 0
        serviceLabel.text = "Katsottavissa: \(program?.publisher.service["id"] ?? "")"
    }
    
    func configStartTime() {
        startTimeLabel.translatesAutoresizingMaskIntoConstraints                                         = false
        
        startTimeLabel.widthAnchor.constraint(equalTo: imageView.widthAnchor).isActive                   = true
        startTimeLabel.topAnchor.constraint(equalTo: serviceLabel.bottomAnchor, constant: 8).isActive    = true
        startTimeLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive              = true
        
        startTimeLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        startTimeLabel.numberOfLines = 0
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        if let date = dateFormatter.date(from:program?.publisher.startTime ?? "") {
            dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
            let dateString = dateFormatter.string(from: date)
            
            startTimeLabel.text = "Alkaa: \(dateString)"
        } else {
            startTimeLabel.text = ""
        }
    }
    
    func configEndTime() {
        endTimeLabel.translatesAutoresizingMaskIntoConstraints                                         = false
        
        endTimeLabel.widthAnchor.constraint(equalTo: imageView.widthAnchor).isActive                   = true
        endTimeLabel.topAnchor.constraint(equalTo: startTimeLabel.bottomAnchor, constant: 8).isActive  = true
        endTimeLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive              = true
        
        endTimeLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        endTimeLabel.numberOfLines = 0
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        if let date = dateFormatter.date(from:program?.publisher.endTime ?? "") {
            dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
            let dateString = dateFormatter.string(from: date)
            
            endTimeLabel.text = "Päättyy: \(dateString)"
        } else {
            endTimeLabel.text = ""
        }
    }
    
    func configDescription() {
        descriptionLabel.translatesAutoresizingMaskIntoConstraints                                              = false
        
        descriptionLabel.widthAnchor.constraint(equalTo: imageView.widthAnchor).isActive                        = true
        descriptionLabel.topAnchor.constraint(equalTo: endTimeLabel.bottomAnchor, constant: 16).isActive        = true
        descriptionLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive                   = true
        
        descriptionLabel.numberOfLines = 0
        descriptionLabel.text = program?.description["fi"] as? String ?? "Valitettavasti ohjelman kuvausta ei löytynyt"
    }
    
    func configPublisher() {
        publisherLabel.translatesAutoresizingMaskIntoConstraints                                              = false
        
        publisherLabel.widthAnchor.constraint(equalTo: imageView.widthAnchor).isActive                        = true
        publisherLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 32).isActive    = true
        publisherLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16).isActive      = true
        publisherLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive                   = true
        
        publisherLabel.numberOfLines = 0
        publisherLabel.font = UIFont.italicSystemFont(ofSize: 12)
        publisherLabel.text = "Alkuperäinen julkaisija: \(program?.publisher.id ?? "Valitettavasti alkuperäistä julkaisijaa ei löytynyt")"
    }
}
