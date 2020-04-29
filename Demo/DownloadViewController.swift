//
//  DownloadViewController.swift
//  Example
//
//  Created by Daniels on 2018/3/16.
//  Copyright © 2018 Daniels. All rights reserved.
//

import UIKit

class DownloadViewController: BaseViewController {


    override func viewDidLoad() {

        sessionManager = appDelegate.sessionManager4

        super.viewDidLoad()

        setupManager()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        updateUI()
        tableView.reloadData()
    }

}


// MARK: - tap event
extension DownloadViewController {

    @IBAction func deleteDownloadTask(_ sender: UIButton) {
        let count = sessionManager.tasks.count
        guard count > 0 else { return }
        let index = count - 1
        guard let task = sessionManager.tasks.safeObject(at: index) else { return }
        // TableView refresh and delete tasks are asynchronous. If the operation is too fast, the data will be inconsistent, so you need to limit the click of the button
        sender.isEnabled = false
        sessionManager.remove(task, completely: false) { [weak self] _ in
            self?.tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
            self?.updateUI()
            sender.isEnabled = true
        }
    }

}


