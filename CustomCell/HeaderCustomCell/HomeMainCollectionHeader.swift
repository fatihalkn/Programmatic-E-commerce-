//
//  HomeMainCollectionHeader.swift
//  E-Commerce
//
//  Created by Fatih on 13.02.2024.
//

import UIKit

class HomeMainCollectionHeader: UICollectionReusableView {
    static let identifier = "HomeMainCollectionHeader"
    
    private let headerCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemGray
        return collectionView
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupRegister()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureCollectionView()
        backgroundColor = .brown
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupRegister() {
        headerCollectionView.register(HeaderCollectionViewCell.self,
                                      forCellWithReuseIdentifier: HeaderCollectionViewCell.identifier)
    }
    
    func configureCollectionView() {
        addSubview(headerCollectionView)
        headerCollectionView.delegate = self
        headerCollectionView.dataSource = self
        headerCollectionView.anchor(top: safeAreaLayoutGuide.topAnchor,
                                    left: safeAreaLayoutGuide.leftAnchor,
                                    bottom: safeAreaLayoutGuide.bottomAnchor,
                                    right: safeAreaLayoutGuide.rightAnchor)
    }
}

extension HomeMainCollectionHeader: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = headerCollectionView.dequeueReusableCell(withReuseIdentifier: HeaderCollectionViewCell.identifier, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth: CGFloat = collectionView.frame.width
        let cellHight: CGFloat = 180
        return(.init(width: cellWidth, height: cellHight))
    }
    
    
}
