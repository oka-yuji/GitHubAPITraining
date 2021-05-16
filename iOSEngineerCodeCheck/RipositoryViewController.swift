//
//  ViewController2.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class RipositoryViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var starLabel: UILabel!
    @IBOutlet weak var watchLabel: UILabel!
    @IBOutlet weak var forksLabel: UILabel!
    @IBOutlet weak var issuesLabel: UILabel!
    
    weak var searchViewController: SearchViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       guard
        let index = searchViewController?.index,
        let repository = searchViewController?.repositories[index] else { return }
        
        languageLabel.text = "Written in \(repository.language ?? "")"
        starLabel.text = "\(repository.stargazersCount ?? 0) stars"
        watchLabel.text = "\(repository.wachersCount ?? 0) watchers"
        forksLabel.text = "\(repository.forksCount ?? 0) forks"
        issuesLabel.text = "\(repository.openIssuesCount ?? 0) open issues"
        getImage()
        
    }
    
    func getImage(){
        
        guard
         let index = searchViewController?.index,
         let repository = searchViewController?.repositories[index] else { return }
        
        titleLabel.text = repository.fullName
        
        if let owner = repository.owner {
            if let imageUrl = owner.avatarUrl {
                URLSession.shared.dataTask(with: imageUrl) { [weak self] (data, res, err) in
                    if let data = data, let image = UIImage(data: data) {
                        DispatchQueue.main.async { [weak self] in
                            self?.imageView.image = image
                        }
                    }
                }.resume()
            }
        }
        
    }
    
}
