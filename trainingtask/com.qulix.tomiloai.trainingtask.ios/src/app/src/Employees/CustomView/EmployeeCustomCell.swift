import UIKit

class EmployeeCustomCell: UITableViewCell {
    
    private let background = UIView(frame: .zero)
    private let surnameLabel = EmployeeCustomCellLabel(frame: .zero)
    private let nameLabel = EmployeeCustomCellLabel(frame: .zero)
    private let patronymicLabel = EmployeeCustomCellLabel(frame: .zero)
    private let positionLabel = EmployeeCustomCellLabel(frame: .zero)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        surnameText = ""
        nameText = ""
        patronymicText = ""
        positionText = ""
    }
    
    private func setup() {
        background.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(background)
        background.addSubview(surnameLabel)
        background.addSubview(nameLabel)
        background.addSubview(patronymicLabel)
        background.addSubview(positionLabel)
        
        NSLayoutConstraint.activate([
            background.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            background.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            
            surnameLabel.leadingAnchor.constraint(equalTo: background.leadingAnchor),
            surnameLabel.topAnchor.constraint(equalTo: background.topAnchor),
            surnameLabel.bottomAnchor.constraint(equalTo: background.bottomAnchor),
            surnameLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.25),
            
            nameLabel.leadingAnchor.constraint(equalTo: surnameLabel.trailingAnchor),
            nameLabel.topAnchor.constraint(equalTo: background.topAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: background.bottomAnchor),
            nameLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.25),
            
            patronymicLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            patronymicLabel.topAnchor.constraint(equalTo: background.topAnchor),
            patronymicLabel.bottomAnchor.constraint(equalTo: background.bottomAnchor),
            patronymicLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.25),
            
            positionLabel.leadingAnchor.constraint(equalTo: patronymicLabel.trailingAnchor),
            positionLabel.topAnchor.constraint(equalTo: background.topAnchor),
            positionLabel.bottomAnchor.constraint(equalTo: background.bottomAnchor),
            positionLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.25),
        ])
        
        background.backgroundColor = .systemRed
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            background.backgroundColor =  .gray
            surnameLabel.textColor = .white
            nameLabel.textColor = .white
            patronymicLabel.textColor = .white
            positionLabel.textColor = .white
        } else {
            background.backgroundColor =  .white
            surnameLabel.textColor = .black
            nameLabel.textColor = .black
            patronymicLabel.textColor = .black
            positionLabel.textColor = .black
        }
    }
    
    var surnameText: String = "" {
        didSet {
            surnameLabel.text = surnameText
        }
    }
    
    var nameText: String = "" {
        didSet {
            nameLabel.text = nameText
        }
    }
    
    var patronymicText: String = "" {
        didSet {
            patronymicLabel.text = patronymicText
        }
    }
    
    var positionText: String = "" {
        didSet {
            positionLabel.text = positionText
        }
    }
}