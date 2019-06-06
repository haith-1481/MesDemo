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

    @IBAction func textFieldEmptyCheck(_ sender: UITextField) {
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
        guard let message = textField.text else { return }
        let newMessage = Message(content: message, sender: sender, attachment: nil, date: Date())
        messageArray.append(newMessage)
        textField.text = nil
        sendButton.isEnabled = false
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
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "TableViewCell")
        tableView.estimatedRowHeight = 100
        tableView.separatorStyle = .none
        sendButton.isEnabled = false
        
        let myMessage = Message(content: "OhioGozaimasu", sender: true, attachment: nil, date: Date())
        let ppMessage = Message(content: "ArigatouGozaimasu", sender: false, attachment: nil, date: Date())

        messageArray.append(myMessage)
        messageArray.append(ppMessage)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as? TableViewCell else { return UITableViewCell() }
        let message = messageArray[indexPath.row]
        cell.setup(message: message)
        return cell
    }

//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let message = messageData[indexPath.row]
//        let bubbleView = SBubbleChatView(message: message, startY: 0)
//        return bubbleView.frame.height + 10;
//    }
}
