//
//  SplashScreenRouter.swift
//  RIBsFrameworkPOC
//
//  Created by Manzar_Hussain on 18/02/18.
//  Copyright © 2018 Infosys Ltd. All rights reserved.
//

import RIBs

protocol SplashScreenInteractable: Interactable {
    weak var router: SplashScreenRouting? { get set }
    weak var listener: SplashScreenListener? { get set }
}

protocol SplashScreenViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
   func replaceModal(viewController: ViewControllable?)
}

final class SplashScreenRouter: ViewableRouter<SplashScreenInteractable, SplashScreenViewControllable>, SplashScreenRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: SplashScreenInteractable, viewController: SplashScreenViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    func cleanupViews() {
        if currentChild != nil {
            viewController.replaceModal(viewController: nil)
        }
    }
    //private let viewController: SplashScreenViewControllable
    private var currentChild: ViewableRouting?
}
