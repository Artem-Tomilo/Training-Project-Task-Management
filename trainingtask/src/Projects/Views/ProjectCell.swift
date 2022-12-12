//
//  ProjectCell.swift
//  trainingtask
//
//  Created by Артем Томило on 9.12.22.
//

import UIKit

class ProjectCell: UITableViewCell {
    
    private let background = UIView(frame: .zero)
    private let nameLabel = UILabel(frame: .zero)
    private let descriptionLabel = UILabel(frame: .zero)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setup() {
        background.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textColor = .black
        nameLabel.numberOfLines = 0
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.textColor = .black
        descriptionLabel.numberOfLines = 0
        
        contentView.addSubview(background)
        background.addSubview(nameLabel)
        background.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            background.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            background.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            
            nameLabel.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: 10),
            nameLabel.topAnchor.constraint(equalTo: background.topAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: background.trailingAnchor),
            nameLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: 10),
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: background.trailingAnchor),
            descriptionLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5)
        ])
        
        nameLabel.layer.borderWidth = 0
        descriptionLabel.layer.borderWidth = 0
        nameLabel.font = UIFont.systemFont(ofSize: 20)
        descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        background.backgroundColor = .systemRed
    }
    
    func bindText(nameText: String, descriptionText: String) {
        nameLabel.text = nameText
        descriptionLabel.text = descriptionText
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            background.backgroundColor =  .gray
            nameLabel.textColor = .white
            descriptionLabel.textColor = .white
        } else {
            background.backgroundColor =  .white
            nameLabel.textColor = .black
            descriptionLabel.textColor = .black
        }
    }
}