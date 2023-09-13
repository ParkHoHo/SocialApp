//
//  LoginViewController.swift
//  SocialApp
//
//  Created by 박경호 on 2023/09/05.
//

import UIKit

class LoginViewController: UIViewController {
    //MARK: - Properties
    private var viewModel = LoginViewModel()
    
    
    private let mainIcon : UIImageView = {
        let mi = UIImageView(image: #imageLiteral(resourceName: "Instagram_PNG-Logo-Oksdf"))
        mi.contentMode = .scaleAspectFill
        mi.tintColor = .white
        return mi
    }()
    
    private let emailTextField : CustomTextField = {
        let et = CustomTextField(placeHolder: "Email")
        et.keyboardType = .emailAddress
        et.layer.cornerRadius = 10
        return et
    }()
    
    private let passwordTextField : CustomTextField = {
        let et = CustomTextField(placeHolder: "Password")
        et.isSecureTextEntry = true
        et.layer.cornerRadius = 10
        return et
    }()
    
    private let loginButton: UIButton = {
        let bt = UIButton(type: .system)
        bt.setTitle("Log In", for: .normal)
        bt.setTitleColor(.white, for: .normal)
        bt.backgroundColor = #colorLiteral(red: 0.9314289689, green: 0, blue: 0.8005321026, alpha: 1)
        bt.titleLabel?.font = UIFont.systemFont(ofSize: 17,weight: .bold)
        bt.setHeight(50)
        bt.layer.cornerRadius = 10
        bt.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return bt
    }()
    
    private let forgetPasswordButton : UIButton = {
        let bt = UIButton(type: .system)
        bt.attributedTitle(firstPart: "비밀번호를 잊으셨나요?", secondPart: "비밀번호 재발급")
        bt.setTitleColor(UIColor(white: 1, alpha: 0.8), for: .normal)
        bt.addTarget(self, action: #selector(handleResetPassword), for: .touchUpInside)
        
        return bt
    }()
    
    private let newAccount : UIButton = {
        let bt = UIButton(type: .system)
        bt.attributedTitle(firstPart: "계정이 없으신가요?", secondPart: "회원가입")
        bt.setTitleColor(UIColor(white: 1, alpha: 0.8), for: .normal)
        bt.addTarget(self, action: #selector(handleNewAccount), for: .touchUpInside)
        return bt
    }()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        configureUI()
        configureObservers()
    }
    
    //MARK: - Helpers
    func configureUI() {
        
        
        navigationController?.navigationBar.barStyle = .black
        
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.systemBlue.cgColor,UIColor.systemPink.cgColor]
        gradient.locations = [0,1]
        view.layer.addSublayer(gradient)
        gradient.frame = view.frame
        
        view.addSubview(mainIcon)
        mainIcon.centerX(inview: view)
        mainIcon.setDimension(height: 60, width: 80)
        mainIcon.anchor(top: view.safeAreaLayoutGuide.topAnchor,paddingTop: 30)
        
        let stackview = UIStackView(arrangedSubviews: [emailTextField,passwordTextField,loginButton,forgetPasswordButton])
        stackview.axis = .vertical
        stackview.spacing = 20
        view.addSubview(stackview)
        stackview.anchor(top: mainIcon.bottomAnchor,left: view.leftAnchor,right: view.rightAnchor,paddingTop: 30,paddingLeft: 30,paddingRight: 30)
        
        view.addSubview(newAccount)
        newAccount.centerX(inview: view)
        newAccount.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor,paddingBottom: 30)

    }
    
    func configureObservers() {
        emailTextField.addTarget(self, action: #selector(textChanged), for:.editingChanged )
        passwordTextField.addTarget(self, action: #selector(textChanged), for:.editingChanged )
    }
    
    //MARK: - action
    
    @objc func handleLogin() {
        print("DEBUG:Login Button is Tapped.")
        
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        
        AuthService.logUserIn(withEmail: email, password: password) { result,error in
            if let error = error {
                print("DEBUG:SignIn is failed \(error.localizedDescription)")
            }
            
            self.dismiss(animated: true,completion: nil)
        }
    }
    
    @objc func handleResetPassword() {
        print("DEBUG: - Tapped Forget Button")
    }
    
    @objc func handleNewAccount() {
        let controller = RegisterViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func textChanged(sender: UITextField) {
        if sender == emailTextField {
            viewModel.email = sender.text
        }
        else if sender == passwordTextField {
            viewModel.password = sender.text
        }
        updateForm()
    }
}

extension LoginViewController
: FormViewModel {
    func updateForm() {
        loginButton.backgroundColor = viewModel.buttonBackgroundColor
        loginButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
        loginButton.isEnabled = viewModel.formIsValid
    }
}

