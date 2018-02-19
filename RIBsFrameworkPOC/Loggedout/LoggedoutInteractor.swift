//
//  LoggedoutInteractor.swift
//  RIBsFrameworkPOC
//
//  Created by Manzar_Hussain on 17/02/18.
//  Copyright © 2018 Infosys Ltd. All rights reserved.
//

import RIBs
import RxSwift
import AFNetworking
import SVProgressHUD


protocol LoggedOutRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
    func cleanupViews()
    func navigateToHomeScreen()
}

protocol LoggedOutPresentable: Presentable {
    weak var listener: LoggedOutPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol LoggedOutListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
    
}

final class LoggedOutInteractor: PresentableInteractor<LoggedOutPresentable>, LoggedOutInteractable, LoggedOutPresentableListener, LoggedOutActionableItem {
    
    
    
    weak var router: LoggedOutRouting?
    
    weak var listener: LoggedOutListener?
    
    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: LoggedOutPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }
    
    override func willResignActive() {
        super.willResignActive()
        router?.cleanupViews()
        // TODO: Pause any business logic.
    }
    
    // MARK: - LoggedOutPresentableListener
    
    func login() {
        SVProgressHUD.show()
        initiateLogin()
    }
    
    private func initiateLogin(){
        
        let viewcontroller = router?.viewControllable
        FBLoginObject.initiateFBLogin(fromView: viewcontroller as! UIViewController, withCompletionBlock: ({finished in
            if finished{
                self.initiateJanRainLogin()
            }
        }))
    }
    func launchLoggedOut(withLocale locale: String) -> Observable<(LoggedOutActionableItem, ())> {
       return Observable.just((self, ()))
    }
    func initiateJanRainLogin() {
                let manager = AFHTTPSessionManager()
                let urlString = "https://infypamp.rpxnow.com/oauth/auth_native"
        
                let params = ["client_id":"12345abcde12345abcde12345abcde12","flow":"standard","flow_version":"67890def-6789-defg-6789-67890defgh67","locale":"en-US","redirect_uri":"http://localhost","response_type":"token" ,"registration_form":"socialRegistrationForm","token":FBLoginObject.socialId] as Dictionary<String, AnyObject>
        
                manager.requestSerializer = AFJSONRequestSerializer()
                manager.responseSerializer = AFHTTPResponseSerializer()
                manager.post(urlString, parameters: params, constructingBodyWith: nil, progress: nil, success: { (task:URLSessionDataTask, responseObject) -> Void in
                    SVProgressHUD.dismiss()
                   print(responseObject!)
                   self.router?.navigateToHomeScreen()
        
                }, failure: { (task:URLSessionDataTask?, Error) -> Void in
                    SVProgressHUD.dismiss()
                    print(Error)
                })
    }
    private let FBLoginObject = FBLoginHelper()
}
