//
//  SplashScreenActionable.swift
//  RIBsFrameworkPOC
//
//  Created by Manzar_Hussain on 18/02/18.
//  Copyright © 2018 Infosys Ltd. All rights reserved.
//

import RxSwift

public protocol LoggedOutActionableItem: class {
    func launchLoggedOut(withLocale locale:String) -> Observable<(LoggedOutActionableItem, ())>
}

