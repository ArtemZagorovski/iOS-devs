//
//  GoalProgrammCell.swift
//  YOUCAN
//
//  Created by Артем  on 4/20/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import UIKit

class GoalProgrammCell: UITableViewCell {

    var goal : Goal? {
        didSet {
            guard let goal = goal else {
                titleLabel.alpha = 0.2
                progressView.alpha = 0.2
                persentLabel.alpha = 0.2
                doItButton.alpha = 0.2
                goalTypeIcon.alpha = 0.2
                return
            }
            
            titleLabel.text = goal.title
            progressView.progress = (goal.progress)
            persentLabel.text = "\(Int(goal.progress * 100)) %"
        }
    }
        
        private let titleLabel : UILabel = {
            let lbl = UILabel()
            lbl.text = "Title"
            lbl.textColor = .black
            lbl.textAlignment = .left
            return lbl
        }()
        
        private let doItButton : UIButton = {
            let doIt = UIButton()
            doIt.setTitle("Do It!", for: .normal)
            doIt.setTitleColor(.blue, for: .normal)
            return doIt
        }()
        
        private let progressView : UIProgressView = {
            let progress = UIProgressView()
            let transform = CGAffineTransform(scaleX: 1.0, y: 10.0)
            progress.transform = transform
            progress.layer.cornerRadius = 10
            progress.clipsToBounds = true
            progress.layer.sublayers![1].cornerRadius = 10
            
            progress.subviews[1].clipsToBounds = true
            return progress
        }()
        
        private let persentLabel : UILabel = {
            let lbl = UILabel()
            lbl.text = "%"
            lbl.textColor = .black
            lbl.textAlignment = .left
            return lbl
        }()
        
        private let goalTypeIcon : UIImageView = {
            let imageName = "clear-day"
            let image = UIImage(named: imageName)
            let imageView = UIImageView(image: image!)
            imageView.contentMode = .scaleAspectFit
            imageView.clipsToBounds = true
            return imageView
        }()
    
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            addSubview(titleLabel)
            addSubview(doItButton)
            addSubview(progressView)
            addSubview(persentLabel)
            addSubview(goalTypeIcon)
            
            goalTypeIcon.translatesAutoresizingMaskIntoConstraints = false
            goalTypeIcon.widthAnchor.constraint(equalToConstant: 60).isActive = true
            goalTypeIcon.heightAnchor.constraint(equalToConstant: 60).isActive = true
            goalTypeIcon.topAnchor.constraint(equalTo: topAnchor, constant: 12).isActive = true
            goalTypeIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
            
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            titleLabel.leadingAnchor.constraint(equalTo: goalTypeIcon.trailingAnchor, constant: 14).isActive = true
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 30).isActive = true
            
            doItButton.translatesAutoresizingMaskIntoConstraints = false
            doItButton.topAnchor.constraint(equalTo: topAnchor, constant: 30).isActive = true
            doItButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
            
            persentLabel.translatesAutoresizingMaskIntoConstraints = false
            persentLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 195).isActive = true
            persentLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -150).isActive = true
            persentLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
            persentLabel.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 20).isActive = true
            
            progressView.translatesAutoresizingMaskIntoConstraints = false
            //progressView.bottomAnchor.constraint(equalTo: persentLabel.topAnchor, constant: 20)
            progressView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
            progressView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        }
        
         required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
         }
}
