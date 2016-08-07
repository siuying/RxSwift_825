//
//  TableViewController.swift
//  RxDataSourcesExample
//
//  Created by Chan Fai Chong on 7/8/2016.
//  Copyright © 2016 Time Based Technology Limited. All rights reserved.
//

import UIKit
import RxSwift

class DataTableViewCell: UITableViewCell {
    @IBOutlet var value: UILabel?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        value = UILabel(frame: contentView.bounds)
        value?.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        contentView.addSubview(value!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        value = UILabel(frame: contentView.bounds)
        value?.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        contentView.addSubview(value!)
    }
}

class TableViewController: UIViewController {
    var tableView: UITableView!
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        super.loadView()
        
        self.tableView = UITableView(frame: self.view.bounds)
        self.tableView!.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.tableView!.backgroundColor = UIColor.white
        self.view.addSubview(self.tableView!)
        
        self.tableView!.register(DataTableViewCell.classForCoder(), forCellReuseIdentifier: "Cell")
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
            .bindTo(tableView.rx_itemsWithCellFactory) { tableView, row, title in
                let indexPath = IndexPath(item: row, section: 0)
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! DataTableViewCell
                cell.value?.text = title
                return cell
            }
            .addDisposableTo(disposeBag)
    }
}
