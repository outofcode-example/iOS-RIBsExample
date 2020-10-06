//
//  NextRouter.swift
//  RIBsExample
//
//  Created by DH on 2020/10/04.
//  Copyright © 2020 outofcode. All rights reserved.
//

import RIBs

final class NextRouter: ViewableRouter<NextInteractable, NextViewControllable> {
    override init(interactor: NextInteractable,
                  viewController: NextViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}

extension NextRouter: NextRouting {
    
}
