//
//  PostCell.swift
//  RedditFeeder
//
//  Created by Kiran kumar Sanka on 8/29/21.
//

import UIKit

class PostCell: UITableViewCell {
    
    var viewModel: PostViewModel?  {
        didSet{
            viewModel?.delegate = self
            self.reload()
        }
    }
    var postView: PostView? = {
        let postView = PostView(frame: CGRect.zero)
        postView.translatesAutoresizingMaskIntoConstraints =  false
        return postView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        setupConstraints()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.viewModel = nil
    }
    
    func loadView() {
        setupConstraints()
        reload()
    }

    func setupConstraints() {
        guard let listPostView = self.postView else {
            return
        }
        contentView.addSubview(listPostView)
        NSLayoutConstraint.activate([
            listPostView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            listPostView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            listPostView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
            listPostView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
    }
}

extension PostCell: PostViewModelDelegate {
    func reload() {
        postView?.headerLabel.text = self.viewModel?.post.title ?? viewModel?.post.subredditNamePrefixed
        print("Title... \(self.viewModel?.post.title ?? "")")
        if let image = viewModel?.feedImage {
            DispatchQueue.main.async {
                self.postView?.setCustomImage(image: image)
            }
        }
    }
}
