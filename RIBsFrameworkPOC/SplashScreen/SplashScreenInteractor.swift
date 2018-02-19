//
//  SplashScreenInteractor.swift
//  RIBsFrameworkPOC
//
//  Created by Manzar_Hussain on 18/02/18.
//  Copyright © 2018 Infosys Ltd. All rights reserved.
//

import RIBs
import RxSwift

protocol SplashScreenRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
    func cleanupViews()
}

protocol SplashScreenPresentable: Presentable {
    weak var listener: SplashScreenPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol SplashScreenListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
    func didSplashFinishLoading()
}

final class SplashScreenInteractor: PresentableInteractor<SplashScreenPresentable>, SplashScreenInteractable, SplashScreenPresentableListener {

    weak var router: SplashScreenRouting?
    weak var listener: SplashScreenListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: SplashScreenPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        router?.cleanupViews()
        // TODO: Pause any business logic.
    }
    func checkAndUpdateLoggedOut()
    {
        listener?.didSplashFinishLoading()
        
    }
}
