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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        
        let lbl = UILabel()
        lbl.text = "Select Your App Icon"
        lbl.font = .systemFont(ofSize: 20, weight: .bold)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        
        let icons = AppIcon.allCases.map {
            makeIconButton(imageName: $0.iconName, buttonTag: $0.rawValue)
        }
        
        let sv = UIStackView(arrangedSubviews: icons)
        sv.axis = .horizontal
        sv.alignment = .fill
        sv.distribution = .fill
        sv.spacing = 50
        sv.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(lbl)
        view.addSubview(sv)
        
        NSLayoutConstraint.activate([
            sv.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sv.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            lbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lbl.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            lbl.bottomAnchor.constraint(equalTo: sv.topAnchor, constant: -20)
        ])
    }

    private func makeIconButton(imageName: String, buttonTag: Int, iconSize: CGFloat = 100) -> UIButton {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.tag = buttonTag
        btn.addTarget(self, action: #selector(onIconButtonTapped), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.contentVerticalAlignment = .fill
        btn.contentHorizontalAlignment = .fill
        btn.layer.cornerRadius = iconSize / 10
        btn.clipsToBounds = true
        btn.widthAnchor.constraint(equalToConstant: iconSize).isActive = true
        btn.heightAnchor.constraint(equalToConstant: iconSize).isActive = true
        return btn
    }
    
    @objc
    private func onIconButtonTapped(_ sender: UIButton) {
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

