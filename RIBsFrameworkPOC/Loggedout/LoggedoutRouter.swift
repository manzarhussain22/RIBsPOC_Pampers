//
//  LoggedoutRouter.swift
//  RIBsFrameworkPOC
//
//  Created by Manzar_Hussain on 17/02/18.
//  Copyright © 2018 Infosys Ltd. All rights reserved.
//

import RIBs


protocol LoggedOutInteractable: Interactable {
    weak var router: LoggedOutRouting? { get set }
    weak var listener: LoggedOutListener? { get set }
}

protocol LoggedOutViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
    func showHomeScreen()
}

final class LoggedOutRouter: ViewableRouter<LoggedOutInteractable, LoggedOutViewControllable>, LoggedOutRouting {
    
    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: LoggedOutInteractable, viewController: LoggedOutViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    func cleanupViews() {
        
    }
    func navigateToHomeScreen() {
        viewController.showHomeScreen()
    }
    
}

