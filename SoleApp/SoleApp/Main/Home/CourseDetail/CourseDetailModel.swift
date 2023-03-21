//
//  CourseDetailModel.swift
//  SoleApp
//
//  Created by SUN on 2023/03/20.
//

import Foundation

struct CourseDetailModelResponse: Codable {
    let data: DataModel?
    let status: Int
    let success: Bool
    
    struct DataModel: Codable {
        var address: String?
        var description: String?
        var courseId: Int?
        var categories: [String]?
        var distance: Double?
        var duration: Int?
        var like: Bool?
        var thumbnailImg: String?
        var title: String?
        var followStatus: String?
        var follower: Int?
        var following: Int?
        var scrapCount: Int?
        var startDate: String?
        var checkWriter: Bool?
        var writer: Writer?
        var placeResponseDtos: [PlaceResponseDtos]?
        
    }
    
    struct Writer: Codable {
        var memberId: Int?
        var nickname: String?
        var profileImgUrl: String?
    }
    
    struct PlaceResponseDtos: Codable {
        var address: String?
        var description: String?
        var placeId: Int?
        var placeImgUrls: [String]?
        var placeName: String?
        var latitude: Double?
        var longitude: Double?
    }
}

extension CourseDetailModelResponse.DataModel {
    var cateogoryTitles: [String] {
        guard let categories = categories,
              categories.isEmpty == false else { return [] }
        return categories.map { Category(rawValue: $0)?.title ?? "" }
    }
    
    var scaledDistance: String {
        guard let distance = distance else { return "" }
        return String(format: "%.2fkm", distance)
    }
    
    var computedDuration: String {
        guard let duration = duration else { return "" }
        return duration / 60 == 0
        ? String(format: "%d분 소요", duration%60)
        : String(format: "%d시간 %d분 소요", duration/60, duration%60)
    }
    
    var isFollowing: Bool {
        return followStatus == "FOLLOWING"
    }
}
