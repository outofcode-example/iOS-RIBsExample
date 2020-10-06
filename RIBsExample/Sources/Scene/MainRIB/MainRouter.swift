//
//  MainRouter.swift
//  RIBsExample
//
//  Created by outofcode on 2020/10/03.
//  Copyright © 2020 outofcode. All rights reserved.
//

import RIBs

final class MainRouter: LaunchRouter<MainInteractable, MainViewControllable> {
    
    private let nextBuilder: NextBuilable
    private var nextRouter: NextRouting?
    
    init(nextBuilder: NextBuilable,
         interactor: MainInteractable,
         viewController: MainViewControllable) {
        self.nextBuilder = nextBuilder
        self.nextRouter = nil
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}

extension MainRouter: MainRouting {
    func attachNext() {
        let time = "Now is \(Date().description)"
        let router = nextBuilder.build(with: interactor, title: time)
        nextRouter = router
        attachChild(router)
        viewController.present(router.viewControllable, animated: true)
    }
    
    func detachNext() {
        guard let router = nextRouter else { return }
        viewController.dismiss(router.viewControllable, animated: true)
        nextRouter = nil
        detachChild(router)
    }
}
