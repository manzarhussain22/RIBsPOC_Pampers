//
//  LoggedOutCAInteractor.swift
//  RIBsFrameworkPOC
//
//  Created by Manzar_Hussain on 18/02/18.
//  Copyright © 2018 Infosys Ltd. All rights reserved.
//

import RIBs
import RxSwift
import SVProgressHUD
import AFNetworking

protocol LoggedOutCARouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol LoggedOutCAPresentable: Presentable {
    weak var listener: LoggedOutCAPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol LoggedOutCAListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class LoggedOutCAInteractor: PresentableInteractor<LoggedOutCAPresentable>, LoggedOutCAInteractable, LoggedOutCAPresentableListener, LoggedOutActionableItem {
    
    weak var router: LoggedOutCARouting?
    weak var listener: LoggedOutCAListener?
    
    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: LoggedOutCAPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }
    
    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    func launchLoggedOut(withLocale locale: String) -> Observable<(LoggedOutActionableItem, ())> {
        return Observable.just((self, ()))
    }
    
    func startGRSSignIn(with email: String, password: String) {
        SVProgressHUD.show()
        initiateLogin(with: email, password: password)
    }
    
    private func initiateLogin(with email: String, password: String){
        let serviceKey = "account/relaylogin/stage"
        let urlString = URL.init(string: "https://relay.grs-pg.com/rest/app/505")
        
        let manager = AFHTTPSessionManager(baseURL: urlString)
        
        
        let params = ["username":email, "password":password] as Dictionary<String, AnyObject>
        
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.requestSerializer.setAuthorizationHeaderFieldWithUsername("aimia_pampers_de_de", password: "RH5x*mQ6dF6yc@WrEg8%")
        manager.responseSerializer = AFHTTPResponseSerializer()
        
        manager.post(serviceKey, parameters: params, constructingBodyWith: nil, progress: nil, success: { (task:URLSessionDataTask, responseObject) -> Void in
            SVProgressHUD.dismiss()
            print(responseObject!)
            
        }, failure: { (task:URLSessionDataTask?, Error) -> Void in
            SVProgressHUD.dismiss()
            print(Error)
        })
    }
}
