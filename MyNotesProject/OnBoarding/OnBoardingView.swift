//
//  OnBoardingView.swift
//  MyNotesProject
//
//  Created by Nurtilek on 3/8/24.
//

import UIKit

var currentPage = 0

class OnBoardingView: UIViewController  {
    
    var StructBoarding: [StructBoardings] = []
    
    private lazy var onBoardingCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(OnBoardCell.self, forCellWithReuseIdentifier: OnBoardCell.reuseID)
        view.dataSource = self
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
    private lazy var uiPageControl: UIPageControl = {
        let view = UIPageControl()
        view.currentPage = 0
        view.numberOfPages = 3
        view.currentPageIndicatorTintColor = .black
        view.pageIndicatorTintColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var skipButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("skip", for: .normal)
        view.setTitleColor(.red, for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(skipbuttonTapped), for: .touchUpInside)
        return view
    }()
    
    private lazy var nextButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Next", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.backgroundColor = UIColor().rgb(r: 255, g: 61, b: 61, alpha: 1)
        view.layer.cornerRadius = 22
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstrains()
        setupButtons()
        setupParamets()
        onBoardingCollectionView.reloadData()
        DispatchQueue.main.async {
            self.scrollToCurrentPage(animated: false)
        }
    }
    
    func test() {
        guard StructBoarding.count > currentPage + 0 else { return }
        
        onBoardingCollectionView.isPagingEnabled = false
        onBoardingCollectionView.scrollToItem(at: IndexPath(item: currentPage + 0, section: 0), at: .centeredHorizontally, animated: true)
        onBoardingCollectionView.isPagingEnabled = true
    }
    
    private func setupConstrains() {
        view.addSubview(onBoardingCollectionView)
        view.addSubview(uiPageControl)
        NSLayoutConstraint.activate([
            onBoardingCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            onBoardingCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            onBoardingCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            onBoardingCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            uiPageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -300),
            uiPageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setupParamets() {
        StructBoarding = [
            StructBoardings(image: "Image1",
                            label: "Welcome to The Note",
                            secondLabel: "Welcome to The Note – your new companion for tasks, goals, health – all in one place. Let's get started!."),
            StructBoardings(image: "image2",
                            label: "Set Up Your Profile",
                            secondLabel: "Now that you're with us, let's get to know each other better. Fill out your profile, share your interests, and set your goals."),
            StructBoardings(image: "image3",
                            label: "Dive into The Note",
                            secondLabel: "You're fully equipped to dive into the world of The Note. Remember, we're here to assist you every step of the way. Ready to start? Let's go!")
        ]
        onBoardingCollectionView.reloadData()
    }
    
    
    private func setupButtons() {
        view.addSubview(skipButton)
        view.addSubview(nextButton)
        NSLayoutConstraint.activate([
            skipButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -133),
            skipButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            skipButton.heightAnchor.constraint(equalToConstant: 42),
            skipButton.widthAnchor.constraint(equalToConstant: 173),
            
            nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -133),
            nextButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            nextButton.heightAnchor.constraint(equalToConstant: 42),
            nextButton.widthAnchor.constraint(equalToConstant: 173)
        ])
    }
    
    @objc private func nextButtonTapped() {
        UserDefaults.standard.set(true, forKey: "One_Board_cell")
        if currentPage < StructBoarding.count - 1 {
            currentPage += 1
            scrollToCurrentPage(animated: true)
        } else {
            transitionToHomeView()
        }
    }
    
    private func scrollToCurrentPage(animated: Bool) {
        let indexPath = IndexPath(item: currentPage, section: 0)
        onBoardingCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: animated)
        uiPageControl.currentPage = currentPage
    }
    
    private func transitionToHomeView() {
        let vc = HomeView()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func skipbuttonTapped() {
        let vc = HomeView()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension OnBoardingView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return StructBoarding.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnBoardCell.reuseID, for: indexPath) as! OnBoardCell
        cell.configure(with: StructBoarding[indexPath.row])
        return cell
    }
    
    
}

extension OnBoardingView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffSet = scrollView.contentOffset.x
        
        let page = (contentOffSet / view.frame.width)
        
        switch page {
        case 0.0:
            uiPageControl.currentPage = 0
            currentPage = 0
        case 1.0:
            uiPageControl.currentPage = 1
            currentPage = 1
        case 2.0:
            uiPageControl.currentPage = 2
            currentPage = 2
        default:
            ()
        }
    }
}

