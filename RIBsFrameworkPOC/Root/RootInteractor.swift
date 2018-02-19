//
//  RootInteractor.swift
//  RIBsFrameworkPOC
//
//  Created by Manzar_Hussain on 17/02/18.
//  Copyright © 2018 Infosys Ltd. All rights reserved.
//

import RIBs
import RxSwift

protocol RootRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
    func routeToLoggedOut(withLocale locale:String) -> LoggedOutActionableItem
}

protocol RootPresentable: Presentable {
    weak var listener: RootPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol RootListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
    
}

final class RootInteractor: PresentableInteractor<RootPresentable>, RootInteractable, RootPresentableListener, RootActionableItem {
    
    weak var router: RootRouting?
    
    weak var listener: RootListener?
    
    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: RootPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }
    
    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    // MARK: - LoggedOutListener
    func didSplashFinishLoading() {
        let locale = Locale.preferredLanguages[0]
        let loggedOutActionableItem = router?.routeToLoggedOut(withLocale: locale)
        if let loggedOutActionableItem = loggedOutActionableItem {
            loggedOutActionableItemSubject.onNext(loggedOutActionableItem)
        }
    }
    
    private let loggedOutActionableItemSubject = ReplaySubject<LoggedOutActionableItem>.create(bufferSize: 1)
    
    func waitForSplash() -> Observable<(LoggedOutActionableItem, ())> {
        return loggedOutActionableItemSubject
            .map { (loggedOutItem: LoggedOutActionableItem) -> (LoggedOutActionableItem, ()) in
                (loggedOutItem, ())
        }
    }
}
