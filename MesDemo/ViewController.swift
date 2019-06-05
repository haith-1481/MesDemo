//
//  ViewController.swift
//  MesDemo
//
//  Created by trinh.hoang.hai on 6/4/19.
//  Copyright © 2019 trinh.hoang.hai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var messageArray = [Message]()

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sendButton: UIButton!

    @IBAction func textFieldTracking(_ sender: UITextField) {
        if let text = textField.text, !text.isEmpty {
            sendButton.isEnabled = true
        } else {
            sendButton.isEnabled = false
        }
    }
    @IBAction func sendAction(_ sender: Any) {
        let rand = Int.random(in: 1...2)
        var sender = true
        if rand == 2 { sender = false }
        let newMessage = Message(content: textField.text!, sender: sender, attachment: nil, date: Date())
        messageArray.append(newMessage)
        textField.text = ""
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(row: messageArray.count - 1, section: 0)], with: .automatic)
        tableView.endUpdates()
        tableView.scrollToRow(at: IndexPath(item: messageArray.count-1, section: 0), at: .bottom, animated: true)

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        // Do any additional setup after loading the view.
    }

    func setupTableView() {
        tableView.estimatedRowHeight = 100
        tableView.separatorStyle = .none
        let myMessage = Message(content: "OhioGozaimasu", sender: true, attachment: nil, date: Date())
        let ppMessage = Message(content: "ArigatouGozaimasu", sender: false, attachment: nil, date: Date())
        let myMessage1 = Message(content: "OhioGozaimasuádafasfavdagadfrawerawfsafsafsafasfasfasfasfasfasfasfas", sender: true, attachment: nil, date: Date())
        let myMessage2 = Message(content: "OhioGozaimasuasssssssssssssssssssssssssssssssssssssssssssssssssss", sender: true, attachment: nil, date: Date())
        let myMessage3 = Message(content: "OhioGozaimasu", sender: true, attachment: nil, date: Date())
        let ppMessage1 = Message(content: "ArigatouGozaimasusfafaaaaaaaaaaaegdfgdfghdfghghagdfgdggdfgdffdhfdghgfdghgdghdfghf", sender: false, attachment: nil, date: Date())
        let ppMessage2 = Message(content: "ArigatouGozaimasu", sender: false, attachment: nil, date: Date())
        messageArray.append(myMessage)
        messageArray.append(ppMessage)

        messageArray.append(myMessage1)
        messageArray.append(myMessage2)
        messageArray.append(myMessage3)

        messageArray.append(ppMessage1)
        messageArray.append(ppMessage2)

    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MessageTableViewCell") as? MessageTableViewCell else { return UITableViewCell() }
        let message = messageArray[indexPath.row]
        cell.message = message
        cell.setCell(message: message)
        return cell
    }

//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let message = messageData[indexPath.row]
//        let bubbleView = SBubbleChatView(message: message, startY: 0)
//        return bubbleView.frame.height + 10;
//    }
}
