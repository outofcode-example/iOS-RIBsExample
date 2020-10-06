//
//  NextViewController.swift
//  RIBsExample
//
//  Created by outofcode on 2020/10/04.
//  Copyright © 2020 outofcode. All rights reserved.
//

import RIBs
import SnapKit
import RxSwift
import RxCocoa

// MARK: - Presenter

protocol NextPresentableAction: class {
    var didClickButton: Observable<Void> { get }
}

protocol NextPresentableHandler: class {
    var timeText: Observable<String> { get }
}

protocol NextPresentable: Presentable {
    var action: NextPresentableAction? { get set }
    var handler: NextPresentableHandler? { get set }
}

// MARK: - ViewControllable

protocol NextViewControllable: ViewControllable {
    
}

// MARK: - ViewController

final class NextViewController: UIViewController, NextPresentable {
    
    // MARK: - UI Components
    
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.numberOfLines = 1
        button.titleLabel?.textAlignment = .center
        button.setTitle("Close", for: .normal)
        return button
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Properties
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Presentable
    
    var action: NextPresentableAction?
    var handler: NextPresentableHandler?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        action = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        bindPresentable()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(button)
        button.snp.makeConstraints { maker in
            maker.center.equalToSuperview()
        }
        
        view.addSubview(label)
        label.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.bottom.equalTo(button.snp.top).offset(-30)
        }
    }
    
    private func bindPresentable() {
        guard let handler = handler else { return }
        handler.timeText
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
    }
}

extension NextViewController: NextPresentableAction {
    var didClickButton: Observable<Void> {
        return button.rx.tap.asObservable()
    }
}

extension NextViewController: NextViewControllable {
    
}
