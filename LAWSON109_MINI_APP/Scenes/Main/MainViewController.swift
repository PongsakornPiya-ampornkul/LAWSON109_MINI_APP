//
//  MainViewController.swift
//  LAWSON109_MINI_APP
//
//  Created by Pongsakorn Piya-ampornkul on 26/11/2564 BE.
//

import UIKit

protocol MainViewControllerProtocol: AnyObject {
    func displayCollapse(viewModel: [MainViewModel.ViewModel])
    func displayDashboard(viewModel: [MainViewModel.SectionViewModel])
}

struct Section {
    var numberOfRow: Int
    var type: String
    var title: String
}

enum SectionType: String {
    case signIn = "SignIn"
    case slideProduct = "SlideProduct"
    case newsPromotion = "NewsPromotion"
    case priviLeges = "Privileges"
}

class MainViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    // UIRefreshControl
    var refreshControl = UIRefreshControl()
    // Model
    var collapseData = [MainViewModel.ViewModel]()
    var dashboardData = [MainViewModel.SectionViewModel]()
    
    var router: (MainViewRouterProtocol & MainViewDataPassing)?
    var interactor: (MainViewBusinessLogic & MainViewDataStore)?
    var sections: [Section] = []
    var dispatchGroup: DispatchGroup?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Loading.start()
        if collapseData.isEmpty || dashboardData.isEmpty {
            tableView.isHidden = true
        }
        
        connectAPI()
        addLogoToNavigationBarItem()
        addleftToNavigationItem()
        
        // Set refreshControl
        navigationController?.navigationBar.barTintColor = UIColor.white
        refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor.rgb(red: 4, green: 119, blue: 191)
        refreshControl.addTarget(self, action: #selector(refreshList), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func connectAPI() {
        dispatchGroup?.enter()
        interactor?.fetchProductDetail()
        dispatchGroup?.leave()
    }
    
    private func configureItems() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
    }
    
    func setupView() {
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.white
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.separatorColor = .clear
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView?.isHidden = true
        tableView.backgroundView = nil
    }
    
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch SectionType(rawValue: sections[section].type) {
        case .signIn:
            return 1
        case .slideProduct:
            return 1
        case .newsPromotion:
            return 1
        case .priviLeges:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var identifier: String = ""
        switch SectionType(rawValue: sections[indexPath.section].type) {
        case .signIn:
            identifier = HeaderTableViewCell.reuseIdentifier
        case .slideProduct:
            identifier = AdvertTableViewCell.reuseIdentifier
        case .newsPromotion:
            identifier = CollapseTableViewCell.reuseIdentifier
        case .priviLeges:
            identifier = PrivilegesCollectionTableViewCell.reuseIdentifier
        default:
            break
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        configure(for: cell, at: indexPath)
        return cell
    }
    
    private func configure(for cell: UITableViewCell, at indexPath: IndexPath) {
        switch SectionType(rawValue: sections[indexPath.section].type) {
        case .signIn:
            if let cell = cell as? HeaderTableViewCell {
                //title
                cell.titleLabel.text = TITLE_NAME
                cell.titleLabel.font = UIFont.systemFont(ofSize: 14)
                cell.titleLabel.textColor = UIColor.rgb(red: 4, green: 119, blue: 191)
                
                //button
                cell.signBtn.setTitle(TITLE_BUTTON_NAME, for: .normal)
                cell.signBtn.setTitleColor(UIColor.white, for: .normal)
                cell.signBtn.contentEdgeInsets = UIEdgeInsets(top: 10, left: 30, bottom: 10, right: 30)
                cell.signBtn.backgroundColor = UIColor.rgb(red: 4, green: 119, blue: 191)
                cell.signBtn.layer.cornerRadius = 5
            }
        case .slideProduct:
            if let cell = cell as? AdvertTableViewCell {
                let data = dashboardData.map { datas in
                    return datas.subcampaigndetails.map { list in
                        return list
                    }
                }
                cell.imageViewModel = data.first??.compactMap { $0.image_url } ?? []
            }
        case .newsPromotion:
            if let cell = cell as? CollapseTableViewCell {
                cell.pager.backgroundColor = UIColor.white
                cell.imageViewModel = collapseData
            }
        case .priviLeges:
            if let cell = cell as? PrivilegesCollectionTableViewCell {
                cell.productModel = dashboardData
            }
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch SectionType(rawValue: sections[section].type) {
        case .signIn:
            return 0
        case .slideProduct:
            return 0
        case .newsPromotion:
            return 50
        case .priviLeges:
            return 50
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch SectionType(rawValue: sections[section].type) {
        case .signIn:
            return nil
        case .slideProduct:
            return nil
        case .newsPromotion:
            return headerNewsViewSet()
        case .priviLeges:
            return headerPrivilegesViewSet()
        default:
            return nil
        }
    }
}

extension MainViewController: MainViewControllerProtocol {
    
    @objc func buttonAction() {
        print("buttonAction")
    }
    
    @objc func refreshList() {
        refreshControl.endRefreshing()
        tableView.reloadData()
    }
    
    func displayDashboard(viewModel: [MainViewModel.SectionViewModel]) {
        guard !viewModel.isEmpty else { return }
        dashboardData = viewModel
        self.tableView.reloadData()
        if !dashboardData.isEmpty || !collapseData.isEmpty {
            Loading.stop()
            self.tableView.isHidden = false
        }
    }
    
    func displayCollapse(viewModel: [MainViewModel.ViewModel]) {
        guard !viewModel.isEmpty else { return }
        interactor?.fetchdashboardDetail()
        collapseData = viewModel
        dispatchGroup = DispatchGroup()
        dispatchGroup?.notify(queue: .main) {
            self.setupView()
            self.handleHeaderSection()
            Utils.registerNib(for: self.tableView,
                              with: HeaderTableViewCell.reuseIdentifier,
                              AdvertTableViewCell.reuseIdentifier ,
                              CollapseTableViewCell.reuseIdentifier,
                              PrivilegesCollectionTableViewCell.reuseIdentifier)
        }
    }
    
    func handleHeaderSection() {
        let parcels: [Section] = []
        sections.append(Section(numberOfRow: 0, type: "SignIn", title: "SignIn"))
        sections.append(Section(numberOfRow: 1, type: "SlideProduct", title: "SlideProduct"))
        sections.append(Section(numberOfRow: 2, type: "NewsPromotion", title: "NewsPromotion"))
        sections.append(Section(numberOfRow: 3, type: "Privileges", title: "PriviLeges"))
        sections.append(contentsOf: parcels)
    }
    
    func headerNewsViewSet() -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.white
        
        //button left
        let titleLabel = UILabel(frame: CGRect(x: 20, y: 5, width: 200, height: 44))
        titleLabel.textAlignment = .left
        headerView.addSubview(titleLabel)
        titleLabel.textColor = UIColor.rgb(red: 4, green: 119, blue: 191)
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        let textTitle = dashboardData.filter { title in
            title.type == CAR_HEADER_TYPE && title.cat_header_en == "News & Promotion"
        }
        titleLabel.text = textTitle.compactMap { $0.cat_header_en }.reduce("", +)
        
        //button right
        let buttonMore = UIButton(frame: CGRect(x: -20, y: 5, width: tableView.frame.width, height: 44))
        buttonMore.setTitle(MORE_BUTTON, for: .normal)
        buttonMore.contentHorizontalAlignment = .right
        buttonMore.setTitleColor(UIColor.rgb(red: 4, green: 119, blue: 191), for: .normal)
        buttonMore.translatesAutoresizingMaskIntoConstraints = true
        buttonMore.addTarget(self, action: #selector(buttonAction), for: UIControl.Event.touchUpInside)
        headerView.addSubview(buttonMore)
        return headerView
    }
    
    func headerPrivilegesViewSet() -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.rgb(red: 229, green: 237, blue: 240)
        
        //button left
        let titleLabel = UILabel(frame: CGRect(x: 20, y: 5, width: 200, height: 44))
        titleLabel.textAlignment = .left
        headerView.addSubview(titleLabel)
        titleLabel.textColor = UIColor.rgb(red: 4, green: 119, blue: 191)
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        let textTitle = dashboardData.filter { title in
            title.type == CAR_HEADER_TYPE && title.cat_header_en == "Privileges"
        }
        titleLabel.text = textTitle.compactMap { $0.cat_header_en }.reduce("", +)
        
        //button right
        let buttonMore = UIButton(frame: CGRect(x: -20, y: 5, width: tableView.frame.width, height: 44))
        buttonMore.setTitle(MORE_BUTTON, for: .normal)
        buttonMore.contentHorizontalAlignment = .right
        buttonMore.setTitleColor(UIColor.rgb(red: 4, green: 119, blue: 191), for: .normal)
        buttonMore.translatesAutoresizingMaskIntoConstraints = true
        buttonMore.addTarget(self, action: #selector(buttonAction), for: UIControl.Event.touchUpInside)
        headerView.addSubview(buttonMore)
        return headerView
    }
}

struct Utils {
    private init() { }
    static func registerNib(for view: AnyObject, with nibNames: String...) {
        if let tableView = view as? UITableView {
            nibNames.forEach {
                tableView.register(UINib(nibName: $0, bundle: nil), forCellReuseIdentifier: $0)
            }
        }
        
        if let collectionView = view as? UICollectionView {
            nibNames.forEach {
                collectionView.register(UINib(nibName: $0, bundle: nil), forCellWithReuseIdentifier: $0)
            }
        }
    }
    
}

extension UIViewController {
    
    func addLogoToNavigationBarItem() {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "logoImageView")
        
        let contentView = UIView()
        self.navigationItem.titleView = contentView
        self.navigationItem.titleView?.addSubview(imageView)
        imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
    func addleftToNavigationItem() {
        let logoImage = UIImage.init(named: "mapNavigation")
        let logoImageView = UIImageView.init(image: logoImage)
        logoImageView.contentMode = .scaleAspectFit
        let imageItem = UIBarButtonItem.init(customView: logoImageView)
        let widthConstraint = logoImageView.widthAnchor.constraint(equalToConstant: 30)
        let heightConstraint = logoImageView.heightAnchor.constraint(equalToConstant: 30)
        heightConstraint.isActive = true
        widthConstraint.isActive = true
        navigationItem.leftBarButtonItem =  imageItem
    }
}
