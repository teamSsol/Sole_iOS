//
//  CourseTarget.swift
//  SoleApp
//
//  Created by SUN on 2023/09/13.
//

import Foundation
import Alamofire

enum CourseTarget {
    case getCourseDetail(courseId: Int)
    case searchCourse(query: SearchCourseRequest)
}

extension CourseTarget: TargetType {
    var baseURL: String {
        return K.baseUrl
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .getCourseDetail, .searchCourse:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getCourseDetail(let courseId):
            return K.Path.courseDetail + "/\(courseId)"
            
        case .searchCourse:
            return K.Path.courses
        }
    }
    
    var headers: Alamofire.HTTPHeaders {
        return [
            "Content-Type": "application/json",
            "Authorization": Utility.load(key: Constant.token)
        ]
    }
    
    var parameters: RequestParams {
        switch self {
        case .getCourseDetail:
            return .body(nil)
            
        case .searchCourse(let query):
            return .query(query)
        }
    }
    
    
}
