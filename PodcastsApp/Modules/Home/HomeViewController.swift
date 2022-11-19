//
//  HomeViewController.swift
//  PodcastsApp
//
//  Created by Armstrong on 15/11/22.
//

import UIKit

class HomeViewController: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModelBanner = BannersViewModel()
    var count: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getDataBanner(q: "Makna")
    }
    
    func setup() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
}

extension HomeViewController: UICollectionViewDelegate {
    
    func getDataBanner(q: String) {
        viewModelBanner.searchPodcasts(q: q) { [weak self] (_) in
            guard let `self` = self else { return }
            self.count = self.viewModelBanner.numberOfBanners
           
            self.collectionView.reloadData()
            
            self.setup()
            
        }
    }
}

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
   
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == self.collectionView {
            return 2
        }
        else {
            return 1
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView != self.collectionView {
            return self.count
//            return 5
            
        }
        else {
            if section == 0 {
                return 1
            }
            else {
                return 10
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView != self.collectionView {
            
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bannerId", for: indexPath) as! BannerViewCell
    
            let index = indexPath.row
            cell.imageViewBanner.kf.setImage(with: URL(string: viewModelBanner.bannerImagUrl(at: index))) { (result) in
                switch result {
                case.success:
                    cell.imageViewBanner.contentMode = .scaleAspectFill
                    cell.imageViewBanner.layer.cornerRadius = 15
                    cell.imageViewBanner.layer.masksToBounds = true
                case .failure:
                    cell.imageViewBanner.contentMode = .center
                    cell.imageViewBanner.image = UIImage(systemName: "photo")
                }
            }

            return cell
            
        }
        else {
            
            if indexPath.section == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeItemBannerViewCellId", for: indexPath) as! HomeItemBannerViewCell
                
//                cell.collectionView.backgroundColor = .clear
//                cell.collectionView.backgroundColor = .yellow
                
                cell.collectionView.dataSource = self
                cell.collectionView.delegate = self
                
                
                return cell
            }
            else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeItemCollectionViewCellId", for: indexPath) as! HomeItemCollectionViewCell
               
                cell.labelTitle.text = "Is it the Answer"
                cell.labelRelease.text = "Release date:  March, 23 - 2017"
                return cell
            }
            
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
           
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath)
          
            let labelPodcasts = view.viewWithTag(400) as! UILabel
            let labelTitle = view.viewWithTag(100) as! UILabel
            let labelDesc = view.viewWithTag(101) as! UILabel

            if indexPath.section == 0 {
                labelPodcasts.font = UIFont.systemFont(ofSize: 48, weight: .bold)
                labelPodcasts.isHidden = false
                labelPodcasts.text = "Podcasts"
                
                labelTitle.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
                labelTitle.isHidden = false
                labelTitle.text = "FazzTrack Weekly"
                
                labelDesc.font = UIFont.systemFont(ofSize: 14, weight: .regular)
                labelDesc.isHidden = false
                labelDesc.text = "FazzTrack Podcast Collection"
                
           } else{
               

               labelPodcasts.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
               labelPodcasts.isHidden = false
               labelPodcasts.text = "Collection"
               
               labelTitle.isHidden = true
               
               labelDesc.isHidden = true
           }
           
           return view
       }
    
}

//// MARK: - UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
            if collectionView == self.collectionView {
                if section == 0 {
                    return UIEdgeInsets(top: 0, left: 0, bottom: -10, right: 0)
                }
                else{
                    return UIEdgeInsets(top: -100, left: 0, bottom: 0, right: 0)
                }
            }
            else{
                return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 0)
            }
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 20
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            if section == 0 {
                return 10
            }
            else {
                return 0
            }
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

            if collectionView != self.collectionView {
                return CGSize(width: 285, height: 200)
            }
            else {
                if indexPath.section != 0 {
                    let screenWidth = UIScreen.main.bounds.width
                    let width = screenWidth
                    let height = 88.0
                    return CGSize(width: width, height: height)
                }
                else {
                    let screenWidth = UIScreen.main.bounds.width
                    return CGSize(width: screenWidth, height: 230)
                }
            }
            
            
        }
}
