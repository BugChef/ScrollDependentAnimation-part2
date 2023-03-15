//
//  FadeView.swift
//  ScrollDependentAnimation-part2
//
//  Created by Ilia Kovalchuk on 14.03.2023.
//

import UIKit

class FadeView: UIView {
    
    // MARK: - Private properties
    
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "face.dashed"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .systemGreen
        
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.text = "Title"
        label.font = .preferredFont(forTextStyle: .title1)

        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.text = "Subtitle"
        label.font = .preferredFont(forTextStyle: .body)

        return label
    }()
    
    private lazy var labelsContainer: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.spacing = 4
        
        return stackView
    }()
    
    private lazy var mainContainer: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [avatarImageView, labelsContainer])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = .init(top: 4, left: 4, bottom: 4, right: 4)
        
        return stackView
    }()
    
    // MARK: - Internal methods

    init() {
        super.init(frame: .zero)
        
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods
    
    private func setupView() {
        addSubview(mainContainer)
        
        NSLayoutConstraint.activate([
            avatarImageView.widthAnchor.constraint(equalTo: avatarImageView.heightAnchor, multiplier: 1.0),
            mainContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainContainer.topAnchor.constraint(equalTo: topAnchor),
            mainContainer.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
