//
//  Router.swift
//  Intermedia-Marvel
//
//  Created by Nicolas Famularo on 21/02/2024.
//

import SwiftUI

class Router: ObservableObject {
    @Published var path = NavigationPath()
    
    func push(_ destination: NavigationDestination) {
        path.append(destination)
    }
    
    func pop(_ steps: Int = 1) {
        path.removeLast(steps)
    }
       
    func popToRoot() {
        path = .init()
    }
}

extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}


