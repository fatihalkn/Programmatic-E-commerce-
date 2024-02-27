//
//  OnboardingController.swift
//  E-Commerce
//
//  Created by Fatih on 24.02.2024.
//

import Foundation
import UIKit

class OnboardingController: UIViewController, OnboardingCellDelegate {
    
    
    private var currentPage = 0 {
        didSet {
            updateContinueButtonTitle()
        }
    }
    
    struct images {
        let imageName: String
        let title: String
        let descTitle: String
    }
    
    let data: [images] = [.init(imageName: "o1", title: "Explore Best Products", descTitle: "Browse products and find your desire product."),
                          .init(imageName: "o2", title: "All products are just a click away", descTitle: "Do you want to earn gift points when you spend free delivery all over the world?"),
                          .init(imageName: "o3", title: "Confirm Your Purchase", descTitle: "Make the final purchase and get the quick delivery")]
    
    private let onboardingCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private let pageController: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.pageIndicatorTintColor = .bg
        pageControl.currentPageIndicatorTintColor = .main
        pageControl.isUserInteractionEnabled = false
        return pageControl
    }()
    
    let contiuneButton = CustomButtons(title: "Contiune",
                                    titleColor: .white,
                                    font: .systemFont(ofSize: 17),
                                    backroundColor: .main)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(contiuneButton)
        view.addSubview(pageController)
        view.addSubview(onboardingCollectionView)
        continueButtonConstraints()
        pageControlConstraints()
        onboardingCollectionViewConstrain()
        setupRegister()
        setupDelegate()
        pageController.numberOfPages = data.count
        addTargets()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupRadius()
    }
    
    
    @objc func continueButtonTapped() {
        if currentPage < data.count - 1 {
            currentPage += 1
            let indexPathToScroll = IndexPath(item: currentPage, section: 0)
            onboardingCollectionView.scrollToItem(at: indexPathToScroll, at: .centeredHorizontally, animated: true)
            pageController.currentPage = currentPage
            if currentPage == data.count - 1 {
                contiuneButton.setTitle("Get Started", for: .normal)
            }
        } else {
            handleOnboardingCompletion()
        }

    }
    
    private func updateContinueButtonTitle() {
        if currentPage == data.count - 1 {
            contiuneButton.setTitle("Get Started", for: .normal)
        } else {
            contiuneButton.setTitle("Continue", for: .normal)
        }
    }
    
    private func handleOnboardingCompletion() {
        let vc = RegisterController()
        navigationController?.pushViewController(vc, animated: true)
        }
    
    func setupRadius() {
        contiuneButton.layer.cornerRadius = contiuneButton.frame.size.height / 2
        contiuneButton.layer.masksToBounds = true
    }
   
    
    func setupRegister() {
        onboardingCollectionView.register(OnboardingCell.self, forCellWithReuseIdentifier: OnboardingCell.identifier)
    }
    
    func setupDelegate() {
        onboardingCollectionView.delegate = self
        onboardingCollectionView.dataSource = self
    }
    
    func addTargets() {
        contiuneButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
    }

}


//MARK: - PageController Configure
extension OnboardingController {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
        pageController.currentPage = currentPage
    }
}

//MARK: - CollectionView Configure
extension OnboardingController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = onboardingCollectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCell.identifier, for: indexPath) as! OnboardingCell
        let imagesOnboard = data[indexPath.item]
        cell.imageView.image = UIImage(named: imagesOnboard.imageName)
        cell.label.text = imagesOnboard.title
        cell.descLabel.text = imagesOnboard.descTitle
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWith: CGFloat = onboardingCollectionView.frame.size.width
        let cellHeigt: CGFloat = onboardingCollectionView.frame.size.height
        return .init(width: cellWith, height: cellHeigt)
    }
    
    
}

extension OnboardingController {
    func continueButtonConstraints() {
        NSLayoutConstraint.activate([
            contiuneButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            contiuneButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            contiuneButton.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -40),
            contiuneButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func pageControlConstraints() {
        NSLayoutConstraint.activate([
            pageController.bottomAnchor.constraint(equalTo: contiuneButton.topAnchor, constant: -20),
            pageController.centerXAnchor.constraint(equalTo: contiuneButton.centerXAnchor),
            pageController.widthAnchor.constraint(equalTo: contiuneButton.widthAnchor),
            pageController.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    func  onboardingCollectionViewConstrain() {
        NSLayoutConstraint.activate([
            onboardingCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            onboardingCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            onboardingCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            onboardingCollectionView.bottomAnchor.constraint(equalTo: pageController.topAnchor, constant: -10)
        ])
    }
    
}
