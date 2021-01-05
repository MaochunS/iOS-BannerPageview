//
//  ViewController.swift
//  BannerPageview
//
//  Created by maochun on 2021/1/4.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var pageViewControl : UIPageViewController = {
        let pageViewCtrl = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: [UIPageViewController.OptionsKey.interPageSpacing: 20])
        pageViewCtrl.view.frame = CGRect.init(x: 0, y: 100, width: self.view.frame.width, height: 300)
        pageViewCtrl.delegate = self
        pageViewCtrl.dataSource = self
        
        
        self.addChild(pageViewCtrl)
        self.view.addSubview(pageViewCtrl.view)
        
        return pageViewCtrl
        
    }()
    
    lazy var testButton : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Banner Using CollectionView", for: .normal)
        btn.addTarget(self, action: #selector(testButtonAction), for: .touchUpInside)
        self.view.addSubview(btn)
        
        NSLayoutConstraint.activate([
            btn.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -100),
            btn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0)
        ])
        
        return btn
    }()
    
    var viewControllerArr = Array<UIViewController>()
    var selectedIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let _ = self.testButton
        
        for i in 0 ..< 3{
            let vc = TestViewController()
            vc.titleLabel.text = "Page \(i)"
            vc.view.tag = i
            //vc.preferredContentSize = CGSize(width: 200, height: 200)
            vc.view.frame = CGRect.init(x: 80, y: 100, width: self.view.frame.width-160, height: 200)
            vc.view.layer.cornerRadius = 10
            self.viewControllerArr.append(vc)
        }
        
        self.pageViewControl.setViewControllers([viewControllerArr[0]], direction: .forward, animated: false)
    }


    @objc func testButtonAction(){
        let vc = BannerUsingCollectionView()
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
}

extension ViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource{
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]){
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool){
        
       
        
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        var pageIndex = viewController.view.tag - 1
        if pageIndex < 0 {
            pageIndex = self.viewControllerArr.count - 1
        }
        selectedIndex = pageIndex
 
        return viewControllerArr[pageIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        
        var pageIndex = viewController.view.tag + 1
        if pageIndex >= self.viewControllerArr.count {
            pageIndex = 0
        }
        selectedIndex = pageIndex
   
        return viewControllerArr[pageIndex]
    }
    
    
}
