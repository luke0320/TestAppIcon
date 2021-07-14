//
//  ViewController.swift
//  TestAppIcon
//
//  Created by Luke on 2021/7/14.
//

import UIKit

class ViewController: UIViewController {

    enum AppIcon: Int, CaseIterable {
        case `default`
        case alternative
        var iconName: String {
            switch self {
            case .default: return "Icon-1"
            case .alternative: return "Icon-2"
            }
        }
        
        init(iconName: String?) {
            self = AppIcon.allCases.first{$0.iconName == iconName} ?? .default
        }
    }
    
    private var label: UILabel = {
        let lbl = UILabel()
        lbl.text = "Select Your App Icon"
        lbl.font = .systemFont(ofSize: 20, weight: .bold)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        return lbl
    }()
    
    private var iconContainer: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.alignment = .fill
        sv.distribution = .fill
        sv.spacing = 50
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private lazy var appIcons = AppIcon.allCases.map {
        makeIconButton(imageName: $0.iconName, buttonTag: $0.rawValue)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateIconButtonSelection()
    }
    
    private func setupView() {
        
        appIcons.forEach {
            iconContainer.addArrangedSubview($0)
        }
        
        view.addSubview(label)
        view.addSubview(iconContainer)
        
        NSLayoutConstraint.activate([
            iconContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            iconContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            label.bottomAnchor.constraint(equalTo: iconContainer.topAnchor, constant: -20)
        ])
    }

    private func makeIconButton(imageName: String, buttonTag: Int, iconSize: CGFloat = 100) -> UIButton {
        let btn = UIButton()
        btn.tag = buttonTag
        
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.contentHorizontalAlignment = .fill
        btn.contentVerticalAlignment = .fill
        
        btn.layer.borderColor = UIColor.orange.cgColor
        btn.layer.cornerRadius = iconSize / 10
        btn.clipsToBounds = true
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.widthAnchor.constraint(equalToConstant: iconSize).isActive = true
        btn.heightAnchor.constraint(equalToConstant: iconSize).isActive = true
        
        btn.addTarget(self, action: #selector(onIconButtonTapped), for: .touchUpInside)
        
        return btn
    }
    
    private func updateIconButtonSelection() {
        let currentIcon = AppIcon(iconName: UIApplication.shared.alternateIconName)
        appIcons.forEach {
            let isSelected = currentIcon == AppIcon(rawValue: $0.tag)
            $0.layer.borderWidth = isSelected ? 4 : 0
        }
    }
    
    @objc
    private func onIconButtonTapped(_ sender: UIButton) {
        defer {
            updateIconButtonSelection()
        }
        
        guard
            sender.tag != AppIcon.default.rawValue,
            let appIcon = AppIcon(rawValue: sender.tag)
        else {
            UIApplication.shared.setAlternateIconName(nil)
            return
        }
        UIApplication.shared.setAlternateIconName(appIcon.iconName)
    }

}

