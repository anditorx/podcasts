//
//  HomeViewController.swift
//  PodcastsApp
//
//  Created by Armstrong on 15/11/22.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
    }
    
    func setup() {
        collectionView.dataSource = self
        collectionView.delegate = self
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
        if collectionView == self.collectionView {
            if section == 0 {
               return 1
            }
            else {
                return 10
            }
        }
        else {
            return 5
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView !== self.collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bannerId", for: indexPath) as! BannerViewCell
    
            
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
                let item = indexPath.item
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
                let screenWidth = UIScreen.main.bounds.width
                return CGSize(width: 273, height: 187)
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
