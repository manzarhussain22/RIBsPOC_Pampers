//
//  LoggedOutCABuilder.swift
//  RIBsFrameworkPOC
//
//  Created by Manzar_Hussain on 18/02/18.
//  Copyright © 2018 Infosys Ltd. All rights reserved.
//

import RIBs

protocol LoggedOutCADependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class LoggedOutCAComponent: Component<LoggedOutCADependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol LoggedOutCABuildable: Buildable {
    func build(withListener listener: LoggedOutCAListener) ->(router : LoggedOutCARouting, actionItem: LoggedOutActionableItem)
}

final class LoggedOutCABuilder: Builder<LoggedOutCADependency>, LoggedOutCABuildable {

    override init(dependency: LoggedOutCADependency) {
        super.init(dependency: dependency)
    }
    
    func build(withListener listener: LoggedOutCAListener) -> (router: LoggedOutCARouting, actionItem: LoggedOutActionableItem) {
        _ = LoggedOutCAComponent(dependency: dependency)
        let viewController = LoggedOutCAViewController()
        let interactor = LoggedOutCAInteractor(presenter: viewController)
        interactor.listener = listener
        let router = LoggedOutCARouter(interactor: interactor, viewController: viewController)
        
        return (router, interactor)
    }
}
