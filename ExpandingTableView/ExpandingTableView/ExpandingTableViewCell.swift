//
//  ExpandingTableViewCell.swift
//  ExpandingTableView
//
//  Created by Vesza Jozsef on 03/06/15.
//  Copyright (c) 2015 József Vesza. All rights reserved.
//

import UIKit

/// Default implementation of an expanding table view cell.
open class ExpandingTableViewCell: UITableViewCell, ExpandingCellType {
    
    fileprivate let lowLayoutPriority: Float = 250
    fileprivate let highLayoutPriority: Float = 999
    
    /// Reuse identifier for the given class. 
    /// Override for custom id.
    open static var reuseId = "ExpandingCell"
    
    /// Primary view in the cell. Be sure to connect the outlet.
    @IBOutlet open weak var mainContainerView: UIView!
    /// Expandable detail view in the cell. Be sure to connect the outlet.
    @IBOutlet open weak var detailContainerView: UIView!
    
    /// The height of the detail view. Be sure to connect the outlet.
    @IBOutlet open weak var detailViewHeightConstraint: NSLayoutConstraint!
    
    /// Control whether the details view is shown or not. 
    /// Override for custom behavior.
    open var showDetails = false {
        didSet {
            detailViewHeightConstraint.priority = showDetails ? lowLayoutPriority : highLayoutPriority
        }
    }
    
    /// Hide the detail view initially.
    override open func awakeFromNib() {
        super.awakeFromNib()
        detailViewHeightConstraint.constant = 0
    }
}
