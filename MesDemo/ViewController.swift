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
    var isEditingMessage = false
    var editingMessageID: IndexPath?

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
        if isEditingMessage {
            isEditingMessage = false
            guard let row = editingMessageID?.row else { return }
            guard let message = textField.text else { return }
            messageArray[row].content = message
            textField.text = nil
            tableView.reloadRows(at: [IndexPath(row: row, section: 0)], with: UITableView.RowAnimation.none)
        } else {
            let rand = Int.random(in: 1...2)
            var sender: Sender = .me
            if rand == 2 { sender = .friend }
            guard let message = textField.text else { return }
            let newMessage = Message(content: message, sender: sender, attachment: nil, date: Date(), position: .alone)
            let newMess = reposition(newMessage: newMessage)
            messageArray.append(newMess)
            textField.text = nil
            sendButton.isEnabled = false

            tableView.beginUpdates()
            tableView.reloadRows(at: [IndexPath(row: messageArray.count - 2, section: 0)], with: UITableView.RowAnimation.none)
            tableView.insertRows(at: [IndexPath(row: messageArray.count - 1, section: 0)], with: .automatic)
            tableView.endUpdates()

            tableView.scrollToRow(at: IndexPath(item: messageArray.count-1, section: 0), at: .bottom, animated: true)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        // Do any additional setup after loading the view.
    }

    private func setupTableView() {
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "TableViewCell")
        tableView.estimatedRowHeight = 100
        tableView.separatorStyle = .none
        sendButton.isEnabled = false
        
        let myMessage = Message(content: "OhioGozaimasu", sender: .friend, attachment: nil, date: Date(), position: .alone)
        let ppMessage = Message(content: "ArigatouGozaimasu", sender: .me, attachment: nil, date: Date(), position: .alone)

        messageArray.append(myMessage)
        messageArray.append(ppMessage)
    }

    private func reposition(newMessage: Message) -> Message {
        guard let lastMess = messageArray.last else { return newMessage }
        if lastMess.sender == newMessage.sender {
            if lastMess.position == .alone {
                messageArray.last?.position = .first
            } else if lastMess.position == .last {
                messageArray.last?.position = .mid
            }
            newMessage.position = .last
        }
        return newMessage
    }

    private func doSelectAll(id: Int) {
        let totalRows = tableView.numberOfRows(inSection: 0)
        for row in 0..<totalRows where row != id {
            guard let cell:TableViewCell = tableView.cellForRow(at: NSIndexPath(row: row, section: 0) as IndexPath) as? TableViewCell else { return }
            cell.toolBoxIsHidden = true
            cell.toolBox.isHidden = cell.toolBoxIsHidden
        }
    }

    func removeCellAt(id: IndexPath) {
        print(id.row)
        tableView.deleteRows(at: [id], with: .fade)
        tableView.reloadData()
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
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.ediAction = { [weak self] in
            guard let `self` = self else { return }
            self.textField.text = message.content
            self.isEditingMessage = true
            self.editingMessageID = indexPath
        }
        cell.delAction = { [weak self] in
            guard let `self` = self else { return }
            self.messageArray.remove(at: indexPath.row)
            self.removeCellAt(id: indexPath)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell:TableViewCell = tableView.cellForRow(at: indexPath) as? TableViewCell else { return }
        cell.toolBoxIsHidden.toggle()
        cell.toolBox.isHidden = cell.toolBoxIsHidden
        doSelectAll(id: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: false)
    }

//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let message = messageData[indexPath.row]
//        let bubbleView = SBubbleChatView(message: message, startY: 0)
//        return bubbleView.frame.height + 10;
//    }
}
