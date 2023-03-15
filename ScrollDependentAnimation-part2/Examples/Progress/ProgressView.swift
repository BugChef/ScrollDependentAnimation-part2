//
//  ProgressView.swift
//  ResizedWhenScrollingViewExample
//
//  Created by Kovalchuk Ilya on 13.02.2023.
//

import UIKit

class ProgressView: UIView {

    /// Percent of animation completion
    var progress: Float = 0 {
        didSet {
            slider.value = progress

            let percents = Int(progress * 100)
            progressIndicatorLabel.text = "\(percents) %"
        }
    }

    // MARK: - Private properties

    private lazy var slider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.tintColor = .systemGreen

        return slider
    }()

    private lazy var progressIndicatorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center

        return label
    }()

    // MARK: - Internal methods

    init() {
        super.init(frame: .zero)
        
        setupSlider()
        setupProgressIndicatorLabel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods

    private func setupSlider() {
        addSubview(slider)

        let inset: CGFloat = 10

        NSLayoutConstraint.activate([
            slider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
            slider.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -inset),
            slider.topAnchor.constraint(equalTo: topAnchor, constant: inset),
        ])
    }

    private func setupProgressIndicatorLabel() {
        addSubview(progressIndicatorLabel)

        let inset: CGFloat = 10

        NSLayoutConstraint.activate([
            progressIndicatorLabel.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: inset),
            progressIndicatorLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -inset),
            progressIndicatorLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
}
