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

// MARK: - Routing

protocol MainRouting: ViewableRouting {
    func presentNext()
}

// MARK: - Interactable

//protocol MainListener: class {
//    func detachImageDetailRIB()
//}

protocol MainInteractable: Interactable {
    var router: MainRouting? { get set }
//    var listener: MainListener? { get set }
}

// MARK: - Interactor

final class MainInteractor: PresentableInteractor<MainPresentable>,
                            MainInteractable {
    private let buttonTextRelay: BehaviorRelay<String>
    
    weak var router: MainRouting?
//    weak var listener: MainListener?
  
    init(buttonText: String,
         presenter: MainPresentable) {
        buttonTextRelay = .init(value: buttonText)
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
                self?.router?.presentNext()
            }
            .disposeOnDeactivate(interactor: self)
    }
}

extension MainInteractor: MainPresentableHandler {
    var buttonText: Observable<String> {
        return buttonTextRelay.asObservable()
    }
}
