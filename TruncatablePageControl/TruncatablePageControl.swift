//
//  TruncatablePageControl.swift
//  TruncatablePageControl
//
//  Created by Y.T. Hoshino on 2019/11/03.
//  Copyright © 2019 ge-nie inc. All rights reserved.
//

import Foundation
import UIKit

public class TruncatablePageControl: UIView {
    @IBOutlet private var leadingConstraint: NSLayoutConstraint!
    @IBOutlet private var trailingConstraint: NSLayoutConstraint!
    @IBOutlet var collectionView: TruncatablePageControlCollectionView!
    private let config = LayoutConfig()
    var numberOfPages = 7 {
        didSet {
            collectionView.numberOfPages = numberOfPages
        }
    }
    var currentPage = 0 {
        didSet {
            collectionView.currentPage = currentPage
        }
    }
    var currentPageDotColor: UIColor = UIColor.systemBlue
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    func moveTo(page: Int) {
        collectionView.moveTo(page: page)
    }
    
    func moveToNext() {
        collectionView.moveToNext()
    }
    
    func moveToPrev() {
        collectionView.moveToPrev()
    }
}

extension TruncatablePageControl {
    func commonInit() {
        let view = Bundle.main.loadNibNamed("TruncatablePageControl", owner: self, options: nil)?[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        
        leadingConstraint.constant = config.itemSize + config.space
        trailingConstraint.constant = config.itemSize + config.space
        
        collectionView.currentPageDotColor = currentPageDotColor
    }
}
