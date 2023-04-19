//
//  UserProfileViewController.swift
//  iOS FinalCodeChallange
//
//  Created by mac on 2023-04-18.
//

import UIKit

final class UserProfileTableViewController: UITableViewController, Storyboarded {
    
    //MARK: - Properties
    
    weak var coordinator: MainCoordinator?
    private var profileService: ProfileService = ProfileServiceImpl()
    
    //MARK: - Outlet
    
    @IBOutlet private weak var userNameTextField: UITextField!
    @IBOutlet private weak var firstNameTextField: UITextField!
    @IBOutlet private weak var lastNameTextField: UITextField!
    @IBOutlet private weak var saveChangesButton: UIButton!
    @IBOutlet private weak var changePasswordButton: UIButton!
    
    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationControllerUI()
        fetchProfile()
    }
    
    //MARK: - IBAction
    
    @IBAction private func saveChangesButtonTapped(_ sender: UIButton) {
        let userName = userNameTextField.text ?? ""
        let firstName = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        
        if userName.isEmpty || firstName.isEmpty || lastName.isEmpty {
            return
        }
        saveChangesButton.isEnabled = false
        let user = User(firstName: firstName, userName: userName, lastName: lastName)
        updateProfile(for: user)
    }
    
    @IBAction private func changePasswordButtonTapped(_ sender: Any) {
        coordinator?.goToChangePassword()
    }
    
    //MARK: - Methods
    
    private func setupNavigationControllerUI() {
        title = "User Profile"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func updateUI(user: User) {
        userNameTextField.text = user.userName
        firstNameTextField.text = user.firstName
        lastNameTextField.text = user.lastName
    }
    
    private func fetchProfile() {
        profileService.fetchMineProfile { [weak self] result in
            switch result {
            case .success(let profile):
                DispatchQueue.main.async {
                    self?.updateUI(user: profile.data)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func updateProfile(for user: User) {
        profileService.updateProfile(user: user) { [weak self] result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    print(response)
                    self?.saveChangesButton.isEnabled = true
                }
            case .failure(let error):
                print(error)
                DispatchQueue.main.async {
                    self?.saveChangesButton.isEnabled = true
                }
            }
        }
    }
}
