//
//  CoordinatesChangeView.swift
//  ScrollDependentAnimation-part2
//
//  Created by Ilia Kovalchuk on 15.03.2023.
//

import UIKit

class CoordinatesChangeView: UIView {
    
    var animationCompletionPercentage: Double = 0 {
        didSet { animator.fractionComplete = animationCompletionPercentage }
    }
    
    // MARK: - Private properties
    
    private let side: CGFloat = 60
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "face.dashed"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .systemGreen
        
        return imageView
    }()
    
    private lazy var animator = UIViewPropertyAnimator(duration: 0.1, curve: .easeIn) { [weak self] in
        guard let self else { return }

        self.imageView.transform = CGAffineTransform(translationX: self.side - self.bounds.width, y: 0)
    }
    
    // MARK: - Internal methods

    init() {
        super.init(frame: .zero)
        
        setupView()
    }
    
    deinit {
        animator.stopAnimation(true)
        if animator.state == .stopped {
            animator.finishAnimation(at: .current)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods
    
    private func setupView() {
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: side),
            imageView.heightAnchor.constraint(equalToConstant: side),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
