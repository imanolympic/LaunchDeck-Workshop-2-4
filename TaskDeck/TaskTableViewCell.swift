//
//  TaskTableViewCell.swift
//  TaskDeck
//
//  Created by Theron Mansilla on 10/15/20.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var taskDescriptionLabel: UILabel!
    @IBOutlet weak var taskDueDateLabel: UILabel!
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.timeZone = .current
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
        selectionStyle = .none
    }
    
    func configure(description: String, dueDate: Date) {
        self.taskDescriptionLabel.text = description
        self.taskDueDateLabel.text = self.dateFormatter.string(from: dueDate)
    }

}
