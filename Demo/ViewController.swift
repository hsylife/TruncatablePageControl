//
//  ViewController.swift
//  Demo
//
//  Created by Y.T. Hoshino on 2019/11/05.
//  Copyright © 2019 ge-nie inc. All rights reserved.
//

import UIKit
import TruncatablePageControl

class ViewController: UIViewController {
    @IBOutlet private var pageControl: TruncatablePageControl!
    @IBOutlet private var pageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageControl.numberOfPages = 20
        pageControl.currentPage = 0
        pageControl.currentPageDotColor = UIColor.blue
        pageLabel.text = pageControl.collectionView.currentPage.description
    }

    @IBAction func didTapNext() {
        pageControl.moveToNext()
        pageLabel.text = pageControl.collectionView.currentPage.description
    }
    
    @IBAction func didTapPrev() {
        pageControl.moveToPrev()
        pageLabel.text = pageControl.collectionView.currentPage.description
    }
    
    @IBAction func didTapMoveToLast() {
        pageControl.moveTo(page: pageControl.numberOfPages - 1)
        pageLabel.text = pageControl.collectionView.currentPage.description
    }
    
    @IBAction func didTapMoveToTop() {
        pageControl.moveTo(page: 0)
        pageLabel.text = pageControl.collectionView.currentPage.description
    }
}
