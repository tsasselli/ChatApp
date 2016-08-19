//
//  SendTableViewCell.swift
//  ChatApp
//
//  Created by Travis Sasselli on 8/17/16.
//  Copyright © 2016 TravisSasselli. All rights reserved.
//

import UIKit

class SendTableViewCell: UITableViewCell {

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var sendMessageLabel: UILabel!
    var message: Message?
    static let sharedController = SendTableViewCell()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
  
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateWithMessage (message: Message) {
        self.message = message
        sendMessageLabel.layer.masksToBounds = true
        sendMessageLabel.layer.cornerRadius = 8.0
        self.sendMessageLabel.text = message.text
        let timestamp = message.timeStamp.stringValue()
        self.timestampLabel.text = ("Sent \(timestamp)")
        
        guard let firstName = UserController.sharedController.loggedInUser?.firstName,
            let lastName = UserController.sharedController.loggedInUser?.lastName else {return}
        self.userNameLabel.text = ("\(firstName)  \(lastName)")
        print(UserController.sharedController.loggedInUser?.firstName)
    }


}


extension NSDate {
    
    func stringValue() -> String {
        let formatter = NSDateFormatter()
        formatter.dateStyle = .FullStyle
        
        return formatter.stringFromDate(self)
    }
    
}