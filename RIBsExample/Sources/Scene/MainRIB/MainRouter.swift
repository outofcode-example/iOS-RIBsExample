//
//  MainRouter.swift
//  RIBsExample
//
//  Created by DH on 2020/10/03.
//  Copyright © 2020 outofcode. All rights reserved.
//

import RIBs

final class MainRouter: LaunchRouter<MainInteractable, MainViewControllable> {
    override init(interactor: MainInteractable,
                  viewController: MainViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}

extension MainRouter: MainRouting {
    func presentNext() {
        print("show")
        // 나중에 여기에 present를 채울겁니다.
    }
}
