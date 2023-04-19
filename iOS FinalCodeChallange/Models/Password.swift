//
//  Password.swift
//  iOS FinalCodeChallange
//
//  Created by mac on 2023-04-18.
//

import Foundation

struct Password: Decodable {
    let message: String
    let messageCode: Int
    
    enum CodingKeys: String, CodingKey {
        case message = "msg"
        case messageCode = "msg_code"
    }
}
