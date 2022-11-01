//
//  Observable+MoyaErrorHandler.swift
//  Cars Demo
//
//  Created by ABDO on 24/02/2022.
//

import RxSwift
import Moya

/// Extending Observable, adding subscribeWithDefaultErrorHandling method that has the default error handling mechanism.
extension ObservableType {
    
    /**
     Subscribe on the Observable. This subscription has the default error handling for Moya.
     - parameter onSuccess: Closure that accepts the element.
     - parameter onError: Closure that get called if error arises.
     - parameter viewModel: The ViewModel that will send the error message.
     - parameter errorMessageSize: Message size that shows the error (if found).
     - returns: Subscription object used to unsubscribe from the Observable sequence.
     */
    func subscribeWithDefaultErrorHandling(onSuccess: @escaping ((Self.Element) -> Void),
                                           onError: ((Error) -> Void)? = nil,
                                           viewModel: BaseViewModel,
                                           errorMessageSize: MessageSize = .large) -> Disposable {
        return self.subscribe(onNext: {  element in
            onSuccess(element)
        }, onError: { error in
            
            onError?(error)
            
            var errorMessage: String!
            do {
                if let errorResponse = error as? Moya.MoyaError, let errorModel = try errorResponse.response?.map(ErrorResponse.self) {
                    if errorResponse.errorCode == 401 {
                       print(" Refresh Token needed or somthing else ")
                    }
                    errorMessage = errorModel.errors[0].message
                } else {
                    errorMessage = error.localizedDescription
                }
            } catch let parseError {
                print("Parse error: \(parseError.localizedDescription)")
                errorMessage = "Service Temporarily Unavailable"
            }
            
            switch errorMessageSize {
            case .large:
                viewModel.messageEvent.accept((errorMessage, .error))
            case .lite:
                viewModel.liteMessageEvent.accept((errorMessage, .error)) 
            }
        })
    }
}
