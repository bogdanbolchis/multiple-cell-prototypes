//
//  ViewController.swift
//  MultipleCellPrototypes
//
//  Created by Bogdan Bolchis on 29.07.2015.
//
//

import UIKit

struct ViewModel {
	var identifier: CellPrototypeIdentifier
	var representedObject: AnyObject
	var rowHeight: CGFloat
}

enum CellPrototypeIdentifier: String {
	case UserCell = "UserCell"
	case ActivityCell = "ActivityCell"
	case OtherDetailsCell = "OtherDetailsCell"
}

class User {}
class Activity {}

class ViewController: UITableViewController {
	var currentUser = User()

	var dataSource: [ViewModel]!

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
		var cell = tableView.dequeueReusableCellWithIdentifier(identifier.rawValue, forIndexPath: indexPath) as! ViewModelContainingCell

		// Configure the cell
		cell.viewModel = viewModel

		return cell
	}

	override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		let viewModel = dataSource[indexPath.row]
		return viewModel.rowHeight
	}
}

class ViewModelContainingCell: UITableViewCell {
	var viewModel: ViewModel?
}

class UserCell: ViewModelContainingCell {}
class ActivityCell: ViewModelContainingCell {}
class OtherDetailsCell: ViewModelContainingCell {}

