//
//  GwangjuLocation.swift
//  SoleApp
//
//  Created by SUN on 1/16/24.
//

import Foundation

enum GwangjuLocation: String {
    case Whole = "G00"
    case Gwangsan = "G01"
    case Nam = "G02"
    case Dong = "G03"
    case Buk = "G04"
    case Seo = "G05"

    var koreanName: String {
        switch self {
        case .Whole: return "광주 전체"
        case .Gwangsan: return "광산구"
        case .Nam: return "남구"
        case .Dong: return "동구"
        case .Buk: return "북구"
        case .Seo: return "서구"
        }
    }
}
