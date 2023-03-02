//
//  TableViewHeader.swift
//  iosJorney
//
//  Created by Sergey Fominov on 3/1/23.
//

import UIKit

protocol TableViewHeaderDelegate: AnyObject {
    func didTapHeader(sectionIndex: Int)
}

final class TableViewHeader: NLTableViewHeaderFooterView {
    // MARK: - Properties

    // MARK: - Init

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        drawSelf()
    }

    // MARK: - Drawing

    private func drawSelf() {
        let testView = UIView()
        testView.backgroundColor = .green

        contentView.addSubview(testView)

        testView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
//            make.height.equalTo(100)
        }
    }
}

// MARK: - Configurable

extension TableViewHeader: Configurable {
    struct Model {
    }

    func configure(with model: Model) {
    }
}
