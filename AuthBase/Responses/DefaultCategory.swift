//
//  Created by Igor Manakov on 24.09.2023.
//

import Foundation
import GymTrackerUtils

public struct DefaultCategory: Decodable {
    public let category: String
    public let exercises: [DefaultExercise]
}

public struct DefaultExercise: Decodable {
    public let id: ExerciseId
    public let label: String
}
