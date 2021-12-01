//
//  PrivilegesCollectionTableViewCell.swift
//  LAWSON109_MINI_APP
//
//  Created by Pongsakorn Piya-ampornkul on 29/11/2564 BE.
//

import UIKit

class PrivilegesCollectionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var productModel: [MainViewModel.SectionViewModel] = []
    
    override func layoutSubviews() {
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}

extension PrivilegesCollectionTableViewCell {
    private func setupUI() {
        let nibCell = UINib(nibName: "ProductCollectionViewCell", bundle: nil)
        collectionView.register(nibCell, forCellWithReuseIdentifier: "collectionCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = false
        collectionView.reloadData()
        collectionView.backgroundColor = UIColor.rgb(red: 229, green: 237, blue: 240)
    }
}
extension PrivilegesCollectionTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let productList = productModel.filter { $0.type == BZBS_CAMPAIGN_TYPE }
        return productList.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        let inset = 10
        return UIEdgeInsets(top: CGFloat(inset), left: CGFloat(inset), bottom: CGFloat(inset), right: CGFloat(inset))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  50
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionViewSize/2, height: collectionViewSize/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! ProductCollectionViewCell
        guard !productModel.isEmpty else { return cell }
        let productList = productModel.filter { $0.type == BZBS_CAMPAIGN_TYPE }
        
        let url = URL(string: productList[indexPath.row].image_url ?? "")
        if let theProfileImageUrl = url {
            do {
                
                let imageData = try Data(contentsOf: theProfileImageUrl as URL)
                cell.imageView.image = UIImage(data: imageData)
                let mainString = "Use : \(productList[indexPath.row].line1 ?? "") Points"
                let stringToColor = "\(productList[indexPath.row].line1 ?? "") Points"
                let range = (mainString as NSString).range(of: stringToColor)
                let mutableAttributedString = NSMutableAttributedString.init(string: mainString)
                mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.rgb(red: 4, green: 119, blue: 191), range: range)
                cell.titleLabel.attributedText = mutableAttributedString
                cell.titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
                
                
                cell.titleLabel2.textColor = UIColor.black
                cell.titleLabel2.font = UIFont.systemFont(ofSize: 16)
                cell.titleLabel2.text = productList[indexPath.row].line2 ?? ""
                cell.contentView.layer.cornerRadius = 5
                cell.contentView.layer.borderWidth = 1
                cell.contentView.layer.borderColor = CGColor(red: 220, green: 220, blue: 220, alpha: 0)
            } catch {
                print("Unable to load data: \(error)")
            }
        }
        return cell
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        collectionView.layoutIfNeeded()
        collectionView.frame = CGRect(x: 0, y: 0, width: targetSize.width , height: 1)
        return collectionView.collectionViewLayout.collectionViewContentSize
    }
}

extension String {
    func attributedStringWithColor(_ strings: [String], color: UIColor, characterSpacing: UInt? = nil) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        for string in strings {
            let range = (self as NSString).range(of: string)
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        }
        
        guard let characterSpacing = characterSpacing else {return attributedString}
        
        attributedString.addAttribute(NSAttributedString.Key.kern, value: characterSpacing, range: NSRange(location: 0, length: attributedString.length))
        
        return attributedString
    }
}
