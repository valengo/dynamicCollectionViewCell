//
//  ViewController.swift
//  AutoSizedCellCollection
//
//  Created by Andressa Valengo on 01/12/19.
//  Copyright © 2019 Andressa Valengo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var stackCollection: UICollectionView!
    
    var stacks = [UIStackView]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        stackCollection.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        stacks = [createUIStackView(width: view.bounds.width, height: 400, color: .red),
                  createUIStackView(width: view.bounds.width, height: 200, color: .blue),
                  createUIStackView(width: view.bounds.width, height: 50, color: .yellow),
                  createUIStackView(width: view.bounds.width, height: 300, color: .purple),
                  createUIStackView(width: view.bounds.width, height: 600, color: .orange),
                  createUIStackView(width: view.bounds.width, height: 300, color: .systemPink),
                  createUIStackView(width: view.bounds.width, height: 900, color: .green),
                  createUIStackView(width: view.bounds.width, height: 500, color: .lightGray),

        ]
        
        stackCollection.reloadData()
    }
    
    private func createUIStackView(width: CGFloat, height: CGFloat, color: UIColor) -> UIStackView {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        stack.addBackground(color: color)
        stack.widthAnchor.constraint(equalToConstant: width).isActive = true
        stack.heightAnchor.constraint(equalToConstant: height).isActive = true
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }

}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        stacks.count
    }
    
    func configureConstraint(_ constraint: NSLayoutConstraint) {
        constraint.isActive = true
        constraint.priority = UILayoutPriority(rawValue: 999)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AutoCell", for: indexPath)
        
        cell.subviews.forEach {
           $0.removeFromSuperview()
        }
                
        let stack = stacks[indexPath.row]
        stack.removeFromSuperview()
                
        cell.addSubview(stack)
        
        let leadingAnchor = stack.leadingAnchor.constraint(equalToSystemSpacingAfter: cell.leadingAnchor, multiplier: 1)
        configureConstraint(leadingAnchor)
        
        let trailingAnchor = stack.trailingAnchor.constraint(equalToSystemSpacingAfter: cell.trailingAnchor, multiplier: 1)
        configureConstraint(trailingAnchor)
        
        let topAnchor = stack.topAnchor.constraint(equalToSystemSpacingBelow: cell.topAnchor, multiplier: 1)
        configureConstraint(topAnchor)
        
        let bottomAnchor = stack.bottomAnchor.constraint(equalToSystemSpacingBelow: cell.bottomAnchor, multiplier: 1)
        configureConstraint(bottomAnchor)
        
        return cell
        
    }
}

extension UIStackView {
    func addBackground(color: UIColor) {
        let subView = UIView(frame: bounds)
        subView.backgroundColor = color
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(subView, at: 0)
    }
}

