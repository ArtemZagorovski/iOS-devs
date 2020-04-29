//
//  WeatherCell.swift
//  YOUCAN
//
//  Created by Артем  on 4/17/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {
    
    var weather : Weather? {
        didSet {
            guard let weather = weather else { return }
            temperatureLabel.text = weather.temperatureString
            feelLikeLabel.text = weather.feelLikeTempString
            weatherIcon.image = weather.icon
        }
    }
    
    private let locationLabel : UILabel = {
        let lbl = UILabel()
        lbl.text = "location"
        lbl.textColor = .black
        lbl.textAlignment = .left
        return lbl
    }()
    
    private let temperatureLabel : UILabel = {
        let lbl = UILabel()
        lbl.text = "temperature"
        lbl.textColor = .black
        lbl.textAlignment = .left
        return lbl
    }()
    
    private let feelLikeLabel : UILabel = {
        let lbl = UILabel()
        lbl.text = "Feel like"
        lbl.textColor = .black
        lbl.textAlignment = .left
        return lbl
    }()
    
    private let rainLabel : UILabel = {
        let lbl = UILabel()
        lbl.text = "Rain"
        lbl.textColor = .black
        lbl.textAlignment = .left
        return lbl
    }()
    
    private let adviceLabel : UILabel = {
        let lbl = UILabel()
        lbl.text = "Advice"
        lbl.textColor = .black
        lbl.textAlignment = .left
        return lbl
    }()
    
    private let weatherIcon : UIImageView = {
        let imageName = "clear-day"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let stackViewV = UIStackView(arrangedSubviews: [locationLabel, temperatureLabel, feelLikeLabel, rainLabel, adviceLabel])
        stackViewV.axis = .vertical
        stackViewV.alignment = .leading
        stackViewV.distribution = .fillEqually
        addSubview(stackViewV)
        stackViewV.translatesAutoresizingMaskIntoConstraints = false
        
        weatherIcon.translatesAutoresizingMaskIntoConstraints = false
        weatherIcon.heightAnchor.constraint(equalToConstant: 150).isActive = true
        weatherIcon.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        let stackViewH = UIStackView(arrangedSubviews: [stackViewV, weatherIcon])
        stackViewH.axis = .horizontal
        stackViewH.alignment = .fill
        stackViewH.distribution = .fillEqually
        addSubview(stackViewH)
        
        stackViewH.translatesAutoresizingMaskIntoConstraints = false
        stackViewH.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
        stackViewH.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        stackViewH.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15).isActive = true
        stackViewH.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

