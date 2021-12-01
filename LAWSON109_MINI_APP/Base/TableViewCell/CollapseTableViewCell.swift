//
//  CollapseTableViewCell.swift
//  LAWSON109_MINI_APP
//
//  Created by Pongsakorn Piya-ampornkul on 27/11/2564 BE.
//

import UIKit
import HSCycleGalleryView
import LoadingShimmer

class CollapseTableViewCell: UITableViewCell {
    
    @IBOutlet weak var pagerContainer: UIView!
    @IBOutlet weak var pageControl: UIPageControl!
    var imageViewModel: [MainViewModel.ViewModel] = []
    let pager = HSCycleGalleryView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 280))
    
    override func awakeFromNib() {
        super.awakeFromNib()
        LoadingShimmer.startCovering(pagerContainer, with: [])
        pager.register(cellClass: ImageCollectionViewCell.self, forCellReuseIdentifier: "ImageCollectionViewCell")
        pager.delegate = self
        pagerContainer.addSubview(pager)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.pager.reloadData()
            self.pageControl.isHidden = true
        }
        LoadingShimmer.stopCovering(pagerContainer)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension CollapseTableViewCell: HSCycleGalleryViewDelegate {
    func numberOfItemInCycleGalleryView(_ cycleGalleryView: HSCycleGalleryView) -> Int {
        let count = imageViewModel.count
        pageControl.numberOfPages = count
        pageControl.isHidden = !(count > 1)
        return count
    }
    
    func cycleGalleryView(_ cycleGalleryView: HSCycleGalleryView, cellForItemAtIndex index: Int) -> UICollectionViewCell {
        let cell = cycleGalleryView.dequeueReusableCell(withIdentifier: "ImageCollectionViewCell", for: IndexPath(item: index, section: 0)) as! ImageCollectionViewCell
        guard !imageViewModel.isEmpty else { return cell }
        let url = URL(string: imageViewModel[index].FullImageUrl ?? "")
        if let theProfileImageUrl = url {
            do {
                let imageData = try Data(contentsOf: theProfileImageUrl as URL)
                cell.backgroundView = UIImageView.init(image: UIImage.init(data: imageData))
            } catch {
                print("Unable to load data: \(error)")
            }
        }
        changeControl(currentIndex: index)
        return cell
    }
    
    func changeControl(currentIndex: Int) {
        pageControl.currentPage = currentIndex
    }
}
