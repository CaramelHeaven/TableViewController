//
//  TableViewController.swift
//  iosJorney
//
//  Created by Sergey Fominov on 3/1/23.
//

import UIKit

protocol TableViewControllerInput: AnyObject {
    func updateTableView(model: TableViewModel)
}

final class TableViewController: UIViewController {
    private let tableView = UITableView()

    let presenter = TablePresenter()
    private let tableViewManager: TableViewManagerInput = TableViewManager()

    override func viewDidLoad() {
        view.backgroundColor = .white
        presenter.view = self

        view.addSubview(tableView)

        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }

        tableViewManager.setup(tableView: tableView)
        (tableViewManager as? TableViewManager)?.delegate = presenter

        presenter.makeCells()
    }
}

extension TableViewController: TableViewControllerInput {
    func updateTableView(model: TableViewModel) {
        tableViewManager.update(with: model)
    }
}
