//
//  HomeViewController.swift
//  GoGame
//
//  Created by FFK on 19.05.2024.
//

import UIKit

final class HomeViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var customNavigationBar: CustomNavigationBar!
    @IBOutlet private weak var headerView: HeaderView!
    @IBOutlet private weak var pageView: PageView!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private var customSearchBar: SearchBar!
    @IBOutlet private weak var newHeaderView: HeaderView!
    
    // MARK: - Properties
    
    private var homeViewModel: HomeViewModel!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        setupUI()
    }
    
    // MARK: - Setup
    
    private func setupViewModel() {
        homeViewModel = HomeViewModel()
        homeViewModel.fetchGames { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(_):
                DispatchQueue.main.async {
                    self.updatePageView()
                    self.collectionView.reloadData()
                }
            case .failure(_):
                print("No fetching HomeVC")
            }
        }
    }
    
    private func setupUI() {
        customNavigationBar.delegate = self
        customSearchBar.searchTextField.delegate = self
        pageView.pageImage.layer.cornerRadius = 24
        headerView.headerLabel.text = "Game News"
        headerView.viewLabel.text = "View all"
        collectionView.register(UINib(nibName: GamesCell.identifier, bundle: nil), forCellWithReuseIdentifier: GamesCell.identifier)
    }
    
    private func updatePageView() {
        let imageURL = homeViewModel.games.prefix(3).map { $0.backgroundImage }
        pageView.updateImage(with: imageURL)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailVC"  {
            if let detailVC = segue.destination as? DetailViewController,
               let indexPath = collectionView.indexPathsForSelectedItems?.first {
                let selectedGame = homeViewModel.games[indexPath.row]
                detailVC.selectedID = selectedGame.id
            }
        }
    }
}

//MARK: - Collection View DataSource & Delegate

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        homeViewModel.filteredGame.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GamesCell.identifier, for: indexPath) as? GamesCell else {
            fatalError("Unkown: GamesCell")
        }
        
        let game = homeViewModel.filteredGame[indexPath.item]
        cell.configure(with: game)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "detailVC", sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 140)
    }
    
}

//MARK: - CustomNavigationProtocol

extension HomeViewController: CustomNavigationProtocol {
    
    func secondButtonTapped() {
        customNavigationBar.thirdButton.isHidden = true
        customNavigationBar.firstButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        customNavigationBar.secondButton.isHidden = true
        
        pageView.isHidden = true
        headerView.isHidden = true
        
        customSearchBar.isHidden = false
        
    }
    
}

//MARK: - TextFieldDelegate

extension HomeViewController:  UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        homeViewModel.filterGames(with: updatedText)
        collectionView.reloadData()
        
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        textField.placeholder = "Search"
        return true
    }
    
}


