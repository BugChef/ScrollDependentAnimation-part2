//
//  EnterViewController.swift
//  ResizedWhenScrollingViewExample
//
//  Created by Kovalchuk Ilya on 18.02.2023.
//

import UIKit

class EnterViewController: UIViewController {

    // MARK: - Private properties

    private lazy var buttonStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            makeButton(for: .progressExample),
            makeButton(for: .fadeExample),
            makeButton(for: .sizeChangeExample),
            makeButton(for: .coordinatesChangeExample),
        ])
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 20.0
        stack.translatesAutoresizingMaskIntoConstraints = false

        return stack
    }()

    // MARK: - Internal methods

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    // MARK: - Private methods

    private func setupView() {
        view.backgroundColor = .white

        view.addSubview(buttonStackView)

        NSLayoutConstraint.activate([
            buttonStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    private func makeButton(for tag: NavigationButtonTag) -> UIButton {
        let button = UIButton()
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitle(tag.title, for: .normal)
        button.tag = tag.rawValue
        button.addTarget(self, action: #selector(didTapButton(sender:)), for: .touchUpInside)
        
        return button
    }

    @objc private final func didTapButton(sender: UIButton) {
        let tag = NavigationButtonTag(rawValue: sender.tag)!
        
        let vc = tag.viewController
        vc.title = tag.title
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - NavigationButtonTag

private enum NavigationButtonTag: Int {
    case progressExample
    case fadeExample
    case sizeChangeExample
    case coordinatesChangeExample
    
    var title: String {
        switch self {
        case .progressExample:
            return "Progress example"
        case .fadeExample:
            return "Fade example"
        case .sizeChangeExample:
            return "Size change example"
        case .coordinatesChangeExample:
            return "Coordinates change example"
        }
    }
    
    var viewController: UIViewController {
        switch self {
        case .progressExample:
            return ProgressExampleViewController(nibName: nil, bundle: nil)
        case .fadeExample:
            return FadeExampleViewController(nibName: nil, bundle: nil)
        case .sizeChangeExample:
            return SizeChangeExampleViewController(nibName: nil, bundle: nil)
        case .coordinatesChangeExample:
            return CoordinatesChangeExampleViewController(nibName: nil, bundle: nil)
        }
    }
}
