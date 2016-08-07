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
    @IBOutlet var value: UILabel?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        value = UILabel(frame: contentView.bounds)
        value?.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        contentView.addSubview(value!)
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
        self.collectionView!.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.collectionView!.backgroundColor = UIColor.white
        self.view.addSubview(self.collectionView!)
        
        self.collectionView!.register(DataCell.classForCoder(), forCellWithReuseIdentifier: "Cell")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let items = [
            "Hello",
            "World",
            "Foo",
            "Bar",
        ]
        
        Observable
            .just(items)
            .bindTo(collectionView.rx_itemsWithCellFactory) { collectionView, row, title in
                let indexPath = IndexPath(item: row, section: 0)
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? DataCell else {
                    fatalError("missing cell")
                }
                cell.value?.text = title
                return cell
            }
            .addDisposableTo(disposeBag)
    }
}
