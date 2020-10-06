//
//  NextInteractor.swift
//  RIBsExample
//
//  Created by outofcode on 2020/10/04.
//  Copyright © 2020 outofcode. All rights reserved.
//

import RIBs
import RxSwift
import RxCocoa

// MARK: - Listener

protocol NextListener: class {
    func detachNext()
}

// MARK: - Routing

protocol NextRouting: ViewableRouting {
    
}

// MARK: - Interactable

protocol NextInteractable: Interactable {
    var router: NextRouting? { get set }
    var listener: NextListener? { get set }
}

// MARK: - Interactor

final class NextInteractor: PresentableInteractor<NextPresentable>,
                            NextInteractable {
    private let timeTextRelay: BehaviorRelay<String>
    
    var router: NextRouting?
    var listener: NextListener?
  
    init(component: NextComponent,
         presenter: NextPresentable) {
        timeTextRelay = .init(value: component.dependency.title)
        super.init(presenter: presenter)
        presenter.handler = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        setup()
    }
    
    private func setup() {
        presenter.action?.didClickButton
            .bind { [weak self] in
                self?.listener?.detachNext()
            }
            .disposeOnDeactivate(interactor: self)
    }
}

extension NextInteractor: NextPresentableHandler {
    var timeText: Observable<String> {
        return timeTextRelay.asObservable()
    }
}
