//
//  UITableView+.swift
//  1MinuteMeteo
//
//  Created by Adel on 1/13/23.
//

import UIKit

extension UITableView {
    func reloadData(_ completion: @escaping (() -> Void)) {
        UIView.animate(withDuration: TimeInterval(0), animations: {
            self.reloadData()
        }) { _ in
            DispatchQueue.main.async {
                completion()
            }
        }
    }

    func dequeue<T: UITableViewCell>(cellType: CellType, for indexPath: IndexPath) -> T? {
        if !cellType.rawValue.isEmpty {
            let cell = dequeueReusableCell(withIdentifier: cellType.rawValue, for: indexPath)
            return cell as? T
        }
        return UITableViewCell() as? T
    }

    func registerNibCell(_ cellType: CellType?) {
        guard let cellType = cellType else { return }
        register(UINib(nibName: cellType.rawValue, bundle: nil), forCellReuseIdentifier: cellType.rawValue)
    }
}
