//
//  BannerUsingCollectionView.swift
//  BannerPageview
//
//  Created by maochun on 2021/1/4.
//

import UIKit

class BannerUsingCollectionView: UIViewController {
    
    let numOfItems = 15
    let numOfSections = 1
    let lineSpace = 0
    lazy var itemSize = CGSize(width: self.view.frame.width - 100, height: 200)
    
    lazy var theCollectionView: UICollectionView = {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0)
        layout.sectionInsetReference = .fromSafeArea
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        //layout.scrollDirection = UICollectionView.ScrollDirection.vertical
        layout.scrollDirection = .horizontal
    
        let flowLayout = ZoomAndSnapFlowLayout()
        flowLayout.itemSize = CGSize(width: self.view.frame.width - 200, height: 200)
        print("itemSize = \(flowLayout.itemSize)")
        
        let theView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        theView.translatesAutoresizingMaskIntoConstraints = false
        theView.dataSource = self
        theView.delegate = self
        theView.backgroundColor = .white
        
        theView.contentInsetAdjustmentBehavior = .always
        theView.showsHorizontalScrollIndicator = false
        theView.isPagingEnabled = true
        
        theView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        self.view.addSubview(theView)
        
        
        NSLayoutConstraint.activate([
            theView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 120),
            //theView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -10),
            theView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0),
            theView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0),
            theView.heightAnchor.constraint(equalToConstant: 230)
        ])
        
        
        return theView
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        
        let _ = self.theCollectionView
    }

}


extension BannerUsingCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return numOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.numOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = indexPath.row % 2 == 0 ? UIColor.orange : UIColor.brown
        return cell

    }
    
    /*
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {

        return CGFloat(self.lineSpace)
     
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        

        return itemSize
    }
    
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let contentOffset = targetContentOffset.pointee.x
        let targetItem = lround(Double(contentOffset/190))
        self.theCollectionView.scrollToItem(at: IndexPath(item: targetItem, section: 0), at: .left, animated: true)
    }
     */
}
