//
//  CoordinatesChangeExampleViewController.swift
//  ScrollDependentAnimation-part2
//
//  Created by Ilia Kovalchuk on 15.03.2023.
//

import UIKit

class CoordinatesChangeExampleViewController: UIViewController {
    // MARK: - Private properties

    private let minConstraintConstant: CGFloat = 0
    private let maxConstraintConstant: CGFloat = 100

    private lazy var coordinateChangeView: CoordinatesChangeView = {
        let view = CoordinatesChangeView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray5

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

        setupCoordinateChangeView()
        setupTableView()
    }

    // MARK: - Private methods
    
    private func setupCoordinateChangeView() {
        view.addSubview(coordinateChangeView)

        NSLayoutConstraint.activate([
            coordinateChangeView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            coordinateChangeView.heightAnchor.constraint(equalToConstant: 80),
            coordinateChangeView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            coordinateChangeView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    private func setupTableView() {
        view.addSubview(tableView)

        animatedConstraint = tableView.topAnchor.constraint(
            equalTo: coordinateChangeView.bottomAnchor, constant: maxConstraintConstant
        )

        NSLayoutConstraint.activate([
            animatedConstraint!,
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

// MARK: - UITableViewDelegate

extension CoordinatesChangeExampleViewController: UITableViewDelegate {
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
        coordinateChangeView.animationCompletionPercentage = animationCompletionPercent

        previousContentOffsetY = scrollView.contentOffset.y
    }
}

// MARK: - UITableViewDataSource

extension CoordinatesChangeExampleViewController: UITableViewDataSource {
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
