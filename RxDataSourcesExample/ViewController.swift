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
}

class DataSectionView: UICollectionReusableView {
    @IBOutlet var value: UILabel?
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
        self.collectionView!.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.addSubview(self.collectionView!)
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
                let indexPath = IndexPath(item: row, section: 0)
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? DataCell else {
                    fatalError("missing cell")
                }
                cell.value?.text = model.title
                return cell
            }
            .addDisposableTo(disposeBag)
    }
}
