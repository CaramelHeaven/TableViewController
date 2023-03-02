//
//  TableFirstCell.swift
//  iosJorney
//
//  Created by Sergey Fominov on 3/1/23.
//

import UIKit
import SnapKit

protocol TableFirstCellDelegate: AnyObject {
    func didTapTableCell()
}

final class TableFirstCell: NLTableViewCell {
    // MARK: - Properties

    private let button = UIButton(type: .system)
    private let testView = UIView()

    private weak var delegate: TableFirstCellDelegate?

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        drawSelf()
    }

    // MARK: - Drawing

    private func drawSelf() {
        testView.backgroundColor = .blue
        button.backgroundColor = .yellow

        contentView.addSubview(testView)
        testView.addSubview(button)

        testView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.left.equalToSuperview().inset(30)
            make.right.equalToSuperview().inset(30)
            make.bottom.equalToSuperview().inset(30)
            make.height.equalTo(200)
        }

        button.snp.makeConstraints { make in
            make.centerX.equalTo(testView.snp.centerX)
            make.centerY.equalTo(testView.snp.centerY)
            make.width.equalTo(80)
            make.height.equalTo(48)
        }

        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }

    @objc private func didTapButton() {
        delegate?.didTapTableCell()
    }
}

// MARK: - Configurable

extension TableFirstCell: Configurable {
    struct Model {
        weak var delegate: TableFirstCellDelegate?
    }

    func configure(with model: Model) {
        delegate = model.delegate
    }
}
