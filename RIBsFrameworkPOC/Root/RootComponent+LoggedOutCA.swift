//
//  RootComponent+LoggedOutCA.swift
//  RIBsFrameworkPOC
//
//  Created by Manzar_Hussain on 18/02/18.
//  Copyright © 2018 Infosys Ltd. All rights reserved.
//

import RIBs

/// The dependencies needed from the parent scope of Root to provide for the LoggedOutCA scope.
// TODO: Update RootDependency protocol to inherit this protocol.
protocol RootDependencyLoggedOutCA: Dependency {
    // TODO: Declare dependencies needed from the parent scope of Root to provide dependencies
    // for the LoggedOutCA scope.
}

extension RootComponent: LoggedOutCADependency {

    // TODO: Implement properties to provide for LoggedOutCA scope.
}
