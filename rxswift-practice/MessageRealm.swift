//
//  MessageRealm.swift
//  rxswift-practice
//
//  Created by 最上聖也 on 2017/07/15.
//  Copyright © 2017年 SeiyaMogami. All rights reserved.
//

import Foundation
import RealmSwift

class MessageRealm: Object {
    dynamic var id: String = ""
    dynamic var message: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
