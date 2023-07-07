//
//  ViewController.swift
//  News App
//
//  Created by Yogesh on 7/4/23.
//

import UIKit
import SafariServices



// Api key: 6c6dc38b321b4d298cf37b19c296f9aa

class ViewController: UIViewController {
    
    var viewModel : ViewControllerViewModel?
    var allData : AllData? {
        didSet{
            DispatchQueue.main.async {
                self.tv.reloadData()
            }
        }
    }
    
    let tv = UITableView()
    let mainStack : UIStackView = {
        let sv = UIStackView()
        sv.distribution = .fill
        sv.alignment = .fill
        sv.axis = .horizontal
        sv.spacing = 10
        return sv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        viewModel?.getData()
        
        self.view.backgroundColor = .white
        self.title = "News App"
        
        tv.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        tv.dataSource = self
        tv.delegate = self
        tv.reloadData()
        
        mainStack.addArrangedSubview(tv)
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(mainStack)
        
        let safeArea = self.view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
        
            mainStack.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10),
            mainStack.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -10),
            mainStack.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10),
            mainStack.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10)
        ])
    }
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("All Count", allData?.allArticles.count)
        return viewModel?.getRowCount() ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tv.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier) as? CustomTableViewCell else { return UITableViewCell() }
        
        
        cell.model = viewModel?.getCellData(rowNumber: indexPath.row)
        return cell

        
    }
    
    
}

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tv.deselectRow(at: indexPath, animated: true)
        
        let url = allData?.allArticles[indexPath.row].url ?? ""
        let vc = SFSafariViewController(url: URL(string: url)!)
        present(vc, animated: true)
        
//        let svc = SecondViewController()
//        svc.articleDetails = allData?.allArticles[indexPath.row]
//        navigationController?.pushViewController(svc, animated: true)
        
    }
}
