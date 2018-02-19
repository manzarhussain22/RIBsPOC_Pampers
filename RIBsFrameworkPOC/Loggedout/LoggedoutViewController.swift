//
//  LoggedoutViewController.swift
//  RIBsFrameworkPOC
//
//  Created by Manzar_Hussain on 17/02/18.
//  Copyright © 2018 Infosys Ltd. All rights reserved.
//

import RIBs
import RxCocoa
import RxSwift
import SnapKit
import UIKit


protocol LoggedOutPresentableListener: class {
    func login()
}

final class LoggedOutViewController: UIViewController, LoggedOutPresentable, LoggedOutViewControllable {
    let deviceHeight = UIScreen.main.bounds.size.height
    @IBOutlet weak var logoTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var subHeaderTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var facebookButton: UIButton!
    weak var listener: LoggedOutPresentableListener?
    
    init() {
        super.init(nibName: "LoggedOut", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Method is not supported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = UIColor.white
        buildUI()
        
    }
    private func buildUI() {
        logoTopConstraint.constant = (68.0/568.0) * deviceHeight
        subHeaderTopConstraint.constant = (49.0/568.0) * deviceHeight
        
    }

    @IBAction func facebuttonTapped(_ sender: Any) {
        self.listener?.login()
    }
    
    func showHomeScreen() {
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "HomeViewController")
        present(vc, animated: true, completion: nil)
    }
}
