//
//  Created by Igor Manakov on 13.09.2023.
//

import Foundation
import Moya

public struct AuthPlugin: PluginType {

    public static let `default` = AuthPlugin()

    private static let _header = "Bearer"
    
    public func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        guard var bearerTarget = target.unwrapped() as? BearerAuthorizable else { return request }
        
        var request = request
        request.addValue("Bearer \(token(tokenType: bearerTarget.tokenType))", forHTTPHeaderField: "Authorization")
        return request
    }
    
    private func token(tokenType: TokenType) -> String {
        if let token = UserDefaults.standard.string(forKey: tokenType.rawValue) {
            return token
        } else {
            return ""
        }
    }
}
