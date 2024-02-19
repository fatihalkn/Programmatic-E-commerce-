//
//  HomeController.swift
//  E-Commerce
//
//  Created by Fatih on 10.02.2024.
//

import UIKit

enum HomeCurrentSelectedButtonType {
    case home
    case category
}

class HomeController: UIViewController {
        
    let categoryItemsService: CategoryItemsServiceProtocol = CategoryItemsService()
    var homePageCollectionViewProducts: [Product] = []
    var homePageCategoryCollectionViewCategories: [Category] = [.electronics, .jewelery, .womenSClothing, .menSClothing]
    
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
    
    private var currentSelectedButtonType: HomeCurrentSelectedButtonType = .home {
        didSet {
            if currentSelectedButtonType != oldValue {
                homePageCollectionView.reloadData()
            }
        }
    }
    
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
            currentSelectedButtonType = .home
        } else if sender == categoryButton {
            homeButton.showBorder(show: false)
            categoryButton.showBorder(show: true)
            currentSelectedButtonType = .category
        }
    }
    
    func fetchAllCategories() {
        switch currentSelectedButtonType {
        case .home:
            categoryItemsService.getAllCategoryProducts { products, error in
                if error != nil {
                    return
                }
                self.homePageCollectionViewProducts = products
                DispatchQueue.main.async { [weak self] in
                    self?.homePageCollectionView.reloadData()
                }
            }
        case .category:
            categoryItemsService.getAllCategoryProducts { products, error in
                if error != nil {
                    print(error?.localizedDescription)
                }
                self.homePageCollectionViewProducts = products
                DispatchQueue.main.async {
                self.homePageCollectionView.reloadData()

                }
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
                forCellWithReuseIdentifier: HomePageCustomCell.identifier)
            
            homePageCollectionView.register(
                HomeMainCollectionHeader.self,
                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: HomeMainCollectionHeader.identifier)
            
      
            homePageCollectionView.register(CategoryViewCell.self, forCellWithReuseIdentifier: CategoryViewCell.identifier)

        
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
        let favoriteButton = UIButton(type: .system)
        let rightBarFavorite = UIImage(named: "favorite")
        favoriteButton.setImage(rightBarFavorite, for: .normal)
        favoriteButton.tintColor = .darkGray
        let rightFavoriteButton = UIBarButtonItem(customView: favoriteButton)
        
        let rightSerachButton1 = UIButton(type: .system)
        rightSerachButton1.setImage(UIImage(named: "search"), for: .normal)
        rightSerachButton1.tintColor  = .darkGray
        let rightSearchButton = UIBarButtonItem(customView: rightSerachButton1)
        let barButtons = [rightFavoriteButton, rightSearchButton]
        navigationItem.rightBarButtonItems = barButtons
        
       // AddTarget Navigation Rigtbar Buttos
        favoriteButton.addTarget(self, action: #selector(favoriteButtonClicked), for: .touchUpInside)
        rightSerachButton1.addTarget(self, action: #selector(searchButtonClicked), for: .touchUpInside)
        
    }
    
    @objc func searchButtonClicked() {
        seeAllButtonClicked()
    }
    
    @objc func favoriteButtonClicked() {
        tabBarController?.selectedIndex = 2
    }
}

//MARK: - Configure CollectionView

extension HomeController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch currentSelectedButtonType {
        case .home:
            if let selectedProductID = homePageCollectionViewProducts[indexPath.item].id {
                let productsDetail = ProductsDetail()
                productsDetail.productID = selectedProductID
                navigationController?.pushViewController(productsDetail, animated: true)
            } else {
                print("Error")
            }
            
        case .category:
            let selectedCategory = homePageCategoryCollectionViewCategories[indexPath.item]
            let categoryListViewController = CategoryListViewController()
            categoryListViewController.category = selectedCategory
            navigationController?.pushViewController(categoryListViewController, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch currentSelectedButtonType {
        case .home:
            return homePageCollectionViewProducts.count
        case .category:
            return homePageCategoryCollectionViewCategories.count
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch currentSelectedButtonType {
        case .home:
            let cell = homePageCollectionView.dequeueReusableCell(withReuseIdentifier: HomePageCustomCell.identifier, for: indexPath) as! HomePageCustomCell
            let product = homePageCollectionViewProducts[indexPath.item]
            cell.configure(data: product)
            cell.delegate = self
            return cell
        case .category:
            let cell = homePageCollectionView.dequeueReusableCell(withReuseIdentifier: CategoryViewCell.identifier, for: indexPath) as! CategoryViewCell
            let category = homePageCategoryCollectionViewCategories[indexPath.item]
            cell.configure(data: category)
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch currentSelectedButtonType {
        case .home:
            let cellWidth: CGFloat = (collectionView.frame.width - (20 + 20 + 20)) / 2
            let cellHight: CGFloat = 250
            return(.init(width: cellWidth, height: cellHight))
        case .category:
            let cellWidth: CGFloat = collectionView.frame.width - 50
            let cellHight: CGFloat = 150
            return(.init(width: cellWidth, height: cellHight))
        }
        
    
        
    }
    
    //MARK: - HomePageHeader
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch currentSelectedButtonType {
        case .home:
            if kind == UICollectionView.elementKindSectionHeader {
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,withReuseIdentifier: HomeMainCollectionHeader.identifier,for: indexPath) as! HomeMainCollectionHeader
                header.delegate = self
                return header
            }
            return UICollectionReusableView()
        case .category:
            return UICollectionReusableView()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch currentSelectedButtonType {
        case .home:
            return CGSize(width: view.frame.size.width, height: view.frame.size.height / 4)
        case .category:
            return CGSize()
        }
    }
}

extension HomeController : HeaderDelegate {
    func seeAllButtonClicked() {
        tabBarController?.selectedIndex = 3
    }
}

extension HomeController: FavoriteButtonDelegate {
    func clickedFavoriteButton(id: Int) {
        
    }
}

