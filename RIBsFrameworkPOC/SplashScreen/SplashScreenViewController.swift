//
//  SplashScreenViewController.swift
//  RIBsFrameworkPOC
//
//  Created by Manzar_Hussain on 18/02/18.
//  Copyright © 2018 Infosys Ltd. All rights reserved.
//

import RIBs
import RxSwift
import UIKit

protocol SplashScreenPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    func checkAndUpdateLoggedOut()
}

final class SplashScreenViewController: UIViewController, SplashScreenPresentable, SplashScreenViewControllable {
    func replaceModal(viewController: ViewControllable?) {
        targetViewController = viewController
        
        guard !animationInProgress else {
            return
        }
        
        if presentedViewController != nil {
            animationInProgress = true
            dismiss(animated: true) { [weak self] in
                if self?.targetViewController != nil {
                    self?.presentTargetViewController()
                } else {
                    self?.animationInProgress = false
                }
            }
        } else {
            presentTargetViewController()
        }
    }
    private var targetViewController: ViewControllable?
    private var animationInProgress = false
    
    private func presentTargetViewController() {
        if let targetViewController = targetViewController {
            animationInProgress = true
            present(targetViewController.uiviewController, animated: false) { [weak self] in
                self?.animationInProgress = false
            }
        }
    }
    
    

    weak var listener: SplashScreenPresentableListener?
    init() {
        super.init(nibName: "SplashScreen", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Method is not supported")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonTapped.rx.tap.subscribe(onNext: { [weak self] in
            self?.listener?.checkAndUpdateLoggedOut()
        })
            .disposed(by: disposeBag)
        
        //var basePresenter: RootViewController = BasePresenter()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    @IBOutlet weak var buttonTapped: UIButton!
        private let disposeBag = DisposeBag()
}
