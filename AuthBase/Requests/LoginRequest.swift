//
//  Created by Igor Manakov on 12.09.2023.
//

import Foundation
import Moya

public struct LoginRequest {

    /// Имя пользователя
    public let username: String
    /// Пароль
    public let password: String

    public init(username: String, password: String) {
        self.username = username
        self.password = password
    }
}

extension LoginRequest: Request {
    
    public typealias Result = LoginCreds

    public var path: String {
        return "/auth/login"
    }

    public var method: Moya.Method { .post }

    public var parameters: [String: Any]? {
        ["username": username,
         "password": password]
    }
}
