//
//  ViewController.swift
//  RIBsExample
//
//  Created by outofcode on 2020/10/03.
//  Copyright © 2020 outofcode. All rights reserved.
//

import RIBs
import SnapKit
import RxSwift
import RxCocoa

// MARK: - Presenter

protocol MainPresentableAction: class {
    var didClickButton: Observable<Void> { get }
}

protocol MainPresentableHandler: class {
    var buttonText: Observable<String> { get }
}

protocol MainPresentable: Presentable {
    var action: MainPresentableAction? { get set }
    var handler: MainPresentableHandler? { get set }
}

// MARK: - ViewControllable

protocol MainViewControllable: ViewControllable {
    func present(_ viewController: ViewControllable, animated: Bool)
    func dismiss(_ viewController: ViewControllable, animated: Bool)
}

// MARK: - ViewController

final class MainViewController: UIViewController, MainPresentable {
    
    // MARK: - UI Components
    
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        return button
    }()
    
    // MARK: - Properties
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Presentable
    
    var action: MainPresentableAction?
    var handler: MainPresentableHandler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        bindPresentable()
    }
    
    private func setupView() {
        view.addSubview(button)
        button.snp.makeConstraints { maker in
            maker.center.equalToSuperview()
        }
    }
    
    private func bindPresentable() {
        action = self
        
        guard let handler = handler else { return }
        handler.buttonText
            .bind(to: button.rx.title(for: .normal))
            .disposed(by: disposeBag)
    }
}

extension MainViewController: MainPresentableAction {
    var didClickButton: Observable<Void> {
        return button.rx.tap.asObservable()
    }
}

extension MainViewController: MainViewControllable {
    func present(_ viewController: ViewControllable, animated: Bool) {
        present(viewController.uiviewController, animated: animated)
    }
    
    func dismiss(_ viewController: ViewControllable, animated: Bool) {
        guard !viewController.uiviewController.isBeingDismissed else { return }
        viewController.uiviewController.dismiss(animated: animated)
    }
}
