//
//  TableViewModel.swift
//  iosJorney
//
//  Created by Sergey Fominov on 3/1/23.
//

struct TableViewModel {
    // MARK: - Types

    struct Section {
        private(set) var headerConfigurator: TableHeaderFooterConfiguratorProtocol?
        let rows: [Row]
    }

    // MARK: - Properties

    var sections: [Section]

    // MARK: - Row

    enum Row {
        case testCell(TableCellConfiguratorProtocol)

        // MARK: - Properties

        var configurator: TableCellConfiguratorProtocol {
            switch self {
            case let .testCell(configurator):
                return configurator
            }
        }

        var identifier: String {
            return type(of: configurator).reuseId
        }
    }
}
