//
//  PostView.swift
//  RedditFeeder
//
//  Created by Kiran kumar Sanka on 8/29/21.
//

import UIKit

class PostView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 8
        stack.distribution = .fillProportionally
        stack.alignment = .fill

        return stack
    }()
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "hellohellohellohellohellohellohellohellohell"
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "hellohellohellohellohellohellohellohellohello"
        label.numberOfLines = 0
        return label
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "defaultEmptyImage")
        imageView.contentMode = .center
        return imageView
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()
    
    var aspectConstraint : NSLayoutConstraint? {
        didSet {
            if oldValue != nil {
                imageView.removeConstraint(oldValue!)
            }
            if aspectConstraint != nil {
                imageView.addConstraint(aspectConstraint!)
            }
        }
    }

    func setCustomImage(image : UIImage) {
        let aspect = image.size.width / image.size.height
        
        let constraint = NSLayoutConstraint(item: imageView, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: imageView, attribute: NSLayoutConstraint.Attribute.height, multiplier: aspect, constant: 0.0)
        constraint.priority = UILayoutPriority(999)
        aspectConstraint = constraint
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
    }

    func prepareView() {
        self.addSubview(self.headerLabel)
        self.addSubview(self.imageView)
        self.addSubview(self.separatorView)
        self.setCustomImage(image: UIImage(named: "defaultEmptyImage") ?? UIImage())
        constraints()

    }
    
    func constraints() {
        let views = ["headerLabel": self.headerLabel, "imageView": self.imageView, "separatorView": self.separatorView]
        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-8-[headerLabel]-8-[imageView]-8-[separatorView]|", options: [], metrics: nil, views: views)
        
        NSLayoutConstraint.activate([
            headerLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15),
            headerLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15),
            imageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15),
            imageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15),
            separatorView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
            separatorView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
            separatorView.heightAnchor.constraint(equalToConstant: 15)
        ])
        self.addConstraints(verticalConstraints)
    }
}

extension UIView {
    func pin(to view: UIView) {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: view.topAnchor),
            self.leftAnchor.constraint(equalTo: view.leftAnchor),
            self.rightAnchor.constraint(equalTo: view.rightAnchor),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
