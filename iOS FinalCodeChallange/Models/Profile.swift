//
//  Profile.swift
//  iOS FinalCodeChallange
//
//  Created by mac on 2023-04-18.
//

import Foundation

struct Profile: Decodable {
    let message: String
    let messageCode: Int
    let data: User
    
    enum CodingKeys: String, CodingKey {
        case message = "msg"
        case messageCode = "msg_code"
        case data
    }
}
