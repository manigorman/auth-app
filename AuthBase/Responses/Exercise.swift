//
//  Exercise.swift
//  GymTrackerBase
//
//  Created by Igor Manakov on 24.09.2023.
//

import Foundation

public struct `Set`: Decodable {
    public let num: Int
    public let reps: Int
    public let weight: Int
}

public struct ExerciseResponse: Decodable {

    public let exerciseId: ExerciseId
    public let name: String
    public let sets: [`Set`]
    public let userId: UserId
    public let createdAt: String
    public let updatedAt: String?

    private enum CodingKeys: String, CodingKey {
        case exerciseId = "id"
        case name = "name"
        case sets = "sets"
        case userId = "user"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
    }
}
