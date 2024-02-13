//
//  HomeController.swift
//  E-Commerce
//
//  Created by Fatih on 10.02.2024.
//

import UIKit

class HomeController: UIViewController {
    
    private let homePageCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 20
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegate()
        setupRegisterCell()
        view.backgroundColor = .white
        view.addSubview(homePageCollectionView)
        setupNavItems()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homePageCollectionView.frame = view.bounds
    }
    
    func setupRegisterCell() {
        homePageCollectionView.register(
            HomePageCustomCell.self,
            forCellWithReuseIdentifier: HomePageCustomCell.identifier
        )
        
        homePageCollectionView.register(
            HomeMainCollectionHeader.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: HomeMainCollectionHeader.identifier
        )
    }
    
    func setupDelegate() {
        homePageCollectionView.dataSource = self
        homePageCollectionView.delegate = self
    }
    
    private func setupNavItems() {
        let homeNavProfileView = HomeNavProfileView()
        let profileBarButton = UIBarButtonItem(customView: homeNavProfileView)
        navigationItem.leftBarButtonItems = [profileBarButton]
    }
}



//MARK: - Configure CollectionView

extension HomeController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = homePageCollectionView.dequeueReusableCell(withReuseIdentifier: HomePageCustomCell.identifier, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth: CGFloat = (collectionView.frame.width - (20 + 20 + 20)) / 2
        let cellHight: CGFloat = 180
        return(.init(width: cellWidth, height: cellHight))
    }
    
    //MARK: - HomePageHeader
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            return collectionView.dequeueReusableSupplementaryView(ofKind: kind,withReuseIdentifier: HomeMainCollectionHeader.identifier,for: indexPath)
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.size.width, height: view.frame.size.height / 3)
    }
    
    
    
}
