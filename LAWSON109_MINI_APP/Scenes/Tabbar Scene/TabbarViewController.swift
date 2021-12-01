//
//  TabbarViewController.swift
//  LAWSON109_MINI_APP
//
//  Created by Pongsakorn Piya-ampornkul on 26/11/2564 BE.
//
import UIKit

class TabbarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.black]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().frame(forAlignmentRect: CGRect(x: 0, y: 0, width: 10, height: 10))
    }
    
    private func setupView() {
        delegate = self
        UITabBar.appearance().tintColor = UIColor.rgb(red: 4, green: 119, blue: 191)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: .bold)], for: .normal)
        let home = MainViewRouter.shared.createModule()
        let privileges = UIViewController()
        let myCoupon = UIViewController()
        let promotion = UIViewController()
        let more = UIViewController()
        let titles: [String] = ["HOME",
                                "Privileges", "My Coupon", "Promotion", "More"]
        let images: [UIImage?] = [UIImage(systemName: "house.fill"), UIImage(systemName: "gift.fill"), UIImage(systemName: "ticket"), UIImage(systemName: "megaphone"), UIImage(systemName: "list.bullet")]
        viewControllers = setupViewController(home,
                                              privileges,
                                              myCoupon,
                                              promotion,
                                              more,
                                              titles: titles,
                                              images: images)
    }
    
    private func setupViewController(_ viewControllers: UIViewController..., titles: [String], images: [UIImage?]) -> [UINavigationController] {
        return viewControllers.enumerated()
            .map { index, element in
                element.tabBarItem = UITabBarItem(title: titles[index], image: images[index], tag: index)
                element.title = titles[index]
                return UINavigationController(rootViewController: element)
            }
        
    }
}

extension TabbarViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        guard let _  = viewController as? UINavigationController else { return }
        
    }
}
