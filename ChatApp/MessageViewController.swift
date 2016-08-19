//
//  MessageViewController.swift
//  ChatApp
//
//  Created by Travis Sasselli on 8/17/16.
//  Copyright © 2016 TravisSasselli. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textFieldOutlet: UITextField!
    @IBOutlet weak var userNameOutlet: UILabel!
    
    var message: Message?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserController.sharedController.lookForCurrentUser()
        
        MessageController.sharedController.fetchNewRecords()
        
        let nc = NSNotificationCenter.defaultCenter()
        nc.addObserver(self, selector: #selector(messagesWereUpdated), name: MessageControllerDidRefreshNotification , object: nil)
        
    }
    
    func messagesWereUpdated(notification: NSNotification) {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.tableView.reloadData()
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageController.sharedController.message.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier("sendCell", forIndexPath: indexPath) as? SendTableViewCell else { return UITableViewCell() }
        
        let message = MessageController.sharedController.message[indexPath.row]
        
        cell.updateWithMessage(message)
        return cell
    }
    
    @IBAction func sendButtonTapped(sender: AnyObject) {
        
        let cell = SendTableViewCell()
        
        if let message = self.message {
            message.text = cell.sendMessageLabel.text!
        } else {
            guard let text = textFieldOutlet.text else { return }
            let newMessage = Message(text: text )
            MessageController.sharedController.createMessage(newMessage, completion: { (_) in
            })
            self.message = newMessage
        }
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
}
