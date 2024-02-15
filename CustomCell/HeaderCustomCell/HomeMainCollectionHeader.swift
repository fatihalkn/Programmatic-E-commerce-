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
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
        
    }()
    
    private let titleArrifals: UILabel = {
       let label = UILabel()
        label.text = "New Arrifals🔥"
        label.textColor = .black
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    private let seeAllButton: UIButton = {
        let button = UIButton()
        button.setTitle("See All", for: .normal)
        button.setTitleColor(.main, for: .normal)
        button.backgroundColor = .clear
        button.contentHorizontalAlignment = .right
        return button
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupRegister()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureCollectionView()
        backgroundColor = .clear
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
        addSubview(titleArrifals)
        addSubview(seeAllButton)
        headerCollectionView.delegate = self
        headerCollectionView.dataSource = self
        
        titleArrifals.anchor(left: safeAreaLayoutGuide.leftAnchor,
                             bottom: safeAreaLayoutGuide.bottomAnchor,right: safeAreaLayoutGuide.centerXAnchor)
        
        seeAllButton.anchor(left: safeAreaLayoutGuide.centerXAnchor, bottom: safeAreaLayoutGuide.bottomAnchor,
                            right: safeAreaLayoutGuide.rightAnchor)
   
        
        headerCollectionView.anchor(top: safeAreaLayoutGuide.topAnchor, left: safeAreaLayoutGuide.leftAnchor,bottom: seeAllButton.topAnchor,right: safeAreaLayoutGuide.rightAnchor)
        
        
        
                            
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
        let cellHight: CGFloat = collectionView.frame.height
        return(.init(width: cellWidth, height: cellHight))
    }
    
    
}
