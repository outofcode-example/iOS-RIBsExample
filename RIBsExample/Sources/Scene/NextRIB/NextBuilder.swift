//
//  NextBuilder.swift
//  RIBsExample
//
//  Created by DH on 2020/10/04.
//  Copyright © 2020 outofcode. All rights reserved.
//

import RIBs

// MARK: - Component

protocol NextDependency: Dependency {
    var title: String { get set }
}

final class NextComponent: Component<NextDependency> {}

// MARK: - Builder

protocol NextBuilable: Buildable {
    func build(with listener: NextListener, title: String) -> NextRouting
}

final class NextBuilder: Builder<NextDependency>, NextBuilable {

    func build(with listener: NextListener, title: String) -> NextRouting {
        dependency.title = title
        let component = NextComponent(dependency: dependency)
        let viewController = NextViewController()
        let interactor = NextInteractor(component: component,
                                        presenter: viewController)
        interactor.listener = listener
        
        return NextRouter(interactor: interactor, viewController: viewController)
    }
}
