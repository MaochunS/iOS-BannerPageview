//
//  TestViewController.swift
//  BannerPageview
//
//  Created by maochun on 2021/1/4.
//

import UIKit

class TestViewController: UIViewController {

    lazy var titleLabel : UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.init(name: "Arial", size: 40)
        label.text = ""
        label.textColor = .white
        label.textAlignment = NSTextAlignment.center
        
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        
        self.view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = .gray
        
        let _ = self.titleLabel
        
        //self.preferredContentSize = CGSize(width: self.view.frame.width - 50, height: 200)
    }
    
 
}
