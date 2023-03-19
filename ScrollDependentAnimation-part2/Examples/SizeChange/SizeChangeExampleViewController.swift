//
//  SizeChangeExampleViewController.swift
//  ScrollDependentAnimation-part2
//
//  Created by Ilia Kovalchuk on 14.03.2023.
//

import UIKit

class SizeChangeExampleViewController: UIViewController {
    // MARK: - Private properties

    private let minConstraintConstant: CGFloat = 50
    private let maxConstraintConstant: CGFloat = 200

    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "face.dashed"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .systemGreen
        
        return imageView
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
    private var avatarHeightConstraint: NSLayoutConstraint?

    private var previousContentOffsetY: CGFloat = 0

    // MARK: - Internal properties

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        setupAvatarView()
        setupTableView()
    }

    // MARK: - Private methods

    private func setupAvatarView() {
        view.addSubview(avatarImageView)
        
        avatarHeightConstraint = avatarImageView.heightAnchor.constraint(equalToConstant: maxConstraintConstant)
        
        NSLayoutConstraint.activate([
            avatarHeightConstraint!,
            avatarImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor, multiplier: 1.0),
            avatarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }

    private func setupTableView() {
        view.addSubview(tableView)

        animatedConstraint = tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: maxConstraintConstant)

        NSLayoutConstraint.activate([
            animatedConstraint!,
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

// MARK: - UITableViewDelegate

extension SizeChangeExampleViewController: UITableViewDelegate {
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
        
        // If the height constant is modified, changing the height of avatar
        if newConstraintConstant != avatarHeightConstraint!.constant {
            avatarHeightConstraint?.constant = currentConstraintConstant
        }
        
        previousContentOffsetY = scrollView.contentOffset.y
    }
}

// MARK: - UITableViewDataSource

extension SizeChangeExampleViewController: UITableViewDataSource {
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
