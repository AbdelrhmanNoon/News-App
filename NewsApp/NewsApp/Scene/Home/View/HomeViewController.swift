//
//  HomeViewController.swift
//  NewsApp
//
//  Created by ABDO on 30/10/2022.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet private weak var headlinesTableView: UITableView!
    @IBOutlet private weak var search: UISearchBar!
    
    // MARK: - Properties
    private let bag = DisposeBag()
    private let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Headlines"
        setupViews()
        registerCell()
        binding()
    }
    
    private func setupViews() {
        headlinesTableView.rx.setDataSource(self).disposed(by: bag)
        headlinesTableView.rx.setDelegate(self).disposed(by: bag)
        setupSearchBar()
    }
    
    private func registerCell() {
        headlinesTableView.register(
            UINib(nibName: "HeadLineTableViewCell", bundle: nil),
            forCellReuseIdentifier: "headlineCell")
    }
    
    func setupSearchBar() {
        search.delegate = self
        search.placeholder = "Search for news"
        search.returnKeyType = UIReturnKeyType.done
    }
   
    
    private func binding() {
        self.showLoader()
        viewModel.getArticles()
        viewModel.articles.subscribe(onNext: { [weak self] expandableModels in
            self?.headlinesTableView.reloadData()
        }).disposed(by: bag)
        
        viewModel.showEmptyState.subscribe(onNext: { [weak self] showEmptyState in
            guard let self = self else { return }
            if showEmptyState {
                self.showWarningAlert()
                self.headlinesTableView.isHidden = true
            } else {
                self.headlinesTableView.isHidden = false
                self.headlinesTableView.backgroundView = nil
            }
        }).disposed(by: bag)
        
        viewModel.hideLoader = { [weak self] in
            guard let self = self else { return }
            self.hideLoader()
        }
    }
    
    private func showWarningAlert() {
        let dialogMessage = UIAlertController(title: "Sorry",
                                              message: "No Articles Available",
                                              preferredStyle: .alert)

        let okAction = UIAlertAction(title: "Ok",
                                     style: .default,
                                     handler: { [weak self] _  in
                                        guard let self = self else { return }
                                        // you can do somthing here
        })

        dialogMessage.addAction(okAction)
        self.present(dialogMessage, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.articles.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "headlineCell", for: indexPath) as! HeadLineTableViewCell
        cell.configureWith(article: viewModel.articles.value[indexPath.row])
        return cell
    }
    
}

// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /// We can use coordinator pattern here to improve those lines
        let vc = DetailsViewController()
        let article = viewModel.articles.value[indexPath.row]
        vc.articles.accept([article])
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - Searchbar
extension HomeViewController: UISearchBarDelegate {
    func hideKeyboard() {
        // To hide the keyboard
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        // This to make sure other things are still clickable after hiding keyboard
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.getSearchResultsFor(text: searchText)
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        if searchBar.text != "" {
            return true
        } else {
            searchBar.placeholder = "Search for news"
            return false
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        search.resignFirstResponder() // To dismiss keyboard return tapped
    }
    
}
