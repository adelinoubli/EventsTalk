//
//  EventViewCell.swift
//  Machinestalk
//
//  Created by Adel on 2/22/23.
//

import UIKit

class EventViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var statusIcon: UIImageView!
    @IBOutlet weak var eventName: UILabel!

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        statusIcon.image = nil
    }
    
    func setupCell(with event:  Event) {
        eventName.text = event.name
        dateLabel.text = event.getDateIntervalValue()
        
        if event.status == .before {
            statusIcon.image = UIImage(named: "GreyDot")
        } else {
            statusIcon.image = UIImage(named: "GreenDot")
        }
    }
    
}
