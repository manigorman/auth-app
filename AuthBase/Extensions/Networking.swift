//
//  Created by Igor Manakov on 13.09.2023.
//

import Foundation
import Moya
import Alamofire
import PromiseKit

public final class Networking {
    
    public static let shared = Networking()
    
    private init() {}
    
    lazy var apiProvider: MoyaProvider<MultiTarget> = {

        let session: Session = {
            let configuration = URLSessionConfiguration.default
            configuration.headers = .default
            configuration.timeoutIntervalForRequest = 200

            let sessionDelegate = SessionDelegate()

            let manager = Session(configuration: configuration, delegate: sessionDelegate)
            return manager
        }()

        return MoyaProvider<MultiTarget>(
            stubClosure: { _ in .never},
            session: session,
            plugins: plugins
        )
    }()
    
    var plugins: [PluginType] = [AuthPlugin.default]
    
    public func perform<R: Request>(_ request: R) -> Promise<R.Result> {
        performCancellable(request).1
    }
    
    func performCancellable<R: Request>(_ request: R) -> (Cancellable?, Promise<R.Result>) {
        let (cancellable, response) = _performRequestWithoutRecovery(request)
        let promise = response.recover { error -> Promise<R.Result> in
            if let serverError = error as? ServerError {
                throw serverError
            }
            throw error
        }

        return (cancellable, promise)
    }
    
    private func _performRequestWithoutRecovery<R: Request>(_ request: R) -> (Cancellable?, Promise<R.Result>) {
        assert(!request.prefersCaching || request.method == .get, "Caching is only available for GET requests")

        let result: (Cancellable?, Promise<R.Result>)

        let (cancellable, response) = self.apiProvider.request(.target(request))
        
        result = (cancellable, response
            .map(on: .global(qos: .userInitiated), R.decodeResult(from:)))

        return result
    }
}
