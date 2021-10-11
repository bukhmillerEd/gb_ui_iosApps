//
//  ViewController.swift
//  UIiosApps
//
//  Created by Эдуард Бухмиллер on 05.10.2021.
//

import UIKit

class LoginFormController: UIViewController {
  
  // MARK: - IBOutlets
  @IBOutlet weak var loginTF: UITextField!
  @IBOutlet weak var passwordTF: UITextField!
  @IBOutlet weak var scrollView: UIScrollView!
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    // Жест нажатия
    let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
    // Присваиваем его UIScrollVIew
    scrollView?.addGestureRecognizer(hideKeyboardGesture)
    scrollView.delegate = self
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    // Подписываемся на два уведомления: одно приходит при появлении клавиатуры
    NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
    // Второе — когда она пропадает
    NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
  }
  
  override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
    if checkUserData() {
      return true
    } else {
      return false
    }
  }
  
  // MARK: - Private Methods
  private func checkUserData() -> Bool {
    guard let login = loginTF.text, let password = passwordTF.text else { return false }
    if login == "admin" && password == "123456" {
      return true
    } else {
      showLoginError()
      return false
    }
  }
  
  private func showLoginError() {
    // Создаем контроллер
    let alter = UIAlertController(title: "Ошибка", message: "Введены не верные данные пользователя", preferredStyle: .alert)
    // Создаем кнопку для UIAlertController
    let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
    // Добавляем кнопку на UIAlertController
    alter.addAction(action)
    // Показываем UIAlertController
    present(alter, animated: true, completion: nil)
  }
  
  // Когда клавиатура появляется
  @objc private func keyboardWasShown(notification: Notification) {
    // Получаем размер клавиатуры
    let info = notification.userInfo! as NSDictionary
    let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
    let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
    // Добавляем отступ внизу UIScrollView, равный размеру клавиатуры
    self.scrollView?.contentInset = contentInsets
    scrollView?.scrollIndicatorInsets = contentInsets
  }
  
  //Когда клавиатура исчезает
  @objc private func keyboardWillBeHidden(notification: Notification) {
    // Устанавливаем отступ внизу UIScrollView, равный 0
    let contentInsets = UIEdgeInsets.zero
    scrollView?.contentInset = contentInsets
  }
  
  @objc private func hideKeyboard() {
    self.scrollView?.endEditing(true)
  }
  
  // MARK: - IBActions
  @IBAction func enterBtnTapped(_ sender: Any) {
    
  }
  
}

// MARK: - UIScrollViewDelegate
extension LoginFormController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.contentOffset.x = 0.0
    }
}

