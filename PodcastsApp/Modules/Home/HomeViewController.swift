//
//  HomeViewController.swift
//  PodcastsApp
//
//  Created by Armstrong on 15/11/22.
//

import UIKit
import Foundation

class HomeViewController: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let viewModelBanner = BannersViewModel()
    let viewModelMusic = MusicsViewModel()
    
    var countBanner: Int = 1
    var countMusic: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getDataBanner(q: "makna")
        getDataMusic(q: "reality club")
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
            self.countBanner = self.viewModelBanner.numberOfBanners
//            self.setup()
//            self.collectionView.reloadData()
            
        }
    }
    
    func getDataMusic(q: String) {
        viewModelMusic.searchMusic(q: q) { [weak self] (_) in
            guard let `self` = self else { return }
            self.countMusic = self.viewModelMusic.numberOfMusic
            self.setup()
            self.collectionView.reloadData()
            
            
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        showEpisodesViewController(banner: viewModelBanner.banner(at: indexPath.row))
//        print("log \(indexPath.row)")
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
            return self.countBanner
//            return 5
            
        }
        else {
            if section == 0 {
                return 1
            }
            else {
                return self.countMusic
//                return 10
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
                
                cell.collectionView.dataSource = self
                cell.collectionView.delegate = self
                
                return cell
            }
            else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeItemCollectionViewCellId", for: indexPath) as! HomeItemCollectionViewCell
                
                let index = indexPath.row
                let releaseDate = viewModelMusic.musicReleaseDate(at: index)
                
                cell.labelTitle.text = viewModelMusic.musicTrackName(at: index)
                cell.labelRelease.text = "Release date: \(releaseDate)"
                cell.imageView.kf.setImage(with: URL(string: viewModelMusic.musicImagUrl(at: index))) { (result) in
                    switch result {
                    case.success:
                        cell.imageView.contentMode = .scaleAspectFill
                        cell.imageView.layer.cornerRadius = 10
                        cell.imageView.layer.masksToBounds = true
                    case .failure:
                        cell.imageView.contentMode = .center
                        cell.imageView.image = UIImage(systemName: "photo")
                    }
                }
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
