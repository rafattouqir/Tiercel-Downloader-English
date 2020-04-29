//
//  DownloadTaskCell.swift
//  Example
//
//  Created by Daniels on 2018/3/16.
//  Copyright © 2018 Daniels. All rights reserved.
//

import UIKit
import Tiercel

class DownloadTaskCell: UITableViewCell {
    
    static let reuseIdentifier = "reuseIdentifier"

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var bytesLabel: UILabel!
    @IBOutlet weak var controlButton: UIButton!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var timeRemainingLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    var tapClosure: ((DownloadTaskCell) -> Void)?


    @IBAction func didTapButton(_ sender: Any) {
        tapClosure?(self)
    }

    func updateProgress(_ task: DownloadTask) {
        progressView.observedProgress = task.progress
        bytesLabel.text = "\(task.progress.completedUnitCount.tr.convertBytesToString())/\(task.progress.totalUnitCount.tr.convertBytesToString())"
        speedLabel.text = task.speedString
        timeRemainingLabel.text = "Time left: \(task.timeRemainingString)"
        startDateLabel.text = "Starting time：\(task.startDateString)"
        endDateLabel.text = "End time：\(task.endDateString)"
        
        var image = #imageLiteral(resourceName: "suspend")
        switch task.status {
        case .suspended:
            statusLabel.text = "time out"
            statusLabel.textColor = .black
        case .running:
            image = #imageLiteral(resourceName: "resume")
            statusLabel.text = "downloading"
            statusLabel.textColor = .blue
        case .succeeded:
            statusLabel.text = "success"
            statusLabel.textColor = .green
        case .failed:
            statusLabel.text = "failure"
            statusLabel.textColor = .red
        case .waiting:
            statusLabel.text = "waiting"
            statusLabel.textColor = .orange
        default:
            image = controlButton.imageView?.image ?? #imageLiteral(resourceName: "suspend")
            break
        }
        controlButton.setImage(image, for: .normal)
    }

}
