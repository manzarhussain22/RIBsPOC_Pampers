//
//  LoggedOutCAViewController.swift
//  RIBsFrameworkPOC
//
//  Created by Manzar_Hussain on 18/02/18.
//  Copyright © 2018 Infosys Ltd. All rights reserved.
//

import RIBs
import RxSwift
import UIKit

protocol LoggedOutCAPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    func startGRSSignIn(with email:String, password:String)
}

final class LoggedOutCAViewController: UIViewController, LoggedOutCAPresentable, LoggedOutCAViewControllable {
    let deviceHeight = UIScreen.main.bounds.size.height
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signInButtonTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var pwdTextTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var emailTxtTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var subHeaderTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var logoTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var pwdTestField: UITextField!
    weak var listener: LoggedOutCAPresentableListener?
    
    init() {
        super.init(nibName: "LoggedOutCAViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Method is not supported")
    }
    override func viewDidLoad() {
        print("loaded CA")
        buildUI()
        signInButton.rx.tap.subscribe(onNext: { [weak self] in
            self?.listener?.startGRSSignIn(with: (self?.emailTxtField.text)!, password: (self?.pwdTestField.text)!)
        })
            .disposed(by: disposeBag)
    }

    func buildUI()
    {
        logoTopConstraint.constant = (42.0/568.0) * deviceHeight
        subHeaderTopConstraint.constant = (38.0/568.0) * deviceHeight
        emailTxtTopConstraint.constant = (53.0/568.0) * deviceHeight
        pwdTextTopConstraint.constant = (15.0/568.0) * deviceHeight
        signInButtonTopConstraint.constant = (40.0/568.0) * deviceHeight
    }
    
    @IBAction func signInButtonTapped(_ sender: Any) {
        listener?.startGRSSignIn(with: emailTxtField.text!, password: pwdTestField.text!)
    }
    private let disposeBag = DisposeBag()
    
    func replaceModal(viewController: UIViewController?)
        {
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
    private var targetViewController: UIViewController?
    private var animationInProgress = false
    
    private func presentTargetViewController() {
        if let targetViewController = targetViewController {
            animationInProgress = true
            present(targetViewController, animated: false) { [weak self] in
                self?.animationInProgress = false
            }
        }
    }
}


