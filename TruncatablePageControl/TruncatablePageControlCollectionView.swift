//
//  TruncatablePageControlCollectionView.swift
//  TruncatablePageControl
//
//  Created by Y.T. Hoshino on 2019/11/02.
//  Copyright © 2019 ge-nie inc. All rights reserved.
//

import UIKit

class TruncatablePageControlCollectionView: UICollectionView {
    private let config = LayoutConfig()
    private var selectedDot: SelectedDot = .large1
    var currentPage: Int = 0 {
        didSet {
            guard oldValue != currentPage else { return }
            let diff = currentPage - oldValue
            selectedDot = 0 < diff ? selectedDot.proceed(count: diff) : selectedDot.regress(count: abs(diff))
        }
    }
    var numberOfPages = 8 {
        didSet {
            currentPage = max(0, min(currentPage, numberOfPages - 1))
            reloadData()
            invalidateIntrinsicContentSize()
        }
    }
    var currentPageDotColor: UIColor?
    private var isTrancated: Bool {
        return config.maxDotNumber < numberOfPages
    }
    private var allCellCount: Int {
        return isTrancated ? config.maxDotNumber + 2 : numberOfPages + 2
    }
    private var visibleCellCount: Int {
        return isTrancated ? config.maxDotNumber : numberOfPages
    }

    enum SelectedDot {
        case large1
        case large2
        case large3
        
        var row: Int {
            switch self {
            case .large1:
                return 3
            case .large2:
                return 4
            case .large3:
                return 5
            }
        }
        
        func proceed(count: Int = 1) -> SelectedDot {
            switch self {
            case .large1 where count == 1:
                return .large2
            default:
                return .large3
            }
        }
        
        func regress(count: Int = 1) -> SelectedDot {
            switch self {
            case .large3 where count == 1:
                return .large2
            default:
                return .large1
            }
        }
    }
    
    override var intrinsicContentSize: CGSize {
        guard numberOfPages > 1 else { return .zero }
        return CGSize(width: config.itemSize * CGFloat(allCellCount) + config.space * CGFloat(allCellCount - 1), height: config.itemSize)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let bundle = Bundle(for: TruncatablePageControlCollectionViewCell.self)
        register(UINib(nibName: "TruncatablePageControlCollectionViewCell", bundle: bundle), forCellWithReuseIdentifier: "dotCell")
        delegate = self
        dataSource = self
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: config.itemSize, height: config.itemSize)
        flowLayout.minimumInteritemSpacing = config.space
        collectionViewLayout = flowLayout
    }
    
    func moveTo(page: Int) {
        currentPage = page
        reloadData()
    }
    
    func moveToNext() {
        guard currentPage < (numberOfPages - 1) else { return }
        let offSetDistance: CGFloat = {
            guard isTrancated else { return 0.0 }
            switch selectedDot {
            case .large1, .large2:
                return 0.0
            default:
                return config.itemSize + config.space
            }
        }()
        currentPage += 1
        
        UIView.animate(withDuration: 0.3, animations: {
            self.contentOffset.x += offSetDistance
        }, completion: { _ in
            self.reloadData()
            self.contentOffset.x -= offSetDistance
        })
    }
    
    func moveToPrev() {
        guard 0 < currentPage else { return }
        let offSetDistance: CGFloat = {
            guard isTrancated else { return 0.0 }
            switch selectedDot {
            case .large2, .large3:
                return 0.0
            default:
                return config.itemSize + config.space
            }
        }()
        currentPage -= 1
        UIView.animate(withDuration: 0.3, animations: {
            self.contentOffset.x -= offSetDistance
        }, completion: { _ in
            self.reloadData()
            self.contentOffset.x += offSetDistance
        })
    }
    
    func getDotState(indexPath: IndexPath) -> DotState {
        guard isTrancated else {
            return .large(selected: currentPage == (indexPath.row - 1))
        }
        switch indexPath.row {
        case 0:
            return (currentPage - (selectedDot.row - SelectedDot.large1.row)) > 1 ? .small : .none
        case 1:
            return (currentPage - (selectedDot.row - SelectedDot.large1.row)) > 1 ? .small : .none
        case 2:
            return (currentPage - (selectedDot.row - SelectedDot.large1.row)) > 0 ? .medium : .none
        case allCellCount - 3:
            return (currentPage - (selectedDot.row - SelectedDot.large3.row)) < numberOfPages - 1 ? .medium : .none
        case allCellCount - 2:
            return (currentPage - (selectedDot.row - SelectedDot.large3.row)) < numberOfPages - 2 ? .small : .none
        case allCellCount - 1:
            return (currentPage - (selectedDot.row - SelectedDot.large3.row)) < numberOfPages - 2 ? .small : .none
        default:
            return .large(selected: indexPath.row == selectedDot.row)
        }
    }
}

extension TruncatablePageControlCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allCellCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dotCell", for: indexPath) as! TruncatablePageControlCollectionViewCell
        cell.widthConstraint.constant = getDotSize(indexPath)
        cell.dotView.layer.cornerRadius = getDotSize(indexPath) / 2.0
        cell.dotView.clipsToBounds = true
        cell.dotView.backgroundColor = getBackgroundColor(indexPath)
        return cell
    }
    
    func getDotSize(_ indexPath: IndexPath) -> CGFloat {
        switch getDotState(indexPath: indexPath) {
        case .none:
            return 0.0
        case .small:
            return config.itemSize * config.smallDotRatio
        case .medium:
            return config.itemSize * config.mediumDotRatio
        case .large:
            return config.itemSize
        }
    }
    
    func getBackgroundColor(_ indexPath: IndexPath) -> UIColor {
        switch getDotState(indexPath: indexPath) {
        case .none:
            return UIColor.clear
        case .large(selected: true):
            return currentPageDotColor ?? UIColor.systemBlue
        default:
            return UIColor.systemGray
        }
    }
}
