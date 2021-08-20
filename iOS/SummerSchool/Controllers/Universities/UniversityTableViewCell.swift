//
//  UniversityTableViewCell.swift
//  SummerSchool
//
//  Created by Bujor, Raluca on 02.08.2021.
//

import UIKit

class UniversityTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet private weak var universityImageView: UIImageView!
    @IBOutlet private weak var universityName: UILabel!
    @IBOutlet private weak var universityYear: UILabel!
    @IBOutlet private weak var universityCity: UILabel!
    @IBOutlet private weak var favouriteButton: UIButton!
    
    // MARK: - Private variables
    private var universityId: UUID = UUID()
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    // MARK: - Public functions
    func setup(university: University, isFavorite: Bool) {
        universityImageView.image = university.loadedImage
        universityName.text = university.name
        universityYear.text = "Year: \(String(university.year))"
        universityCity.text = "City: \(university.city)"
            
        favouriteButton.isSelected = isFavorite
        universityId = university.id
    }
    
    public var onFavoritesPressed: (_ universityId: UUID) -> Void = {_ in }

    
    // MARK: - Private functions
    
    @IBAction private func onFavouriteButtonPressed() {
        favouriteButton.isSelected = !favouriteButton.isSelected
        onFavoritesPressed(universityId)
    }
}
