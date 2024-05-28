//
//  Created by Igor Manakov on 12.09.2023.
//

import Foundation
import Moya

enum TokenType: String {
    case accessToken = "access_token"
    case refreshToken = "refresh_token"
}

protocol BearerAuthorizable: TargetType {
    var tokenType: TokenType { get }
}

extension BearerAuthorizable {
    var tokenType: TokenType { .accessToken }
}

public protocol AnyRequest: TargetType {
    var parameters: [String: Any]? { get }
    var parameterEncoding: ParameterEncoding { get }
    var prefersCaching: Bool { get }
    static var successStatusCode: Int { get }
}

public extension AnyRequest {

    var headers: [String: String]? { return nil }

    var sampleData: Data { return Data() }

    var baseURL: URL {
        URL(string: "http://46.174.52.46/api")!
    }

    var parameterEncoding: ParameterEncoding {

        switch method {
        case .get:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }

    var task: Task {
        parameters.map { .requestParameters(parameters: $0, encoding: parameterEncoding) } ?? .requestPlain
    }

    var prefersCaching: Bool { return false }

    static var successStatusCode: Int { return 201 }
}

public protocol Request: AnyRequest {

    associatedtype Result

    static func decodeResult(from response: Moya.Response) throws -> Result

    static var responseTopLevelKey: String? { get }
}

extension Request {

    internal static func getError(from response: Moya.Response) throws -> ServerError {

        do {
            print(String(data: response.data, encoding: .utf8))
            return try JSONDecoder().decode(ServerError.self, from: response.data)
        } catch {

            let statusCode = HTTPStatusCode(rawValue: response.statusCode)

            if statusCode.category != .success {
                let message = [NSLocalizedString("Произошла непредвиденная ошибка. Повторите попытку позже",
                                                comment: "Сообщение когда сервер лежит")]
                return ServerError(statusCode: statusCode,
                                   error: nil,
                                   message: message)
            } else {
                throw error
            }
        }
    }

    public static var responseTopLevelKey: String? { return nil }

    public static func makeParameters(_ sourceDict: [String: Any?]) -> [String: Any]? {
        let nonNilDict = sourceDict.compactMapValues { $0 }
        guard !nonNilDict.isEmpty else { return nil }
        return nonNilDict
    }
}

extension Request where Result: Decodable {
    public static func decodeResult(from response: Moya.Response) throws -> Result {
        switch response.statusCode {
        case 200...299:
            return try JSONDecoder().decode(Result.self, from: response.data)
        default:
            throw try getError(from: response)
        }
    }
}

extension Request where Result == Void {

    public static func decodeResult(from response: Moya.Response) throws -> Result {

        if response.statusCode == successStatusCode { return }

        throw try getError(from: response)
    }
}

extension Request where Result == Data {

    public static func decodeResult(from response: Moya.Response) throws -> Result {

        if response.statusCode == successStatusCode {
            return response.data
        } else {
            throw try getError(from: response)
        }
    }
}

extension Request where Result == UIImage {

    public static func decodeResult(from response: Moya.Response) throws -> Result {

        if response.statusCode == successStatusCode, let image = UIImage(data: response.data) {
            return image
        } else {
            throw try getError(from: response)
        }
    }
}

extension TargetType {

    internal func unwrapped() -> TargetType {
        return (self as? MultiTarget)?.target ?? self
    }
}
