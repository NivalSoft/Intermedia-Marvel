//
//  PageManager.swift
//  Intermedia-Marvel
//
//  Created by Nicolas Famularo on 23/02/2024.
//

import SwiftUI
import Combine

final class PageManager<Element: Codable>: ObservableObject {
    typealias FetchHandler = (Int, String?) -> AnyPublisher<PaginatedResponse<Element>, Error>
    
    @Published private var state = State.waiting
    
    @Published var elements: [Element] = []
    @Published var loading: Bool = false
    @Published var keyword: String? = nil
    
    private let fetchHandler: FetchHandler
    private var currentRequest: AnyCancellable?
    private var cancellables = Set<AnyCancellable>()
    private var currentPage: Int = 1
    
    init(waitForFirstRequest: Bool = false, fetchHandler: @escaping FetchHandler) {
        self.fetchHandler = fetchHandler
        
        if !waitForFirstRequest {
            fetchElements()
        }
        observersSetup()
    }
    
    deinit {
        currentRequest?.cancel()
    }
    
    private func observersSetup() {
        $keyword
            .dropFirst()
            .removeDuplicates()
            .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
            .sink(receiveValue: { [weak self] _ in
                self?.reload()
            })
            .store(in: &cancellables)
        
        $state
            .map { $0 == .loading }
            .removeDuplicates()
            .sink(receiveValue: { [weak self] isLoading in
                self?.loading = isLoading
            })
            .store(in: &cancellables)
    }
    
    func requestNewPage(for element: Element, reloadThreshold: Int = 5) where Element: Hashable {
        guard state == .waiting, element == elements[elements.count - reloadThreshold] else { return }
        fetchElements()
    }
    
    @objc func reload() {
        currentPage = 1
        state = .waiting
        fetchElements()
    }
    
    private func fetchElements() {
        currentRequest?.cancel()
        
        let page = currentPage
        if page == 1 {
            state = .loading
        }
        
        currentRequest = fetchHandler(page, keyword)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] response in
                    switch response {
                    case .failure:
                        self?.state = .reachedEnd
                        
                        if self?.elements.isEmpty == true {
                            self?.elements = []
                        }
                    default: break
                    }
                },
                receiveValue: { [weak self] response in
                    guard let self = self else { return }
                    
                    if page == 1 {
                        self.elements = []
                    }
                    
                    self.currentPage += 1
                    self.state = response.data?.isLast ?? true ? .reachedEnd : .waiting
                    withAnimation {
                        self.elements = page == 1 ? (response.data?.results ?? []) : self.elements + (response.data?.results ?? [])
                    }
                })
    }
    
    enum State {
        case loading
        case reachedEnd
        case waiting
    }
}

