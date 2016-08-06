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

// MARK: RxDataSources - IdentifiableType

extension CellViewModel: IdentifiableType, Equatable {
    public typealias Identity = String
    
    public var identity: String {
        return self.id
    }
}

public func == (lhs: CellViewModel, rhs: CellViewModel) -> Bool {
    return lhs.id == rhs.id
}

struct CellSection {
    var header: String
    var items: [CellViewModel]
    
    init(header: String, items: [CellViewModel]) {
        self.header = header
        self.items = items
    }
}

// MARK: RxDataSources - AnimatableSectionModelType

extension CellSection: AnimatableSectionModelType {
    typealias Item = CellViewModel
    
    init(original: CellSection, items: [CellViewModel]) {
        self = original
        self.items = items
    }
}

// MARK: RxDataSources - IdentifiableType

extension CellSection: IdentifiableType {
    var identity: String {
        return self.header
    }
}

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    private let disposeBag = DisposeBag()

    override func loadView() {
        super.loadView()

        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: 160, height: 240)
        self.collectionView!.collectionViewLayout = layout
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView!.dataSource = nil
        
        let dataSource = RxCollectionViewSectionedReloadDataSource<CellSection>()
        dataSource.configureCell = { datasource, collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as? DataCell else {
                fatalError("invalide cell")
            }
            cell.value?.text = item.title
            return cell
        }
       
        dataSource.supplementaryViewFactory = { (ds ,cv, kind, ip) in
            let section = cv.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "Section", forIndexPath: ip)as! DataSectionView
            
            section.value!.text = "\(ds.sectionAtIndex(ip.section).header)"
            
            return section
        }

        let items = [
            CellViewModel(id: "1", title: "Hello"),
            CellViewModel(id: "2", title: "World"),
            CellViewModel(id: "3", title: "Foo"),
            CellViewModel(id: "4", title: "Bar"),
        ]
        let sections = Observable.just([CellSection(header: "root", items: items)]).shareReplay(1)
        sections
            .subscribeOn(MainScheduler.instance)
            .bindTo(self.collectionView!.rx_itemsWithDataSource(dataSource))
            .addDisposableTo(self.disposeBag)
    }
}
