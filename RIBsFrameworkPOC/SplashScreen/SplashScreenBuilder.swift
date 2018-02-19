//
//  SplashScreenBuilder.swift
//  RIBsFrameworkPOC
//
//  Created by Manzar_Hussain on 18/02/18.
//  Copyright © 2018 Infosys Ltd. All rights reserved.
//

import RIBs

protocol SplashScreenDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class SplashScreenComponent: Component<SplashScreenDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol SplashScreenBuildable: Buildable {
    func build(withListener listener: SplashScreenListener) -> SplashScreenRouting
}

final class SplashScreenBuilder: Builder<SplashScreenDependency>, SplashScreenBuildable {

    override init(dependency: SplashScreenDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: SplashScreenListener) -> SplashScreenRouting {
        _ = SplashScreenComponent(dependency: dependency)
        let viewController = SplashScreenViewController()
        let interactor = SplashScreenInteractor(presenter: viewController)
        interactor.listener = listener
        return SplashScreenRouter(interactor: interactor, viewController: viewController)
    }
}
