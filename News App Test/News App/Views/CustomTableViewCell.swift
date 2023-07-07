//
//  CustomTableViewCell.swift
//  News App
//
//  Created by Yogesh on 7/4/23.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    var model: Model?{
        didSet{
            self.reloadData()
        }
    }
    let networkClient = NetworkClient()
    
    struct Model {
        var title : String?
        var desc: String?
        var source: String?
        var imgUrl: String?
    }
    
    
    static let identifier = "CustomTableViewCell"
    
    let mainStack : UIStackView = {
        let sv = UIStackView()
        sv.distribution = .fill
        sv.alignment = .fill
        sv.axis = .horizontal
        
        return sv
    }()
    
    let subStack : UIStackView = {
        let sv = UIStackView()
        sv.distribution = .fill
        sv.alignment = .fill
        sv.axis = .vertical
        
        return sv
    }()
    
    let titleLabel : UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 25, weight: .medium)
        l.numberOfLines = 2
        return l
    }()
    
    let descLabel : UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 18, weight: .light)
        l.numberOfLines = 1
        return l
    }()
    
    let sourceLabel : UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 13, weight: .semibold)
        return l
    }()
    
    let img : UIImageView = {
        let i = UIImageView()
        i.backgroundColor = .secondarySystemBackground
        i.contentMode = .scaleAspectFit
        //i.clipsToBounds = true
        return i
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        subStack.addArrangedSubview(titleLabel)
        subStack.addArrangedSubview(descLabel)
        subStack.addArrangedSubview(sourceLabel)
        mainStack.addArrangedSubview(subStack)
        mainStack.addArrangedSubview(img)
        
        img.translatesAutoresizingMaskIntoConstraints = false
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(mainStack)
        
        NSLayoutConstraint.activate([
            img.widthAnchor.constraint(equalToConstant: 120),
            img.heightAnchor.constraint(equalToConstant: 100),
            mainStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func reloadData() {
        
        guard let model = model else {
            return
        }
        
        networkClient.fetchImage(link: model.imgUrl ?? "", completionHandler: { data in
            DispatchQueue.main.async {
                if let data = data {
                    self.img.image = data
                }
                
            }
        })
        
        self.titleLabel.text = model.title
        self.descLabel.text = model.desc
        self.sourceLabel.text = model.source
        
        
        
    }
    
}
