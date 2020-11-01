//
//  FirebaseManager.swift
//  Test
//
//  Created by a.belyaev3 on 01.11.2020.
//  Copyright © 2020 a.belyaev3. All rights reserved.
//

import Foundation
import Firebase

class FirebaseManager {
    
    static var db = Firestore.firestore()
    static var collection = db.collection("channels")
    static var reference = collection.order(by: "lastActivity", descending: true)
    
    static func readChannels(closure: @escaping ([ConversationCellModel]) -> Void) {
        var list: [ConversationCellModel] = []
        reference.addSnapshotListener { snapshot, error in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                if let chatList = snapshot?.documents {
                    for chat in chatList {
                        let data = chat.data()
                        list.append(.init(identifier: chat.documentID as String,
                                          name: data["name"] as? String ?? "Пустое имя",
                                          lastMessage: data["lastMessage"] as? String? ?? nil,
                                          lastActivity: data["lastActivity"] as? Timestamp ?? nil))
                    }
                }
                closure(list)
            }
        }
    }
    
    static func readMessages(screenId: String, completion: @escaping ([MessageCellModel]) -> Void) {
        var messages = [MessageCellModel]()
        let messagePath = collection.document(screenId).collection("messages").order(by: "created")
        messagePath.getDocuments { (snapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in snapshot!.documents {
                    let data = document.data()
                    
                    guard let content = data["content"] as? String else { return }
                    guard let created = data["created"] as? Timestamp else { return }
                    guard let senderId = data["senderId"] as? String else { return }
                    guard let senderName = data["senderName"] as? String else { return }

                    messages.append(MessageCellModel(content: content,
                                            created: Date(timeIntervalSince1970: TimeInterval(created.seconds)),
                                            senderId: senderId,
                                            senderName: senderName))
                    completion(messages)
                }
            }
        }
    }
    
    static func writeChannel(title: String?) {
        collection.addDocument(data: [
            "identifier": self.collection.document().documentID,
            "name": title ?? "Ошибка",
            "lastMessage": "",
            "lastActivity": FieldValue.serverTimestamp()
        ])
    }
    
    static func writeMessage(screenId: String, _ message: MessageCellModel) {
        collection.document(screenId).collection("messages").addDocument(data: [
            "content": message.content as Any,
            "created": message.created,
            "senderId": message.senderId,
            "senderName": message.senderName
        ])
    }
}
