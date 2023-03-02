//
//  TableViewManager.swift
//  iosJorney
//
//  Created by Sergey Fominov on 3/1/23.
//

import UIKit

protocol TableViewManagerDelegate: AnyObject {
    func didTapAllCell()
}

protocol TableViewManagerInput {
    func setup(tableView: UITableView)
    func update(with viewModel: TableViewModel)
}

final class TableViewManager: NSObject {
    weak var delegate: TableViewManagerDelegate?

    private weak var tableView: UITableView?
    private var viewModel: TableViewModel?
}

extension TableViewManager: TableViewManagerInput {
    func setup(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self

        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.allowsSelection = true
        tableView.delaysContentTouches = false

        tableView.register(TableFirstCell.self)

        tableView.register(TableViewHeader.self, forHeaderFooterViewReuseIdentifier: TableViewHeader.className)

        self.tableView = tableView
    }

    func update(with viewModel: TableViewModel) {
        guard let tableView = tableView else {
            return
        }
        self.viewModel = viewModel

        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource

extension TableViewManager: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.sections.count ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.sections[section].rows.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let row = viewModel?.sections[indexPath.section].rows[indexPath.row] else {
            return UITableViewCell()
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: row.identifier, for: indexPath)

        row.configurator.configure(cell: cell)
        return cell
    }
}

extension TableViewManager: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let section = viewModel?.sections[section],
              let configurator = section.headerConfigurator,
              let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: type(of: configurator).reuseId) else {
            return nil
        }

        configurator.configure(cell: view)

        return view
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let section = viewModel?.sections[section],
              let configurator = section.headerConfigurator else {
            return 0
        }

        return configurator.viewHeight
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didTapAllCell()
    }
}
