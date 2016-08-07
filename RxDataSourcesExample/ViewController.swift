//
//  ViewController.swift
//  RxDataSourcesExample
//
//  Created by Chan Fai Chong on 7/8/2016.
//  Copyright © 2016 Time Based Technology Limited. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class DataCell: UICollectionViewCell {
    var value: UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        value = UILabel(frame: self.contentView.bounds)
        value?.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.contentView.addSubview(value!)
    }
}


public struct CellViewModel {
    public let id: String
    public let title: String
    
    public init(id: String, title: String) {
        self.id = id
        self.title = title
    }
}

class ViewController: UIViewController {
    var collectionView: UICollectionView!
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        super.loadView()
        
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: 160, height: 240)
        self.collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        self.collectionView!.collectionViewLayout = layout
        self.collectionView!.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.collectionView!.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(self.collectionView!)
        
        self.collectionView!.registerClass(DataCell.classForCoder(), forCellWithReuseIdentifier: "Cell")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let items = [
            CellViewModel(id: "1", title: "Hello"),
            CellViewModel(id: "2", title: "World"),
            CellViewModel(id: "3", title: "Foo"),
            CellViewModel(id: "4", title: "Bar"),
            ]
        
        Observable
            .just(items)
            .bindTo(collectionView.rx_itemsWithCellFactory) { collectionView, row, model in
                let indexPath = NSIndexPath(forItem: row, inSection: 0)
                let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! DataCell
                cell.value?.text = model.title
                return cell
            }
            .addDisposableTo(disposeBag)
    }
}
