//
//  MainBuilder.swift
//  RIBsExample
//
//  Created by outofcode on 2020/10/03.
//  Copyright © 2020 outofcode. All rights reserved.
//

import RIBs

// MARK: - Component

protocol MainDependency: Dependency {}

final class MainComponent: Component<MainDependency>, NextDependency {
    var title: String = ""
}

// MARK: - Builder

protocol MainBuilable: Buildable {
    func build() -> LaunchRouting
}

final class MainBuilder: Builder<MainDependency>, MainBuilable {

    func build() -> LaunchRouting {
        let component = MainComponent(dependency: dependency)
        let viewController = MainViewController()
        let interactor = MainInteractor(title: "Hello, RIBs\nClick Button!",
                                        presenter: viewController)
        
        let nextBuilder = NextBuilder(dependency: component)
        
        return MainRouter(nextBuilder: nextBuilder,
                          interactor: interactor,
                          viewController: viewController)
    }
}
