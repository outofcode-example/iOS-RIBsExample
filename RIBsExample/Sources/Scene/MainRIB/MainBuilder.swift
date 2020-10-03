//
//  MainBuilder.swift
//  RIBsExample
//
//  Created by outofcode on 2020/10/03.
//  Copyright © 2020 outofcode. All rights reserved.
//

import RIBs

// MARK: - Component

protocol MainDependency: Dependency {
    var buttonText: String { get }
}

final class MainComponent: MainDependency {
    var buttonText: String { "Hello, RIBs\nClick Button!" }
}

final class MainComponentTest: MainDependency {
    var buttonText: String { "Test" }
}

// MARK: - Builder

protocol MainBuilable: Buildable {
    func build() -> LaunchRouting
}

final class MainBuilder: Builder<MainDependency>, MainBuilable {
    
    init() {
        super.init(dependency: MainComponent())
    }
    
    func build() -> LaunchRouting {
        let viewController = MainViewController()

        let interactor = MainInteractor(buttonText: dependency.buttonText,
                                        presenter: viewController)
        
        return MainRouter(interactor: interactor,
                          viewController: viewController)
    }
}
