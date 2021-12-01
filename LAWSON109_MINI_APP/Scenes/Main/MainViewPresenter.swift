//
//  MainViewPresenter.swift
//  LAWSON109_MINI_APP
//
//  Created by Pongsakorn Piya-ampornkul on 26/11/2564 BE.
//

import Foundation

protocol MainViewPresenterProtocol {
    var view: MainViewControllerProtocol? { get set }
    func showNewsPromotion(response: [MainViewModel.Response])
    func showDashboardDetail(response: [MainViewModel.SectionResponse])
}

class MainViewPresenter {
    weak var view: MainViewControllerProtocol?
}

extension MainViewPresenter: MainViewPresenterProtocol {
    func showDashboardDetail(response: [MainViewModel.SectionResponse]) {
        let listDashboard = response.map { data in
            return MainViewModel.SectionViewModel(type: data.type ?? "",
                                                  size: data.size ?? "",
                                                  imgtype: data.imgtype ?? "",
                                                  wallet_verify_success_type: data.wallet_verify_success_type ?? "",
                                                  cat_header_th: data.cat_header_th ?? "",
                                                  cat_header_en: data.cat_header_en ?? "",
                                                  config: data.config ?? "",
                                                  id: data.id ?? "",
                                                  image_url: data.image_url ?? "",
                                                  line1: data.line1 ?? "",
                                                  line2: data.line2 ?? "",
                                                  line3: data.line3 ?? "",
                                                  ga_name: data.ga_name ?? "",
                                                  subcampaigndetails: data.subcampaigndetails?.compactMap { detail in
                                                    return MainViewModel.SectionViewModel.Subcampaigndetails(type: detail.type ?? "", imgtype: detail.imgtype ?? "", wallet_verify_success_type: detail.wallet_verify_success_type ?? "", id: detail.id ?? "", image_url: detail.image_url ?? "", ga_label: detail.ga_label ?? "", line1: detail.line1 ?? "", line2: detail.line2 ?? "", line3: detail.line3 ?? "", ga_name: detail.ga_name ?? "")
                                                  } ?? [])
        }
        view?.displayDashboard(viewModel: listDashboard)
    }
    
    func showNewsPromotion(response: [MainViewModel.Response]) {
        let listData = response.map { data in
            return MainViewModel.ViewModel(id: data.ID ?? 0,
                                           ReferenceCode: data.ReferenceCode ?? "",
                                           Name: data.Name ?? "",
                                           AgencyId: data.AgencyId ?? 0,
                                           StartDate: data.StartDate ?? 0,
                                           IsConditionPass: data.IsConditionPass ?? false,
                                           DayProceed: data.DayProceed ?? 0,
                                           FullImageUrl: data.FullImageUrl ?? "")
        }
        print("Debug :: \(listData)")
        view?.displayCollapse(viewModel: listData)
    }
}
