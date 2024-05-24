//
//  HomeViewController.swift
//  GoGame
//
//  Created by FFK on 19.05.2024.
//

import UIKit

final class HomeViewController: UIViewController {
    
    @IBOutlet private weak var customNavigationBar: CustomNavigationBar!
    @IBOutlet private weak var headerView: HeaderView!
    @IBOutlet private weak var pageView: PageView!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private var customSearchBar: SearchBar!
    @IBOutlet private weak var newHeaderView: HeaderView!
    @IBOutlet private weak var customTabBar: CustomTabBar!
    
    private var games: [Game] = []
    private var filteredGame: [Game] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customNavigationBar.delegate = self
        customSearchBar.searchTextField.delegate = self
        
        pageView.pageImage.layer.cornerRadius = 24
        
        headerView.headerLabel.text = "Game News"
        headerView.viewLabel.text = "View all"
        
        
        collectionView.register(UINib(nibName: GamesCell.identifier, bundle: nil), forCellWithReuseIdentifier: GamesCell.identifier)
        
        fetchGames()
    }
    
    private func fetchGames() {
        GameNetworking.shared.fetchGames { [weak self] result in
            switch result {
            case .success(let gameResponse):
                self?.games = gameResponse.results
                self?.filteredGame = gameResponse.results
                DispatchQueue.main.async {
                    self?.updatePageView()
                    self?.collectionView.reloadData()
                }
            case .failure(let error):
                print(error.errorMessage)
            }
        }
    }
    
    private func updatePageView() {
        let imageURL = games.map { $0.backgroundImage }
        pageView.updateImage(with: imageURL)
    }
    
    private func filterGames(with searchText: String) {
        if searchText.count > 3 {
            filteredGame = games.filter({ $0.name.lowercased().contains(searchText.lowercased())})
        } else {
            filteredGame = games
        }
        collectionView.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailVC"  {
            if let detailVC = segue.destination as? DetailViewController,
               let indexPath = collectionView.indexPathsForSelectedItems?.first {
                let selectedGame = games[indexPath.row]
                detailVC.selectedID = selectedGame.id
            }
        }
    }
}

//MARK: - Collection View DataSource & Delegate

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        filteredGame.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GamesCell.identifier, for: indexPath) as? GamesCell else {
            fatalError("Unkown: GamesCell")
        }
        
//        let game = games[indexPath.item]
//        cell.configure(with: game)
        
        let game = filteredGame[indexPath.item]
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
    
    func searchButtonTapped() {
        customNavigationBar.bellButton.isHidden = true
        customNavigationBar.lineButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        customNavigationBar.searchButton.isHidden = true
        
        pageView.isHidden = true
        headerView.isHidden = true
        
        customSearchBar.isHidden = false
        
    }
    
}

//MARK: - TextFieldDelegate

extension HomeViewController:  UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText  = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        filterGames(with: updatedText)
        
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.placeholder = ""
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text?.isEmpty ?? true {
            textField.placeholder = "Search"
        }
    }
}


