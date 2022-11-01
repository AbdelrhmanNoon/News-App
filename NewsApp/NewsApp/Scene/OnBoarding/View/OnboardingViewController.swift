//
//  OnboardingViewController.swift
//  NewsApp
//
//  Created by ABDO on 30/10/2022.
//

import UIKit
import CountryPicker

class OnboardingViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var pickerView: CountryPicker!
    @IBOutlet private weak var categoriesTableView: UITableView!
    
    // MARK: Properties
    let categories = ["General", "Business", "Science", "Technology", "Health", "Entertainment", "Sports"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        setupPickerAppearance()
        registerCells()
        // disable tableView user interaction to insure the user select country first.
        categoriesTableView.isUserInteractionEnabled = false
    }
    
    private func registerCells() {
        categoriesTableView.register(UINib(nibName: "CategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "categoryCell")
    }
    
    private func setupPickerAppearance() {
        // we can add all Countries by removing displayOnlyCountriesWithCodes .
        // just i add those countries for testing
        
        let locale = Locale.current
        let code = (locale as NSLocale).object(forKey: NSLocale.Key.countryCode) as! String?
        pickerView.displayOnlyCountriesWithCodes = ["AE", "AR", "AT", "AU", "BE", "BG", "BR",
                                                    "CA", "CH", "EG", "CN", "US", "SA", "UA",
                                                    "GB", "DE", "HK", "ID", "JP", "MA"]
        pickerView.countryPickerDelegate = self
        pickerView.showPhoneNumbers = false
        pickerView.setCountry(code ?? "UA")
    }
}

// MARK: - Conform CountryPickerDelegate
extension OnboardingViewController: CountryPickerDelegate {
    func countryPhoneCodePicker(_ picker: CountryPicker,
                                didSelectCountryWithName name: String,
                                countryCode: String,
                                phoneCode: String,
                                flag: UIImage) {
        UserDefaultsProperties.country = countryCode.lowercased()
        categoriesTableView.isUserInteractionEnabled = true
    }
}

// MARK: - Conform UITableViewDataSource
extension OnboardingViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as? CategoryTableViewCell else {return UITableViewCell()}
        cell.configure(title: categories[indexPath.row])
        return cell
    }
}

// MARK: - Conform UITableViewDelegate
extension OnboardingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard !UserDefaultsService.shared.country.isEmpty else { return }
        UserDefaultsProperties.favoritCategory = categories[indexPath.row].lowercased()
        UserDefaultsProperties.isFirstLaunch = false
        UserDefaultsProperties.currentTime = Date()
        let vc = HomeViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
