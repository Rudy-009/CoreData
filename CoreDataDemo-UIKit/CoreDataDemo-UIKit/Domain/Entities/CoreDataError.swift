//
//  CoreDataError.swift
//  CoreDataDemo-UIKit
//
//  Created by 이승준 on 10/6/25.
//

public enum CoreDataError: Error {
    case fetchFailed(String)
    case EntityNotFound(String)
    case saveFailed(String)
    case deleteFailed(String)
}
