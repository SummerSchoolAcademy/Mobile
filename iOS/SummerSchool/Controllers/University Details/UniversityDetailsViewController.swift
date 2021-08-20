//
//  UniversityDetailsViewController.swift
//  SummerSchool
//
//  Created by Bujor, Raluca on 02.08.2021.
//

import UIKit

class UniversityDetailsViewController: UIViewController {

    // MARK: IBOutlets
    @IBOutlet private weak var universityImageView: UIImageView!
    @IBOutlet private weak var universityName: UILabel!
    @IBOutlet private weak var universityYear: UILabel!
    @IBOutlet private weak var universityCity: UILabel!
    @IBOutlet private weak var universityDescription: UILabel!
    @IBOutlet private weak var favouriteButton: UIButton!

    
    // MARK: - Public constants
    var university: University?
    
    // MARK: - Private variables
    private let favoritesHelper = FavoritesHelper()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    // MARK: - Private functions
    private func setup() {
        guard let university = university else { return }
        universityImageView.image = university.loadedImage
        universityName.text = university.name
        universityYear.text = "Year: \(String(university.year))"
        universityCity.text = "City: \(university.city)"
        universityDescription.text = university.description
        
        favouriteButton.isSelected = favoritesHelper.isFavorite(universityId: university.id)
    }
    
    
    @IBAction func onFavoriteButtonPressed(_ sender: Any) {
        guard let universityId = university?.id else { return }
        favouriteButton.isSelected = !favouriteButton.isSelected
        favoritesHelper.changeFavoriteState(forUniversity: universityId)
    }
}
