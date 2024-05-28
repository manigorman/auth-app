//
//  Created by Igor Manakov on 13.09.2023.
//

import Foundation
import Moya
import PromiseKit

extension MoyaProvider {
    internal func request(_ target: Target) -> (Cancellable, Promise<Moya.Response>) {
        let pending = Promise<Moya.Response>.pending()

        let request: Cancellable = self.request(target) { result in
            switch result {
            case .success(let response):
                pending.resolver.fulfill(response)
            case .failure(let error):
                pending.resolver.reject(error)
            }
        }
        return (request, pending.promise)
    }
}
