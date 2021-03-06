//
//  LoggedOutCARouter.swift
//  RIBsFrameworkPOC
//
//  Created by Manzar_Hussain on 18/02/18.
//  Copyright © 2018 Infosys Ltd. All rights reserved.
//

import RIBs

protocol LoggedOutCAInteractable: Interactable {
    weak var router: LoggedOutCARouting? { get set }
    weak var listener: LoggedOutCAListener? { get set }
}

protocol LoggedOutCAViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
    func replaceModal(viewController: UIViewController?)
}

final class LoggedOutCARouter: ViewableRouter<LoggedOutCAInteractable, LoggedOutCAViewControllable>, LoggedOutCARouting {
    func navigateToHomeScreen() {
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "HomeViewController")
        viewController.replaceModal(viewController: vc)
    }
    

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: LoggedOutCAInteractable, viewController: LoggedOutCAViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
}
