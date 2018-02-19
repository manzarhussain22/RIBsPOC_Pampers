//
//  RootRouter.swift
//  RIBsFrameworkPOC
//
//  Created by Manzar_Hussain on 17/02/18.
//  Copyright © 2018 Infosys Ltd. All rights reserved.
//

import RIBs

protocol RootInteractable: Interactable, LoggedOutListener, SplashScreenListener, LoggedOutCAListener {
    weak var router: RootRouting? { get set }
    weak var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
    func replaceModal(viewController: ViewControllable?)
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {
    
    init(interactor: RootInteractable,
         viewController: RootViewControllable,
         splashScreenBuilder : SplashScreenBuildable,
         loggedOutBuilder: LoggedOutBuildable,
         loggedOutCABuilder: LoggedOutCABuildable) {
        self.loggedOutBuilder = loggedOutBuilder
        self.splashScreenBuilder = splashScreenBuilder
        self.loggedOutCABuilder = loggedOutCABuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    override func didLoad() {
        super.didLoad()
        
//        routeToLoggedOut()
        routeToSplashScreen()
    }
    
    // MARK: - Private
    
    private let loggedOutBuilder: LoggedOutBuildable
    private let loggedOutCABuilder: LoggedOutCABuildable
    private let splashScreenBuilder: SplashScreenBuildable
    
    private var loggedOut: ViewableRouting?
    private var splashScreen: SplashScreenRouting?
    private var loggedOutCA: LoggedOutCARouting?
    
    private func routeToSplashScreen() {
        let splashScreen = splashScreenBuilder.build(withListener: interactor)
        self.splashScreen = splashScreen
        attachChild(splashScreen)
        viewController.replaceModal(viewController: splashScreen.viewControllable)
    }
    func routeToLoggedOut(withLocale locale: String) -> LoggedOutActionableItem {
        if let splashScreen = self.splashScreen {
                        detachChild(splashScreen)
                        viewController.replaceModal(viewController: nil)
                        self.splashScreen = nil
                    }
        if (locale.range(of: "de") != nil) {
                        let loggedOutCA = loggedOutCABuilder.build(withListener: interactor)
            self.loggedOutCA = loggedOutCA.router
            attachChild(loggedOutCA.router)
            viewController.replaceModal(viewController: loggedOutCA.router.viewControllable)
            return loggedOutCA.actionItem
                    }
        else
        {
            let loggedOut = loggedOutBuilder.build(withListener: interactor)
            self.loggedOut = loggedOut.router
            attachChild(loggedOut.router)
            viewController.replaceModal(viewController: loggedOut.router.viewControllable)
            return loggedOut.actionItem
        }
    }
}
