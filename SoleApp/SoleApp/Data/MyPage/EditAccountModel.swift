//
//  EditAccountModel.swift
//  SoleApp
//
//  Created by SUN on 2023/03/20.
//

import Foundation

struct EditAccountModelRequest: Codable {
    var description: String = ""
    var nickname: String = ""
}

struct EditAccountModelResponse: APIResponse {
    var message: String?
    var code: String?
    let data: DataModel?
    let status: Int
    let success: Bool
    
    struct DataModel: Codable, Equatable {
        var description: String?
        var follower: Int?
        var following: Int?
        var nickname: String?
        var profileImgUrl: String?
        var social: String?
        var socialId: String?
    }
}
