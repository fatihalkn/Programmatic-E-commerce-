//
//  HomeController.swift
//  E-Commerce
//
//  Created by Fatih on 10.02.2024.
//

import UIKit

class HomeController: UIViewController {
    
    let categoryItemsService: CategoryItemsServiceProtocol = CategoryItemsService()
    var homePageCollectionViewProducts: [Product] = []
    
    private let homePageCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 20
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.contentInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        return collectionView
    }()
    
    private let homeButton = CustomButtons(title: "Home",
                                           titleColor: .black,
                                           font:.systemFont(ofSize: 17, weight: .medium),
                                           backroundColor: .clear)
    
    private let categoryButton = CustomButtons(title: "Category",
                                               titleColor: .black,
                                               font: .systemFont(ofSize: 17, weight: .medium),
                                               backroundColor: .clear)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeTargetButton()
        categoryTargetButton()
        configureWithExtention()
        setupDelegate()
        setupRegisterCell()
        setupNavItems()
        setupCustomButtonsVisibility()
        fetchAllCategories()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        if sender == homeButton {
            homeButton.showBorder(show: true)
            categoryButton.showBorder(show: false)
        } else if sender == categoryButton {
            homeButton.showBorder(show: false)
            categoryButton.showBorder(show: true)
        }
    }
    
    func fetchAllCategories() {
        categoryItemsService.getAllCategoryProducts { products, error in
            if error != nil {
                fatalError()
            }
            
            self.homePageCollectionViewProducts = products
            DispatchQueue.main.async { [weak self] in
                self?.homePageCollectionView.reloadData()
            }
        }
    }
    
    func homeTargetButton() {
        homeButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
    }
    
    func categoryTargetButton() {
        categoryButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    func setupCustomButtonsVisibility() {
        homeButton.showBorder(show: true)
        categoryButton.showBorder(show: false)
    }
    
    func configureWithExtention() {
        
        view.addSubview(homeButton)
        view.addSubview(categoryButton)
        view.addSubview(homePageCollectionView)
        view.backgroundColor = .white
        
        
        categoryButton.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                              left: view.safeAreaLayoutGuide.centerXAnchor,
                              right: view.safeAreaLayoutGuide.rightAnchor,
                              paddingTop: 20,
                              paddingRight:50,
                              height: 50)
        
        homeButton.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                          left: view.safeAreaLayoutGuide.leftAnchor,
                          right: view.safeAreaLayoutGuide.centerXAnchor,
                          paddingTop: 20,
                          paddingLeft: 50,
                          height: 50)
        
        homePageCollectionView.anchor(top: categoryButton.bottomAnchor,
                                      left: view.leftAnchor,
                                      bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                      right: view.rightAnchor)
        
        
        
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
        
        //Profile LeftNavBar
        let homeNavProfileView = HomeNavProfileView()
        let profileBarButton = UIBarButtonItem(customView: homeNavProfileView)
        navigationItem.leftBarButtonItems = [profileBarButton]
        
        // Favorite and Search RightNavBarButtons
        let rightFavoriteButton = UIBarButtonItem()
        let rightBarFavorite = UIImage(named: "favorite")
        rightFavoriteButton.image = rightBarFavorite
        rightFavoriteButton.tintColor = .darkGray
        
        let rightSearchButton = UIBarButtonItem()
        let rightBarSearch = UIImage(named: "search")
        rightSearchButton.image = rightBarSearch
        rightSearchButton.tintColor  = .darkGray
        
        let barButtons = [rightFavoriteButton, rightSearchButton]
        navigationItem.rightBarButtonItems = barButtons
        
    }
}

//MARK: - Configure CollectionView

extension HomeController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homePageCollectionViewProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = homePageCollectionView.dequeueReusableCell(withReuseIdentifier: HomePageCustomCell.identifier, for: indexPath) as! HomePageCustomCell
        let product = homePageCollectionViewProducts[indexPath.item]
        cell.configure(data: product)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth: CGFloat = (collectionView.frame.width - (20 + 20 + 20)) / 2
        let cellHight: CGFloat = 250
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
        return CGSize(width: view.frame.size.width, height: view.frame.size.height / 4)
    }
    
    
    
    
    
}
