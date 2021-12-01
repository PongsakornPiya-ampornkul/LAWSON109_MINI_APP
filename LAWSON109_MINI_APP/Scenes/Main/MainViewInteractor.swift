//
//  MainViewInteractor.swift
//  LAWSON109_MINI_APP
//
//  Created by Pongsakorn Piya-ampornkul on 26/11/2564 BE.
//

import Foundation
import Alamofire

protocol MainViewBusinessLogic {
    func fetchProductDetail()
    func fetchdashboardDetail()
}

protocol MainViewDataStore {
    
}

class MainViewInteractor: MainViewDataStore {
    var presenter: MainViewPresenterProtocol?
}

extension MainViewInteractor: MainViewBusinessLogic {
    func fetchProductDetail() {
        print(API_NEWS_PROMOTION)
        AF.request(API_NEWS_PROMOTION, method: .get)
            .responseJSON(completionHandler: {
                guard let data = $0.data else { return }
                if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers),
                   let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
                    print(String(decoding: jsonData, as: UTF8.self))
                } else {
                    print("json data malformed")
                }
            })
            .responseDecodable(of: [MainViewModel.Response].self) { data in
                self.presenter?.showNewsPromotion(response: data.value ?? [])
            }
    }
    
    func fetchdashboardDetail() {
        AF.request(API_DASHBOARD, method: .get)
            .responseJSON(completionHandler: {
                guard let data = $0.data else { return }
                if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers),
                   let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
                    print(String(decoding: jsonData, as: UTF8.self))
                } else {
                    print("json data malformed")
                }
            })
            .responseDecodable(of: [MainViewModel.SectionResponse].self) { data in
                self.presenter?.showDashboardDetail(response: data.value ?? [])
            }
    }
}

