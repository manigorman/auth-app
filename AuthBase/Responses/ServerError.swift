//
//  Created by Igor Manakov on 12.09.2023.
//

import Foundation

public struct ServerError: Error, Equatable {

    public let statusCode: HTTPStatusCode
    public let error: String?
    public let message: [String]

    public init(statusCode: HTTPStatusCode,
                error: String?,
                message: [String]) {
        self.statusCode = statusCode
        self.error = error
        self.message = message
    }
}

extension ServerError: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case statusCode = "statusCode"
        case error = "error"
        case message = "message"
    }

    public init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: CodingKeys.self)

        if let code = try? container.decode(Int.self, forKey: .statusCode) {
            statusCode = HTTPStatusCode(rawValue: code)
        } else {
            throw DecodingError.dataCorruptedError(forKey: .statusCode,
                                                   in: container,
                                                   debugDescription: "Expected an HTTP status code")
        }

        error = try container.decodeIfPresent(String.self, forKey: .error)
        message = try container.decode([String].self, forKey: .message)
    }
}

extension ServerError: CustomStringConvertible {

    public var description: String {
        return message.debugDescription
    }
}

extension ServerError: CustomDebugStringConvertible {

    public var debugDescription: String {
        let codeString = error.map { "code: \($0.debugDescription), " } ?? ""
        return "ServerError(status: \(statusCode.debugDescription), \(codeString)message: \(message.debugDescription))"
    }
}

extension ServerError: LocalizedError {

    public var errorDescription: String? {
        return message.description
    }
}

extension ServerError {

    public struct TradingErrorCode: RawRepresentable, Hashable {

        public var rawValue: String

        public init(rawValue: String) {
            self.rawValue = rawValue
        }
    }
}
