//
//  Created by Igor Manakov on 13.09.2023.
//

import Foundation

public struct Profile: Decodable {

    /// Идентификатор пользователя
    public let userId: UserId

    /// Имя пользователя
    public let username: String
    
    /// Дата создания учетной записи
    public let createdAt: String

    private enum CodingKeys: String, CodingKey {
        case userId = "id"
        case username = "username"
        case createdAt = "createdAt"
    }
}
