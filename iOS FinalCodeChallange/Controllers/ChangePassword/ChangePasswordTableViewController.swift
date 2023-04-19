//
//  ChangePasswordTableViewController.swift
//  iOS FinalCodeChallange
//
//  Created by mac on 2023-04-18.
//

import UIKit

final class ChangePasswordTableViewController: UITableViewController, Storyboarded {
    
    //MARK: - Properties

    weak var coordinator: MainCoordinator?
    private var profileService: ProfileService = ProfileServiceImpl()
    
    //MARK: - Outlet
    
    @IBOutlet private weak var newPasswordTextField: UITextField!
    @IBOutlet private weak var reEnterPasswordTextField: UITextField!
    @IBOutlet private weak var changePasswordButton: UIButton!
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationControllerUI()
    }
    
    //MARK: - IBAction
    
    @IBAction private func changePasswordButtonTapped(_ sender: UIButton) {
        let newPassword = newPasswordTextField.text ?? ""
        let reEnterPassword = reEnterPasswordTextField.text ?? ""
        
        if newPassword.isEmpty == false && newPassword == reEnterPassword {
            changePasswordButton.isEnabled = false
            updatePassword(with: newPassword)
        } else {
            changePasswordButton.isEnabled = true
            return
        }
    }
    
    //MARK: - Methods
    
    private func setupNavigationControllerUI() {
        title = "ChangePassword"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func updatePassword(with password: String) {
        profileService.updatePassword(password: password) { [weak self] result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    print(response)
                    self?.changePasswordButton.isEnabled = true
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    print(error)
                    self?.changePasswordButton.isEnabled = true
                }
            }
        }
    }
}
