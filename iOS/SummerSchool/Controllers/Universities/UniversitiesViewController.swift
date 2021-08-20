//
//  UniversitiesViewController.swift
//  SummerSchool
//
//  Created by Dan, Radu-Ionut on 19.07.2021.
//

import UIKit

class UniversitiesViewController: UITableViewController {
    
    // MARK: - Private constants
    private let allUniversities: [University] = Bundle.main.decode("universities.json")
    
    private var visibleUniversities: [University] = []
    
    private var isShowingFavorites: Bool = false
    private let favoritesHelper = FavoritesHelper()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // setup
        configureNavigationBar()
        prepareTable()
        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Private functions

    private func configureNavigationBar() {
        navigationItem.title = isShowingFavorites == true ? "Your favourites" : "Summer School"
        
        if navigationItem.rightBarButtonItem == nil {
            let barButton = UIBarButtonItem(image: UIImage(named: "filledHeart"), style: .plain, target: self, action: #selector(toggleFavoritesUniversities))
            navigationItem.rightBarButtonItem = barButton
        }
       
        navigationItem.rightBarButtonItem?.tintColor = isShowingFavorites ? .red : .lightGray
    }
    
    private func prepareTable() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "UniversityTableViewCell", bundle: nil),
                forCellReuseIdentifier: "UniversityTableViewCell")
    }
    
    private func getData() {
        allUniversities.forEach {
            print($0)
            assert($0.loadedImage != nil)
        }
        visibleUniversities = allUniversities
    }
    
    @objc private func toggleFavoritesUniversities() {
        isShowingFavorites.toggle()
        
        if isShowingFavorites {
        visibleUniversities = allUniversities.filter({ favoritesHelper.getSavedUniversityIds().contains($0.id.uuidString) })
        } else {
            visibleUniversities = allUniversities
        }
        
        configureNavigationBar()
        tableView.reloadData()
    }
    
    private func goToUniversity(at index: Int) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "UniversityDetailsViewController") as? UniversityDetailsViewController else { return }
        vc.university = getUniversity(at: index)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func getUniversity(at index: Int) -> University? {
        guard index < visibleUniversities.count,
              index >= 0 else { return nil }
        return visibleUniversities[index]
    }
}

extension UniversitiesViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: UniversityTableViewCell = tableView.dequeueReusableCell(withIdentifier: "UniversityTableViewCell", for: indexPath as IndexPath) as? UniversityTableViewCell,
              let university = getUniversity(at: indexPath.row) else {
            return UITableViewCell()
        }
        
        cell.setup(university: university,
                   isFavorite: favoritesHelper.isFavorite(universityId: university.id))
        
        cell.onFavoritesPressed = { [weak self] universityId in
            self?.favoritesHelper.changeFavoriteState(forUniversity: universityId)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return visibleUniversities.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goToUniversity(at: indexPath.row)
    }
}

extension University {
    var loadedImage: UIImage? {
        UIImage(named: image)
    }
}

public struct FavoritesHelper {
    private let userDefaults = UserDefaults.standard
    
    public func getSavedUniversityIds() -> [String] {
        let savedUniversities = userDefaults.stringArray(forKey: University.storeKey) ?? [String]()
        
        return savedUniversities
    }
    
    public func isFavorite(universityId: UUID) -> Bool {
        return getSavedUniversityIds().contains(universityId.uuidString)
    }
    
    public func changeFavoriteState(forUniversity uniId: UUID) {
        var favorites = getSavedUniversityIds()

        if isFavorite(universityId: uniId) {
            favorites.removeAll(where: { $0 == uniId.uuidString })
        } else {
            favorites.append(uniId.uuidString)
        }
        
        userDefaults.setValue(favorites, forKey: University.storeKey)
    }
}
