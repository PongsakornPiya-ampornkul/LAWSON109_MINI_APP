//
//  MainViewModel.swift
//  LAWSON109_MINI_APP
//
//  Created by Pongsakorn Piya-ampornkul on 26/11/2564 BE.
//

import Foundation

struct MainViewModel {
    struct Request { }
    
    struct Response: Decodable {
        var ID: Int?
        var ReferenceCode: String?
        var Name: String?
        var AgencyId: Int?
        var StartDate: Int?
        var IsConditionPass: Bool?
        var DayProceed: Int?
        var FullImageUrl: String?
    }
    
    struct ViewModel {
        var ID: Int?
        var ReferenceCode: String?
        var Name: String?
        var AgencyId: Int?
        var StartDate: Int?
        var IsConditionPass: Bool?
        var DayProceed: Int?
        var FullImageUrl: String?
        
        
        init(id: Int, ReferenceCode: String, Name: String, AgencyId: Int, StartDate: Int, IsConditionPass: Bool, DayProceed: Int, FullImageUrl: String) {
            self.ID = id
            self.ReferenceCode = ReferenceCode
            self.Name = Name
            self.AgencyId = AgencyId
            self.StartDate = StartDate
            self.IsConditionPass = IsConditionPass
            self.DayProceed = DayProceed
            self.FullImageUrl = FullImageUrl
        }
    }
    
    struct SectionResponse: Decodable {
        var type: String?
        var size: String?
        var imgtype: String?
        var wallet_verify_success_type: String?
        var cat_header_th: String?
        var cat_header_en: String?
        var config: String?
        var id: String?
        var image_url: String?
        var line1: String?
        var line2: String?
        var line3: String?
        var ga_name: String?
        var subcampaigndetails: [Subcampaigndetails]?
        
        struct Subcampaigndetails: Decodable {
            var type: String?
            var imgtype: String?
            var wallet_verify_success_type: String?
            var id: String?
            var image_url: String?
            var ga_label: String?
            var line1: String?
            var line2: String?
            var line3: String?
            var ga_name: String?
        }
    }
    
    struct SectionViewModel {
        var type: String?
        var size: String
        var imgtype: String?
        var wallet_verify_success_type: String?
        var cat_header_th: String?
        var cat_header_en: String?
        var config: String?
        var id: String?
        var image_url: String?
        var line1: String?
        var line2: String?
        var line3: String?
        var ga_name: String?
        var subcampaigndetails: [Subcampaigndetails]?
        
        struct Subcampaigndetails {
            var type: String?
            var imgtype: String?
            var wallet_verify_success_type: String?
            var id: String?
            var image_url: String?
            var ga_label: String?
            var line1: String?
            var line2: String?
            var line3: String?
            var ga_name: String?
        }
        
        init(type: String, size: String, imgtype: String, wallet_verify_success_type: String, cat_header_th: String, cat_header_en: String, config: String, id: String, image_url: String, line1: String, line2: String, line3: String, ga_name: String, subcampaigndetails: [Subcampaigndetails]) {
            
            self.type = type
            self.size = size
            self.imgtype = imgtype
            self.wallet_verify_success_type = wallet_verify_success_type
            
            self.cat_header_th = cat_header_th
            self.cat_header_en = cat_header_en
            self.config = config
            self.id = id
            
            self.image_url = image_url
            self.line1 = line1
            self.line2 = line2
            self.line3 = line3
            self.subcampaigndetails = subcampaigndetails
        }
    }
}
