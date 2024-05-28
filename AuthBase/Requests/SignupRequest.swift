//
//  Created by Igor Manakov on 13.09.2023.
//

import Foundation
import Moya

public struct SignupRequest {

    /// Имя пользователя
    public let username: String
    /// Пароль
    public let password: String

    public init(username: String, password: String) {
        self.username = username
        self.password = password
    }
}

extension SignupRequest: Request {
    
    public typealias Result = LoginCreds

    public var path: String {
        return "/auth/signup"
    }

    public var method: Moya.Method { .post }

    public var parameters: [String: Any]? {
        ["username": username,
         "password": password]
    }
}
