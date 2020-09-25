//
//  Cell.swift
//  Entrop.io
//
//  Created by Thomas Sabino-Benowitz on 9/25/20.
//

import Foundation

enum Status {
    case on
    case off
}

class Cell: NSObject {
    let x: Int
    let y: Int
    var status: Status
    
    init(x: Int, y: Int, status: Status = .off) {
        self.x = x
        self.y = y
        self.status = status
    }
}
