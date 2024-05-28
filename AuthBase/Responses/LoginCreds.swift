//
//  Created by Igor Manakov on 12.09.2023.
//

import Foundation

public struct LoginCreds: Decodable {

    public let accessToken: String?

    public let refreshToken: String?

    private enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
    }
}
