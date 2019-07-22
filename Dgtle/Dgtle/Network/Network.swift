//
//  Network.swift
//  iGithub
//
//  Created by yfm on 2019/1/4.
//  Copyright © 2019年 com.yfm.www. All rights reserved.
//

import Foundation
import Moya
import RxSwift

let requestClosure = { (endpoint: Endpoint, done: @escaping MoyaProvider<MultiTarget>.RequestResultClosure) in
    do {
        var urlRequest = try endpoint.urlRequest()
        urlRequest.timeoutInterval = 30
        done(.success(urlRequest))
    } catch MoyaError.requestMapping(let url) {
        done(.failure(MoyaError.requestMapping(url)))
    } catch MoyaError.parameterEncoding(let error) {
        done(.failure(MoyaError.parameterEncoding(error)))
    } catch {
        done(.failure(MoyaError.underlying(error, nil)))
    }
}

let endpointClosure = { (target: MultiTarget) -> Endpoint in
    var defaultEndpoint = MoyaProvider<MultiTarget>.defaultEndpointMapping(for: target)
//    return defaultEndpoint.adding(newHTTPHeaderFields: ["Authorization": AuthManager.share.token ?? ""])
    return defaultEndpoint
}

let activityPlugin = NetworkActivityPlugin { (type, target) in
    switch type {
    case .began:
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    case .ended:
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}

let provider = MoyaProvider(endpointClosure: endpointClosure,
                            requestClosure: requestClosure,
                            stubClosure: MoyaProvider.neverStub,
                            callbackQueue: nil,
                            manager: MoyaProvider<MultiTarget>.defaultAlamofireManager(),
                            plugins: [NetworkLogPlugin(),
                                      activityPlugin])

class Network {

    static var isAlertShow = false

    /// network request
    ///
    /// - Parameter target: target
    /// - Returns: Observable<Response>
    static func request(_ target: DGTarget) -> Observable<Response> {
        return Observable.create({ (observer) -> Disposable in
            provider.request(MultiTarget(target), completion: { result in
                switch result {
                case .success(let response):
                    do {
                        // filter http status code
                        let response = try response.filterSuccessfulStatusCodes()
                        observer.onNext(response)
                        observer.onCompleted()
                    } catch {
                        observer.onError(error)
                    }
                case .failure(let error):
                    observer.onError(error)
                }
            })
            return Disposables.create()
        })
    }
}
