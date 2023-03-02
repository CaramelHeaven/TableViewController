

import UIKit

struct CollectionCellConfigurator<CellType: Configurable, Model>: CollectionCellConfiguratorProtocol
where CellType.Model == Model, CellType: UICollectionViewCell {
    
    // MARK: - Properties
    
    static var reuseId: String {
        String(describing: CellType.self)
    }
    
    var size: CGSize
    
    let item: Model?
    
    
    // MARK: - Init
    
    init(item: Model?, size: CGSize) {
        self.item = item
        self.size = size
    }
    
    
    // MARK: - Public methods
    
    func configure(cell: UIView) {
        guard let item = item else { return }
        (cell as? CellType)?.configure(with: item)
    }
    
    func associatedValue<T>() -> T? {
        item as? T
    }
    
}
