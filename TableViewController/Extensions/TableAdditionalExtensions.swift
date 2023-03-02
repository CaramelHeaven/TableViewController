//
//  TableAdditionalExtensions.swift
//  iosJorney
//
//  Created by Sergey Fominov on 3/1/23.
//

import UIKit

class NLTableViewCell: UITableViewCell {
    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    @available(*, unavailable, message: "Loading this cell from a nib is unsupported in favor of initializer dependency injection.")
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Loading cell view from a nib is unsupported in favor of initializer dependency injection.")
    }
}

class NLTableViewHeaderFooterView: UITableViewHeaderFooterView { // swiftlint:disable:this final_class
    // MARK: - Init

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
    }

    @available(*, unavailable, message: "Loading this view from a nib is unsupported in favor of initializer dependency injection.") // swiftlint:disable:this line_length
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Loading this view from a nib is unsupported in favor of initializer dependency injection.")
    }
}

extension NSObject {
    // MARK: - Properties

    var className: String {
        String(describing: type(of: self))
    }

    class var className: String {
        String(describing: self)
    }
}

extension UITableView {
    func register(_ cellClass: Swift.AnyClass?) {
        guard let identifier = (cellClass as? NSObject.Type)?.className else {
            assertionFailure("Cannot get className from cellClass")
            return
        }

        register(cellClass, forCellReuseIdentifier: identifier)
    }

    func register(_ cellClasses: [Swift.AnyClass]) {
        cellClasses.forEach { register($0) }
    }

    func register(cellTypes: UITableViewCell.Type...) {
        cellTypes.forEach { type in
            let reuseIdentifier = String(describing: type)
            register(type, forCellReuseIdentifier: reuseIdentifier)
        }
    }

    func register(nibs: String...) {
        nibs.forEach { register(UINib(nibName: $0, bundle: nil), forCellReuseIdentifier: $0) }
    }
}
