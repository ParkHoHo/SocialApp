//
//  RegisterViewController.swift
//  SocialApp
//
//  Created by 박경호 on 2023/09/05.
//

import UIKit

class RegisterViewController : UIViewController {
    //MARK: - Properties
    private var viewModel = RegisterViewModel()
    private var profileImage : UIImage?
    
    private let addProfilePhotoButton : UIButton = {
        let bt = UIButton(type: .system)
        bt.setImage(UIImage(named: "add2"), for: .normal)
        bt.tintColor = .white
        bt.addTarget(self, action: #selector(handleProfileButton), for: .touchUpInside)
        return bt
    }()
    
    private let emailTextField : CustomTextField = {
        let et = CustomTextField(placeHolder: "사용할 이메일을 입력해 주세요.")
        et.keyboardType = .emailAddress
        et.layer.cornerRadius = 10
        return et
    }()
    
    private let passwordTextField : CustomTextField = {
        let pt = CustomTextField(placeHolder: "비밀번호를 등록해 주세요.")
        pt.isSecureTextEntry = true
        pt.layer.cornerRadius = 10
        return pt
    }()
    
    private let fullNameTextField = CustomTextField(placeHolder: "Fullname")
    private let userNameTextField = CustomTextField(placeHolder: "Username")
    
    private let signUpButton : UIButton = {
        let bt = UIButton(type: .system)
        bt.setTitle("회원가입", for: .normal)
        bt.setTitleColor(.white, for: .normal)
        bt.backgroundColor = #colorLiteral(red: 0.6449307203, green: 0.1136205271, blue: 1, alpha: 1).withAlphaComponent(0.5)
        bt.layer.cornerRadius = 10
        bt.setHeight(50)
        bt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        bt.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        bt.isEnabled = false
        return bt
    }()
    
    private let alreadyAccountButton : UIButton = {
        let bt = UIButton(type: .system)
        bt.attributedTitle(firstPart: "계정이 있나요?", secondPart: "Log in")
        bt.addTarget(self, action: #selector(alreadyAccount), for: .touchUpInside)
        return bt
    }()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureObservers()
    }
    
    //MARK: - Helpers
    func configureUI() {
        
        configureGradientLayer()
        
        
        view.backgroundColor = .magenta
        view.addSubview(addProfilePhotoButton)
        addProfilePhotoButton.centerX(inview: view)
        addProfilePhotoButton.setDimension(height: 130, width: 130)
        addProfilePhotoButton.anchor(top: view.safeAreaLayoutGuide.topAnchor,paddingTop: 30)
        
        let stackView = UIStackView(arrangedSubviews: [emailTextField,passwordTextField,fullNameTextField,userNameTextField,signUpButton])
        stackView.axis = .vertical
        stackView.spacing = 20
        
        view.addSubview(stackView)
        stackView.anchor(top: addProfilePhotoButton.bottomAnchor,left: view.leftAnchor,right: view.rightAnchor,paddingTop: 30,paddingLeft: 30,paddingRight: 30)
        
        view.addSubview(alreadyAccountButton)
        alreadyAccountButton.centerX(inview: view)
        alreadyAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
        
    }
    
    func configureObservers() {
        emailTextField.addTarget(self, action: #selector(textChanged), for:.editingChanged )
        passwordTextField.addTarget(self, action: #selector(textChanged), for:.editingChanged )
        fullNameTextField.addTarget(self, action: #selector(textChanged), for:.editingChanged )
        userNameTextField.addTarget(self, action: #selector(textChanged), for:.editingChanged )
    }
    
    
    //MARK: - Actions
    @objc func handleProfileButton() {
        let selectPhoto = UIImagePickerController()
        selectPhoto.delegate = self
        selectPhoto.allowsEditing = true
        
        present(selectPhoto, animated: true,completion: nil)
        
    }
    
    @objc func handleSignUp() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let fullname = fullNameTextField.text else { return }
        guard let username = userNameTextField.text else { return }
        guard let profileImage = self.profileImage else { return }
        
        let crediential = AuthCredentials(email: email, password: password, fullname: fullname, username: username, profileImage: profileImage)
        
        AuthService.registerUser(withCredential: crediential) { error in
            // Firebase를 사용하여 회원가입 시에 에러가 있을 경우
            if let error = error {
                print("DEBUG: Failed to register user \(error.localizedDescription)")
            }
            self.dismiss(animated: true,completion: nil)
            print("DEBUG: User information register successfully!")
        }
    }
    
    @objc func alreadyAccount() {
        let controller = LoginViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func textChanged(sender:UITextField) {
        if sender == emailTextField {
            viewModel.email = sender.text
        }
        else if sender == passwordTextField {
            viewModel.password = sender.text
        }
        else if sender == fullNameTextField {
            viewModel.fullname = sender.text
        }
        else {
            viewModel.username = sender.text
        }
        
        updateForm()
    }
}

extension RegisterViewController : FormViewModel {
    func updateForm() {
        signUpButton.backgroundColor = viewModel.buttonBackgroundColor
        signUpButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
        signUpButton.isEnabled = viewModel.formIsValid
    }
    
    
    
}

//MARK: - UIImagePickerControllerDelegate
extension RegisterViewController : UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.editedImage] as? UIImage else { return }
        profileImage = selectedImage
        
        addProfilePhotoButton.contentMode = .scaleAspectFill
        addProfilePhotoButton.clipsToBounds = true
        addProfilePhotoButton.layer.cornerRadius = addProfilePhotoButton.frame.width / 2
        addProfilePhotoButton.layer.masksToBounds = true
        addProfilePhotoButton.layer.borderColor = UIColor.yellow.cgColor
        addProfilePhotoButton.layer.borderWidth = 2
        addProfilePhotoButton.setImage(selectedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        
        self.dismiss(animated: true,completion: nil)
        
    }
}
