//
//  MainInteractor.swift
//  RIBsExample
//
//  Created by outofcode on 2020/10/03.
//  Copyright © 2020 outofcode. All rights reserved.
//

import RIBs
import RxSwift
import RxCocoa

// MARK: - Listener

protocol MainListener: class {
    
}

// MARK: - Routing

protocol MainRouting: ViewableRouting {
    func attachNext()
    func detachNext()
}

// MARK: - Interactable

protocol MainInteractable: Interactable, NextListener {
    var router: MainRouting? { get set }
    var listener: MainListener? { get set }
}

// MARK: - Interactor

final class MainInteractor: PresentableInteractor<MainPresentable>,
                            MainInteractable {
    private let buttonTextRelay: BehaviorRelay<String>
    
    var router: MainRouting?
    var listener: MainListener?
  
    init(title: String,
         presenter: MainPresentable) {
        buttonTextRelay = .init(value: title)
        super.init(presenter: presenter)
        presenter.handler = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        setup()
    }
    
    private func setup() {
        guard let action = presenter.action else { return }
        action.didClickButton
            .bind { [weak self] in
                self?.router?.attachNext()
            }
            .disposeOnDeactivate(interactor: self)
    }
}

extension MainInteractor: MainPresentableHandler {
    var buttonText: Observable<String> {
        return buttonTextRelay.asObservable()
    }
}

extension MainInteractor: MainListener {
    func detachNext() {
        router?.detachNext()
    }
}
