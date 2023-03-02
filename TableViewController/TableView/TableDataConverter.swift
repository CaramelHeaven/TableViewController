//
//  TableDataConverter.swift
//  iosJorney
//
//  Created by Sergey Fominov on 3/1/23.
//

import Foundation

protocol TableDataConverterInput {
    func convert(model: TableDataConverter.Model) -> TableViewModel
}

final class TableDataConverter {
    typealias TableHeaderConfigurator = TableHeaderFooterConfigurator<TableViewHeader, TableViewHeader.Model>
    typealias TableFirstConfigurator = TableCellConfigurator<TableFirstCell, TableFirstCell.Model>

    private func createAccordionTitleSection(model: Model) -> TableViewModel.Section {
        let headerModel = TableViewHeader.Model()
        let configurator = TableHeaderConfigurator(item: headerModel, viewHeight: 48)

        let model = TableFirstCell.Model(delegate: model.presenter)

        let cell: TableViewModel.Row = .testCell(TableFirstConfigurator(item: model))
        let cell2: TableViewModel.Row = .testCell(TableFirstConfigurator(item: model))
        let cell3: TableViewModel.Row = .testCell(TableFirstConfigurator(item: model))
        let cell4: TableViewModel.Row = .testCell(TableFirstConfigurator(item: model))

        return TableViewModel.Section(headerConfigurator: configurator, rows: [cell, cell2, cell3, cell4])
    }
}

// MARK: - UserSubscriptionsDataConverterInput

extension TableDataConverter: TableDataConverterInput {
    func convert(model: Model) -> TableViewModel {
        var allSections: [TableViewModel.Section] = []

        let sections = createAccordionTitleSection(model: model)

        allSections.append(sections)

        return TableViewModel(sections: allSections)
    }
}

// MARK: - Model

extension TableDataConverter {
    struct Model {
        weak var presenter: TablePresenter?
    }
}
