//
//  Created by Igor Manakov on 13.09.2023.
//

import Foundation

public protocol Identifier: RawRepresentable, Hashable, CustomStringConvertible {}

extension Identifier {
    public var description: String { String(describing: rawValue) }
}

public struct UserId: Identifier, Decodable {
    public let rawValue: String

    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}

public struct ExerciseId: Identifier, Decodable {
    public let rawValue: String

    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}
