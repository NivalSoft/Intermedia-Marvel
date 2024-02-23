//
//  Republished.swift
//  Intermedia-Marvel
//
//  Created by Nicolas Famularo on 23/02/2024.
//

import SwiftUI
import Combine

@propertyWrapper
struct Republished<Obj: ObservableObject> {
    private var storage: Obj
    private var subscription: AnyCancellable? = nil

    init(wrappedValue: Obj) {
        self.storage = wrappedValue
    }

    @available(*, unavailable, message: "Republished can only be used inside reference types that conform to ObservableObject")
    var wrappedValue: Obj {
        get { fatalError() }
        set { fatalError() }
    }

    static subscript<EnclosingSelf: ObservableObject>(
        _enclosingInstance enclosing: EnclosingSelf,
        wrapped wrappedKeyPath: ReferenceWritableKeyPath<EnclosingSelf, Obj>,
        storage storageKeyPath: ReferenceWritableKeyPath<EnclosingSelf, Republished<Obj>>
    ) -> Obj where EnclosingSelf.ObjectWillChangePublisher == ObservableObjectPublisher {
        get {
            // Connect child's objectWillChange to parent's objectWillChange.
            if enclosing[keyPath: storageKeyPath].subscription == nil {
                let parentPublisher = enclosing.objectWillChange
                let childPublisher = enclosing[keyPath: storageKeyPath].storage.objectWillChange
                enclosing[keyPath: storageKeyPath].subscription = childPublisher.sink { _ in
                    parentPublisher.send()
                }
            }

            return enclosing[keyPath: storageKeyPath].storage
        }
        set {
            // Cancel old child's connection to parent.
            if enclosing[keyPath: storageKeyPath].subscription != nil {
                enclosing[keyPath: storageKeyPath].subscription = nil
            }

            enclosing[keyPath: storageKeyPath].storage = newValue

            // Connect new child's objectWillChange to parent's objectWillChange.
            let parentPublisher = enclosing.objectWillChange
            let childPublisher = newValue.objectWillChange
            enclosing[keyPath: storageKeyPath].subscription = childPublisher.sink { _ in
                parentPublisher.send()
            }

            // Must tell parent explicitly that it has changed.
            parentPublisher.send()
        }
    }
}
