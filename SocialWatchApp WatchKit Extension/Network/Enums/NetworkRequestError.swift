//
//  NetworkRequestError.swift
//  SocialWatchApp WatchKit Extension
//
//  Created by Aydın Serhat SEZEN on 29.06.2022.
//

import Foundation

enum NetworkRequestError: LocalizedError, Equatable {
    case invalidRequest
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case error4xx(_ code: Int)
    case serverError
    case error5xx(_ code: Int)
    case decodingError
    case urlSessionFailed(_ error: URLError)
    case unknownError
}
