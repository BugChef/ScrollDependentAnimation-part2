//
//  ProgressExampleViewController.swift
//  ResizedWhenScrollingViewExample
//
//  Created by Kovalchuk Ilya on 13.02.2023.
//

import UIKit

class ProgressExampleViewController: UIViewController {
    // MARK: - Private properties

    private let minConstraintConstant: CGFloat = 50
    private let maxConstraintConstant: CGFloat = 200

    private lazy var progressView: ProgressView = {
        let view = ProgressView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = false
        view.backgroundColor = .systemGray5
        view.progress = 0.0

        return view
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .systemGray5
        tableView.contentInset.top = 16

        return tableView
    }()

    private var animatedConstraint: NSLayoutConstraint?

    private var previousContentOffsetY: CGFloat = 0

    // MARK: - Internal properties

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        setupProgressView()
        setupTableView()
    }

    // MARK: - Private methods

    private func setupProgressView() {
        view.addSubview(progressView)

        NSLayoutConstraint.activate([
            progressView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            progressView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }

    private func setupTableView() {
        view.addSubview(tableView)

        animatedConstraint = tableView.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: maxConstraintConstant)

        NSLayoutConstraint.activate([
            animatedConstraint!,
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

// MARK: - UITableViewDelegate

extension ProgressExampleViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentContentOffsetY = scrollView.contentOffset.y
        let scrollDiff = currentContentOffsetY - previousContentOffsetY

        // Upper border of the bounce effect
        let bounceBorderContentOffsetY = -scrollView.contentInset.top

        let contentMovesUp = scrollDiff > 0 && currentContentOffsetY > bounceBorderContentOffsetY
        let contentMovesDown = scrollDiff < 0 && currentContentOffsetY < bounceBorderContentOffsetY

        let currentConstraintConstant = animatedConstraint!.constant
        var newConstraintConstant = currentConstraintConstant

        if contentMovesUp {
            // Reducing the constraint's constant
            newConstraintConstant = max(currentConstraintConstant - scrollDiff, minConstraintConstant)
        } else if contentMovesDown {
            // Increasing the constraint's constant
            newConstraintConstant = min(currentConstraintConstant - scrollDiff, maxConstraintConstant)
        }

        // If the constant is modified, changing the height and disable scrolling
        if newConstraintConstant != currentConstraintConstant {
            animatedConstraint?.constant = newConstraintConstant
            scrollView.contentOffset.y = previousContentOffsetY
        }

        // Animation progress percentage
        let animationCompletionPercent = (maxConstraintConstant - currentConstraintConstant) / (maxConstraintConstant - minConstraintConstant)
        progressView.progress = Float(animationCompletionPercent)

        previousContentOffsetY = scrollView.contentOffset.y
    }
}

// MARK: - UITableViewDataSource

extension ProgressExampleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Stub cell"
        cell.textLabel?.textColor = .black
        cell.backgroundColor = .clear

        return cell
    }
}
