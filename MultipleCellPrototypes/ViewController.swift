//
//  ViewController.swift
//  MultipleCellPrototypes
//
//  Created by Bogdan Bolchis on 29.07.2015.
//
//

import UIKit

/// We use a base class for the cells on the screen. This helps with consistency.
class BaseCell: UITableViewCell {
	var viewModel: ViewModel? {
		didSet {
			updateSubviews()
		}
	}

	func updateSubviews() {
		// ...
	}
}

/// A subclass for each prototype
class UserCell: BaseCell {}
class ActivityCell: BaseCell {}
class OtherDetailsCell: BaseCell {}

/// Encapsulates values used to configure one cell
struct ViewModel {
	var identifier: CellPrototypeIdentifier // What cell are we going to instantiate?
	var representedObject: AnyObject // This could be a User, or an Activity
	var rowHeight: CGFloat // Necessary because IB doesn't respect the row heights set for prototypes.
}

/// Prototypes set in IB
enum CellPrototypeIdentifier: String {
	case UserCell = "UserCell"
	case ActivityCell = "ActivityCell"
	case OtherDetailsCell = "OtherDetailsCell"
}

// Simple classes used for illustration purposes.
class User {}
class Activity {}

// Our table view controller
class ViewController: UITableViewController {
	var dataSource: [ViewModel]!
	var currentUser = User()

	override func viewDidLoad() {
		super.viewDidLoad()
		createDataSource()
	}

	func createDataSource() {
		dataSource = [
			ViewModel(identifier: .UserCell, representedObject: currentUser, rowHeight: 75),
			ViewModel(identifier: .ActivityCell, representedObject: currentUser, rowHeight: 145),
			ViewModel(identifier: .OtherDetailsCell, representedObject: currentUser, rowHeight: 90),
			ViewModel(identifier: .OtherDetailsCell, representedObject: currentUser, rowHeight: 90),
			ViewModel(identifier: .OtherDetailsCell, representedObject: currentUser, rowHeight: 90)
		]
	}

	// MARK: - UITableViewDataSource, UITableViewDelegate

	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return dataSource.count
	}

	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let viewModel = dataSource[indexPath.row]
		let identifier = viewModel.identifier
		var cell = tableView.dequeueReusableCellWithIdentifier(identifier.rawValue, forIndexPath: indexPath) as! BaseCell

		// Configure the cell
		cell.viewModel = viewModel

		return cell
	}

	override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		let viewModel = dataSource[indexPath.row]
		return viewModel.rowHeight
	}
}