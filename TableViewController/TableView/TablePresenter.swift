//
//  TablePresenter.swift
//  iosJorney
//
//  Created by Sergey Fominov on 3/1/23.
//

import Foundation

final class TablePresenter {
    let dataConverter: TableDataConverterInput = TableDataConverter()

    weak var view: TableViewControllerInput?

    func makeCells() {
        let model = TableDataConverter.Model(presenter: self)
        let viewModel = dataConverter.convert(model: model)

        view?.updateTableView(model: viewModel)
    }
}

extension TablePresenter: TableFirstCellDelegate {
    func didTapTableCell() {
        print("didTapTableCell")
    }
}

extension TablePresenter: TableViewManagerDelegate {
    func didTapAllCell() {
        print("didTapAllCell")
    }
}
