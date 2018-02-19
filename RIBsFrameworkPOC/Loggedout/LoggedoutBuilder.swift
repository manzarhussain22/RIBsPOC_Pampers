//
//  LoggedoutBuilder.swift
//  RIBsFrameworkPOC
//
//  Created by Manzar_Hussain on 17/02/18.
//  Copyright © 2018 Infosys Ltd. All rights reserved.
//

import RIBs

protocol LoggedOutDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class LoggedOutComponent: Component<LoggedOutDependency> {
    
    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol LoggedOutBuildable: Buildable {
    func build(withListener listener: LoggedOutListener) -> (router: LoggedOutRouting, actionItem: LoggedOutActionableItem)
}

final class LoggedOutBuilder: Builder<LoggedOutDependency>, LoggedOutBuildable {
    
    override init(dependency: LoggedOutDependency) {
        super.init(dependency: dependency)
    }
    
    func build(withListener listener: LoggedOutListener) -> LoggedOutRouting {
        _ = LoggedOutComponent(dependency: dependency)
        let viewController = LoggedOutViewController()
        let interactor = LoggedOutInteractor(presenter: viewController)
        interactor.listener = listener
        return LoggedOutRouter(interactor: interactor, viewController: viewController)
    }
    
    func build(withListener listener: LoggedOutListener) -> (router: LoggedOutRouting, actionItem: LoggedOutActionableItem) {
        _ = LoggedOutComponent(dependency: dependency)
        let viewController = LoggedOutViewController()
        let interactor = LoggedOutInteractor(presenter: viewController)
        interactor.listener = listener
        let router = LoggedOutRouter(interactor: interactor, viewController: viewController)
        return (router, interactor)
    }
}
