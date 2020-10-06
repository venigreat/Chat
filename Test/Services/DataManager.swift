//
//  DataManager.swift
//  Test
//
//  Created by a.belyaev3 on 06.10.2020.
//  Copyright © 2020 a.belyaev3. All rights reserved.
//

import Foundation

class DataManager {
    func getChatListData() -> [ConversationsWithTypeList] {
        return [.init(type: "Online",
                      list: [.init(name: "Bill",
                                   message: "Fucking cool",
                                   date: Formatter.getDate(from: "2016/1/18 22:31"),
                                   isOnline: true,
                                   hasUnreadMessages: true),
                             .init(name: "Superman",
                                   message: "Wheres my cryptonyte",
                                   date: Formatter.getDate(from: "2021/10/08 22:31"),
                                   isOnline: true,
                                   hasUnreadMessages: true),
                             .init(name: "Гром",
                                   message: "Здарова, братишка",
                                   date: Formatter.getDate(from: "2016/10/08 22:11"),
                                   isOnline: true,
                                   hasUnreadMessages: false),
                             .init(name: "Batman",
                                   message: "Dark",
                                   date: Formatter.getDate(from: "2011/12/01 2:31"),
                                   isOnline: true,
                                   hasUnreadMessages: true),
                             .init(name: "Joker",
                                   message: "HAHAHAHAHHAHAHHAHAHHAHAHHAHAHHAHAHHAHAHHAHA",
                                   date: Formatter.getDate(from: "2016/10/08 22:31"),
                                   isOnline: true,
                                   hasUnreadMessages: true),
                             .init(name: "Travolta John",
                                   message: "Where r u?",
                                   date: Formatter.getDate(from: "2016/10/08 22:31"),
                                   isOnline: true,
                                   hasUnreadMessages: false),
                             .init(name: "Bill",
                                   message: "Fucking cool",
                                   date: Formatter.getDate(from: "2016/10/08 22:31"),
                                   isOnline: true,
                                   hasUnreadMessages: true),
                             .init(name: "Bill",
                                   message: "Fucking cool",
                                   date: Formatter.getDate(from: "2016/10/08 22:31"),
                                   isOnline: true,
                                   hasUnreadMessages: false),
                             .init(name: "Bill",
                                   message: "Fucking cool",
                                   date: Formatter.getDate(from: "2016/10/08 22:31"),
                                   isOnline: true,
                                   hasUnreadMessages: true)]),
                .init(type: "Offline",
                      list: [.init(name: "Ted",
                                   message: "Avesome Avesome Avesome Avesome",
                                   date: Formatter.getDate(from: "2018/10/08 12:31"),
                                   isOnline: false,
                                   hasUnreadMessages: true),
                             .init(name: "Mod",
                                   message: "Avesome Avesome Avesome Avesome",
                                   date: Formatter.getDate(from: "2018/10/08 12:31"),
                                   isOnline: false,
                                   hasUnreadMessages: true),
                             .init(name: "Bart",
                                   message: "Caramba",
                                   date: Formatter.getDate(from: "2022/1/28 12:31"),
                                   isOnline: false,
                                   hasUnreadMessages: true),
                             .init(name: "Lisa",
                                   message: "MyPony",
                                   date: Formatter.getDate(from: "2018/10/08 12:31"),
                                   isOnline: false,
                                   hasUnreadMessages: true),
                             .init(name: "Homer",
                                   message: "D'oh",
                                   date: Formatter.getDate(from: "2018/10/08 1:31"),
                                   isOnline: false,
                                   hasUnreadMessages: true),
                             .init(name: "Margie",
                                   message: "Hmmm",
                                   date: Formatter.getDate(from: "2018/10/08 12:31"),
                                   isOnline: false,
                                   hasUnreadMessages: true),
                             .init(name: "Barney",
                                   message: "Buerp",
                                   date: Formatter.getDate(from: "2018/10/08 12:31"),
                                   isOnline: false,
                                   hasUnreadMessages: true),
                             .init(name: "Montgomery",
                                   message: "Excelent",
                                   date: Formatter.getDate(from: "2018/10/08 12:31"),
                                   isOnline: false,
                                   hasUnreadMessages: true),
                             .init(name: "Krusty the Clawn",
                                   message: "Whohahaha",
                                   date: Formatter.getDate(from: "2018/10/08 12:31"),
                                   isOnline: false,
                                   hasUnreadMessages: false),
                             .init(name: "Ted",
                                   message: "Avesome Avesome Avesome Avesome",
                                   date: Formatter.getDate(from: "2018/10/08 12:31"),
                                   isOnline: false,
                                   hasUnreadMessages: true),
                             .init(name: "Ted",
                                   message: "Avesome Avesome Avesome Avesome",
                                   date: Formatter.getDate(from: "2000/09/29 12:31"),
                                   isOnline: false,
                                   hasUnreadMessages: false),
                             .init(name: "Ted",
                                   message: "Avesome Avesome Avesome Avesome",
                                   date: Formatter.getDate(from: "2018/10/08 12:31"),
                                   isOnline: false,
                                   hasUnreadMessages: true)])]
    }
    
    func getChatMessages() -> [MessageCellModel] {
        return [.init(text:"first blet first blet first blet first blet first blet first blet ",
                      isMy: true),
                .init(text:"second",
                      isMy: false),
                .init(text:"second secondsecondsecond second secondsecond second second ",
                      isMy: false)]
    }
}