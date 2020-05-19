//
//  File.swift
//
//
//  Created by Bibin Jacob Pulickal on 10/04/20.
//

import Foundation

public protocol Reusable: class {
    static var identifier: String { get }
}

public extension Reusable {
    static var identifier: String {
        return String(describing: self)
    }
}

#if canImport(UIKit)
import UIKit

extension UITableViewCell: Reusable { }

extension UICollectionViewCell: Reusable { }

extension UITableViewHeaderFooterView: Reusable { }

public extension UITableView {

    func register<CellClass: UITableViewCell>(_ cellClasses: [CellClass.Type]) {
        for cellClass in cellClasses {
            register(cellClass)
        }
    }

    func register<CellClass: UITableViewCell>(_ cellClass: CellClass.Type) {
        register(cellClass, forCellReuseIdentifier: cellClass.identifier)
    }

    func register<CellClass: UITableViewHeaderFooterView>(_ cellClasses: [CellClass.Type]) {
        for cellClass in cellClasses {
            register(cellClass)
        }
    }

    @available(*, unavailable, renamed: "register")
    func registerForHeaderFooterView<CellClass: UITableViewHeaderFooterView>(_ cellClass: CellClass.Type) { }

    func register<CellClass: UITableViewHeaderFooterView>(_ cellClass: CellClass.Type) {
        register(cellClass, forHeaderFooterViewReuseIdentifier: cellClass.identifier)
    }

    func dequeue<CellClass: UITableViewCell>(
        _ cellClass: CellClass.Type,
        for indexPath: IndexPath,
        setup: ((CellClass) -> Void)? = nil) -> UITableViewCell {
        let cell = dequeueReusableCell(withIdentifier: cellClass.identifier, for: indexPath)
        if let cell = cell as? CellClass {
            setup?(cell)
        }
        return cell
    }

    @available(*, unavailable, renamed: "dequeue")
    func dequeueHeaderFooterView<CellClass: UITableViewHeaderFooterView>(
        _ cellClass: CellClass.Type,
        setup: ((CellClass) -> Void)? = nil) -> UITableViewHeaderFooterView { UITableViewHeaderFooterView() }

    func dequeue<CellClass: UITableViewHeaderFooterView>(
        _ cellClass: CellClass.Type,
        setup: ((CellClass) -> Void)? = nil) -> UITableViewHeaderFooterView {
        let cell = dequeueReusableHeaderFooterView(withIdentifier: cellClass.identifier)
        if let cell = cell as? CellClass {
            setup?(cell)
        }
        return cell ?? UITableViewHeaderFooterView()
    }
}

public extension UICollectionView {

    func register<CellClass: UICollectionViewCell>(_ cell: CellClass.Type) {
        register(cell, forCellWithReuseIdentifier: cell.identifier)
    }

    func dequeue<CellClass: UICollectionViewCell>(
        _ class: CellClass.Type,
        for indexPath: IndexPath,
        setup: ((CellClass) -> Void)? = nil) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: CellClass.identifier, for: indexPath)
        if let cell = cell as? CellClass {
            setup?(cell)
        }
        return cell
    }
}

#elseif canImport(Cocoa)
import Cocoa

extension NSCollectionViewItem: Reusable { }

public extension NSCollectionView {

    func register<ItemClass: NSCollectionViewItem>(_ itemClass: ItemClass.Type) {
        register(itemClass, forItemWithIdentifier: NSUserInterfaceItemIdentifier(itemClass.identifier))
    }

    func register<ViewClass: NSView & Reusable>(_ viewClass: ViewClass.Type,
                                                forSupplementaryViewOfKind kind: SupplymentaryViewKind) {
        register(viewClass,
                 forSupplementaryViewOfKind: kind.rawValue,
                 withIdentifier: NSUserInterfaceItemIdentifier(viewClass.identifier))
    }

    func makeItem<ItemClass: NSCollectionViewItem>(_ itemClass: ItemClass.Type,
                                                   for indexPath: IndexPath,
                                                   setup: ((ItemClass) -> Void)? = nil) -> NSCollectionViewItem {
        guard let item = makeItem(withIdentifier: NSUserInterfaceItemIdentifier(itemClass.identifier),
                                  for: indexPath) as? ItemClass else { return NSCollectionViewItem() }
        setup?(item)
        return item
    }

    func makeSupplementaryView<ViewClass: NSView & Reusable>(_ viewClass: ViewClass.Type,
                                                             kind: SupplementaryElementKind,
                                                             for indexpath: IndexPath,
                                                             setup: ((ViewClass) -> Void)? = nil) -> NSView {
        let identifier = NSUserInterfaceItemIdentifier(viewClass.identifier)
        guard let supplementaryView = makeSupplementaryView(ofKind: kind,
                                                            withIdentifier: identifier,
                                                            for: indexpath) as? ViewClass else { return NSView() }
        setup?(supplementaryView)
        return supplementaryView
    }
}

public extension NSCollectionView {

    enum SupplymentaryViewKind: String {
        case header = "UICollectionElementKindSectionHeader"
        case footer = "UICollectionElementKindSectionFooter"
    }
}
#endif
