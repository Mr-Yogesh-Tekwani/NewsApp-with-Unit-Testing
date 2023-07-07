//
//  SecondViewController.swift
//  News App
//
//  Created by Yogesh on 7/4/23.
//

import UIKit

class SecondViewController: UIViewController {

    
    var articleDetails : Article?
    let networkClient = NetworkClient()
    
    let scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    // Set up constraints for the scroll view to fill the entire view
    
    let mainStack : UIStackView = {
        let sv = UIStackView()
        sv.distribution = .fill
        sv.alignment = .fill
        sv.axis = .vertical
        sv.spacing = 25
        return sv
    }()
    
    let img : UIImageView = {
        let i = UIImageView()
        i.backgroundColor = .secondarySystemBackground
        i.contentMode = .scaleAspectFit
        //i.clipsToBounds = true
        return i
    }()
    
    let titleLabel : UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 25, weight: .medium)
        l.numberOfLines = 0
        return l
    }()
    
    let descLabel : UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 18, weight: .medium)
        l.numberOfLines = 0
        return l
    }()
    
    let sourceLabel : UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 13, weight: .medium)
        l.numberOfLines = 0
        return l
    }()
    
    let publishLabel : UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 13, weight: .medium)
        l.numberOfLines = 0
        return l
    }()
    
    let contentLabel : UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 13, weight: .medium)
        l.numberOfLines = 0
        return l
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        mainStack.addArrangedSubview(img)
        mainStack.addArrangedSubview(titleLabel)
        mainStack.addArrangedSubview(sourceLabel)
        mainStack.addArrangedSubview(publishLabel)
        mainStack.addArrangedSubview(contentLabel)
        mainStack.addArrangedSubview(descLabel)
        
        networkClient.fetchImage(link: articleDetails?.urlToImage ?? "", completionHandler: { data in
            DispatchQueue.main.sync {
                self.img.image = data
            }
        })
        
        titleLabel.text = articleDetails?.title ?? "No Data"
        sourceLabel.text = articleDetails?.source?.name ?? "No Data"
        publishLabel.text = articleDetails?.publishedAt ?? "No Data"
        contentLabel.text = articleDetails?.content ?? "No Data"
        descLabel.text = articleDetails?.description ?? "No Data"
        
        
        
        img.translatesAutoresizingMaskIntoConstraints = false
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(mainStack)
        self.view.addSubview(scrollView)
        
        let safeArea = self.view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
        
            img.widthAnchor.constraint(equalToConstant: 120),
            img.heightAnchor.constraint(equalToConstant: 100),
            scrollView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            mainStack.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
            mainStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            mainStack.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            mainStack.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20)
        ])
    }
}
