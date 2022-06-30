//
//  ProductsViewModel.swift
//  SocialWatchApp WatchKit Extension
//
//  Created by Aydın Serhat SEZEN on 29.06.2022.
//

import Foundation
import Combine

// MARK: - View Model
class ProductsViewModel: ObservableObject {
    private var cancellables = [AnyCancellable]()
    let dispatcher = NetworkDispatcher()
    let apiClient = APIClient(baseURL: "https://dummyjson.com")
    
    @Published var products: [Product] = []

    init() {
        apiClient.dispatch(GetProducts())
            .sink(receiveCompletion: { _ in },
                  receiveValue: { value in
                DispatchQueue.main.async {
                    self.products = value.products
                }
            })
            .store(in: &cancellables)
    }
}
