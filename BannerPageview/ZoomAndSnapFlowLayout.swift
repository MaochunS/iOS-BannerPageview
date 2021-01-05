//
//  ZoomAndSnapFlowLayout.swift
//  BannerPageview
//
//  Created by maochun on 2021/1/4.
//

import UIKit

class ZoomAndSnapFlowLayout: UICollectionViewFlowLayout {

    //let activeDistance: CGFloat = 200
    let zoomFactor: CGFloat = 0.3

    override init() {
        super.init()

        scrollDirection = .horizontal
        minimumLineSpacing = 40
        //itemSize = CGSize(width: 150, height: 150)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepare() {
        guard let collectionView = collectionView else { fatalError() }
        let verticalInsets = (collectionView.frame.height - collectionView.adjustedContentInset.top - collectionView.adjustedContentInset.bottom - itemSize.height) / 2
        let horizontalInsets = (collectionView.frame.width - collectionView.adjustedContentInset.right - collectionView.adjustedContentInset.left - itemSize.width) / 2
        sectionInset = UIEdgeInsets(top: verticalInsets, left: horizontalInsets, bottom: verticalInsets, right: horizontalInsets)
        //sectionInset = UIEdgeInsets(top: 200, left: horizontalInsets, bottom: verticalInsets, right: horizontalInsets)

        super.prepare()
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    
        guard let collectionView = collectionView else { return nil }
        //print("frame size \(collectionView.frame.size)")
        
        let rectAttributes = super.layoutAttributesForElements(in: rect)!.map { $0.copy() as! UICollectionViewLayoutAttributes }
        
        //print("rect \(rectAttributes)")
        
        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.frame.size)

        // Make the cells be zoomed when they reach the center of the screen
        for attributes in rectAttributes where attributes.frame.intersects(visibleRect) {
            let distance = abs(visibleRect.midX - attributes.center.x)
            
            /*
            let normalizedDistance = distance / activeDistance

            if distance.magnitude < activeDistance {
                let zoom = 1 + zoomFactor * (1 - normalizedDistance.magnitude)
                attributes.transform3D = CATransform3DMakeScale(zoom, zoom, 1)
                attributes.zIndex = Int(zoom.rounded())
            }
            */
            
            if distance < collectionView.frame.width / 2{
                let zoom = 1 + zoomFactor * (1 - distance / (collectionView.frame.width * 0.5))
                attributes.transform3D = CATransform3DMakeScale(zoom, zoom, 1)
                attributes.zIndex = Int(zoom.rounded())
            }
        }

        return rectAttributes
    }

    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        
        /*
        var minSpace = CGFloat.greatestFiniteMagnitude
        var offset = proposedContentOffset
        if let collectionView = collectionView {
            let centerX = offset.x + collectionView.bounds.size.width/2
            let centerY = offset.y + collectionView.bounds.size.height/2
            var visibleRect: CGRect
            if scrollDirection == .horizontal {
                visibleRect = CGRect(origin: CGPoint(x: offset.x, y: 0), size: collectionView.bounds.size)
            } else {
                visibleRect = CGRect(origin: CGPoint(x: 0, y: offset.y), size: collectionView.bounds.size)
            }
            if let attris = layoutAttributesForElements(in: visibleRect) {
                for attri in attris {
                    if scrollDirection == .horizontal {
                        if abs(minSpace) > abs(attri.center.x-centerX) {
                            minSpace = attri.center.x-centerX
                        }
                    } else {
                        if abs(minSpace) > abs(attri.center.y-centerY) {
                            minSpace = attri.center.y-centerY
                        }
                    }
                }
            }
            if scrollDirection == .horizontal {
                offset.x += minSpace
            } else {
                offset.y += minSpace
            }
        }
        return offset
        */
        
         
        guard let collectionView = collectionView else { return .zero }
         
        // Add some snapping behaviour so that the zoomed cell is always centered
        let targetRect = CGRect(x: proposedContentOffset.x, y: 0, width: collectionView.frame.width, height: collectionView.frame.height)
        guard let rectAttributes = super.layoutAttributesForElements(in: targetRect) else { return .zero }

        var offsetAdjustment = CGFloat.greatestFiniteMagnitude
        let horizontalCenter = proposedContentOffset.x + collectionView.frame.width / 2

        var rectAttrShow = rectAttributes[0]
        for layoutAttributes in rectAttributes {
            let itemHorizontalCenter = layoutAttributes.center.x
            
            
            print("rect  \(layoutAttributes.center.x) \(layoutAttributes)")
            
            /*
            if (itemHorizontalCenter - horizontalCenter).magnitude < offsetAdjustment.magnitude {
                offsetAdjustment = itemHorizontalCenter - horizontalCenter
                
            }
            */
            
            if abs(itemHorizontalCenter - horizontalCenter) < abs(offsetAdjustment) {
                offsetAdjustment = itemHorizontalCenter - horizontalCenter
                //rectAttrShow = layoutAttributes
            }
        }
        
        print("targetContentOffset \(collectionView.frame.width) \(proposedContentOffset.x) ")

        
        //return CGPoint(x: proposedContentOffset.x + offsetAdjustment, y: proposedContentOffset.y)
        
        print("targetContentOffset \(rectAttrShow.center.x - 190 * 0.5 - 20) \(proposedContentOffset.y) ")
        return CGPoint(x:rectAttrShow.center.x - 190 * 0.5 - 20, y: proposedContentOffset.y)
        
        //return CGPoint(x: proposedContentOffset.x, y: proposedContentOffset.y)
        
       /*
        let targetRect = CGRect(x: proposedContentOffset.x, y: 0, width: collectionView.frame.width, height: collectionView.frame.height)
        guard let rectAttributes = super.layoutAttributesForElements(in: targetRect) else { return .zero }

        var offsetAdjustment = CGFloat.greatestFiniteMagnitude
        let horizontalCenter = proposedContentOffset.x + collectionView.frame.width / 2

        for layoutAttributes in rectAttributes {
            let itemHorizontalCenter = layoutAttributes.center.x
            if (itemHorizontalCenter - horizontalCenter) < (offsetAdjustment) {
                offsetAdjustment = itemHorizontalCenter - horizontalCenter
            }
        }

        print("targetContentOffset \(proposedContentOffset.x) \(offsetAdjustment) \(proposedContentOffset.x + offsetAdjustment)")
    
        return CGPoint(x: proposedContentOffset.x + offsetAdjustment, y: proposedContentOffset.y)
        */
    }

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        // Invalidate layout so that every cell get a chance to be zoomed when it reaches the center of the screen
        return true
    }

    /*
    override func invalidationContext(forBoundsChange newBounds: CGRect) -> UICollectionViewLayoutInvalidationContext {
        let context = super.invalidationContext(forBoundsChange: newBounds) as! UICollectionViewFlowLayoutInvalidationContext
        context.invalidateFlowLayoutDelegateMetrics = newBounds.size != collectionView?.bounds.size
        return context
    }
    */
}
