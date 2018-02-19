//
//  RootActionable.swift
//  RIBsFrameworkPOC
//
//  Created by Manzar_Hussain on 18/02/18.
//  Copyright © 2018 Infosys Ltd. All rights reserved.
//

import RxSwift

public protocol RootActionableItem: class {
    func waitForSplash() -> Observable<(LoggedOutActionableItem, ())>
}

