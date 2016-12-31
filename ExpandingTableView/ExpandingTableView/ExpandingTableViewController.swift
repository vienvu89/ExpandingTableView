//
//  ExpandingTableViewController.swift
//  ExpandingTableView
//
//  Created by Vesza Jozsef on 03/06/15.
//  Copyright (c) 2015 József Vesza. All rights reserved.
//

import UIKit

/// Default expanding table view controller implementation.
open class ExpandingTableViewController: UITableViewController, ExpandingTableViewControllerType {
    
    /// Index of the currently expanded cell.
    /// Override for custom side effects, when the property is set.
    open var expandedIndexPath: IndexPath? {
        didSet {
            switch expandedIndexPath {
            case .some(let index):
                tableView.reloadRows(at: [index], with: UITableViewRowAnimation.automatic)
            case .none:
                tableView.reloadRows(at: [oldValue!], with: UITableViewRowAnimation.automatic)
            }
        }
    }
    
    /// Set the `showDetails` property of the cell based on `expandedIndexPath`.
    /// Subclasses must call this implementation before customizing the cell.
    open override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ExpandingTableViewCell.reuseId) as! ExpandingTableViewCell
        
        switch expandedIndexPath {
        case .some(let expandedIndexPath) where expandedIndexPath == indexPath:
            cell.showDetails = true
        default:
            cell.showDetails = false
        }
        
        return cell
    }
    
    /// Triggers the expansion of the cells.
    /// Subclases may override, but must call super.
    override open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        switch expandedIndexPath {
        case .some(_) where expandedIndexPath == indexPath:
            expandedIndexPath = nil
        case .some(let expandedIndex) where expandedIndex != indexPath:
            expandedIndexPath = nil
            self.tableView(tableView, didSelectRowAt: indexPath)
        default:
            expandedIndexPath = indexPath
        }
    }
}
