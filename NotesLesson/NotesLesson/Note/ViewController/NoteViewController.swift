//
//  NoteViewController.swift
//  NotesLesson
//
//  Created by Katerina on 06/01/2024.
//
import SnapKit
import UIKit

final class NoteViewController: UIViewController {
    // MARK: - GUI Variables
    private let attachmentView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 10
        view.image = UIImage(named: "mockImage")
        view.layer.masksToBounds = true
        view.contentMode = .scaleAspectFit
        view.backgroundColor = .white
        return view
    }()
    
    private let textView: UITextView = {
        let view = UITextView()
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.cornerRadius = 10
       // view.text = "Mock Text"
        
        return view
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    // MARK: - Methods
    func set(note: Note) {
        textView.text = note.title + " " + note.description
        guard let data = note.image else { return }
        attachmentView.image = UIImage(data: data)
    }
    
    // MARK: - Private methods
    @objc
    private func saveAction() {
        
    }
    
    @objc
    private func deleteAction() {
        
    }
    
    private func setupUI() {
        view.addSubview(attachmentView)
        view.addSubview(textView)
        view.backgroundColor = .white
        textView.layer.borderWidth = textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? 1 : 0
     
        setupConstraints()
        setImageHeight()
        setupBars()
        registerForKeyboardNotification()
        hideKeyboardWhenTappedAround()
    }
    
    private func setupConstraints() {
        attachmentView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        
        textView.snp.makeConstraints { make in
            make.top.equalTo(attachmentView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(95)
        }
    }
    
    private func setImageHeight() {
        let height = attachmentView.image != nil ? 200 : 0
        
        attachmentView.snp.makeConstraints { make in
            make.height.equalTo(height)
        }
    }
    
    private func setupBars() {
        let trash = UIBarButtonItem(barButtonSystemItem: .trash,
                                    target: self,
                                    action: #selector(deleteAction))
        setToolbarItems([trash], animated: true)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save,
                                                            target: self,
                                                            action: #selector(saveAction))
    }
}

extension NoteViewController {
    func registerForKeyboardNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)



        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }

    @objc
    func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        
        self.textView.snp.updateConstraints { (make) in
            make.bottom.equalToSuperview().inset(keyboardFrame.height + 10)
        }
    }
    
    @objc
    func keyboardWillHide(_ notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        self.textView.snp.updateConstraints { (make) in
            make.bottom.equalToSuperview().inset(95)
        }
        
    }
    
    func hideKeyboardWhenTappedAround() {
        let recognizer = UITapGestureRecognizer(target: self,
                                                action: #selector(hideKeyBoard))
        view.addGestureRecognizer(recognizer)
    }
    
    @objc
    private func hideKeyBoard() {
        textView.resignFirstResponder()
    }
}
