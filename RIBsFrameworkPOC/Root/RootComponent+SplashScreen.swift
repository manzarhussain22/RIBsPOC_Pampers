//
//  RootComponent+SplashScreen.swift
//  RIBsFrameworkPOC
//
//  Created by Manzar_Hussain on 18/02/18.
//  Copyright © 2018 Infosys Ltd. All rights reserved.
//

import RIBs

/// The dependencies needed from the parent scope of Root to provide for the SplashScreen scope.
// TODO: Update RootDependency protocol to inherit this protocol.
protocol RootDependencySplashScreen: Dependency {
    // TODO: Declare dependencies needed from the parent scope of Root to provide dependencies
    // for the SplashScreen scope.
}

extension RootComponent: SplashScreenDependency {

    // TODO: Implement properties to provide for SplashScreen scope.
}
