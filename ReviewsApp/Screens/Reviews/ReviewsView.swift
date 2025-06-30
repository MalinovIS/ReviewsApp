import UIKit

protocol DisplaysReviews: UIView {
    var delegate: ReviewsViewDelegate? { get set }
    
    func reloadTableView()
    func startLoader()
    func stopLoader()
}

protocol ReviewsViewDelegate: AnyObject {
    
    func returnConfig() -> ReviewsViewModel
}

final class ReviewsView: UIView {
    weak var delegate: ReviewsViewDelegate? {
        didSet {
            configureTableView()
        }
    }
    private let tableView = UITableView()
    private let loader = UIActivityIndicatorView(style: .large)

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        tableView.frame = bounds.inset(by: safeAreaInsets)
        loader.frame = bounds.inset(by: safeAreaInsets)
    }

}

extension ReviewsView: DisplaysReviews {
    func startLoader() {
        loader.startAnimating()
        print("Start loader")
    }
    
    func stopLoader() {
        loader.stopAnimating()
        print("Stop loader")
    }
    
    
    func reloadTableView() {
        tableView.reloadData()
    }
    
}
// MARK: - Private

private extension ReviewsView {

    func setupView() {
        backgroundColor = .systemBackground
        setupTableView()
        setupLoader()
    }

    func setupTableView() {
        addSubview(tableView)
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.register(ReviewCell.self, forCellReuseIdentifier: ReviewCellConfig.reuseId)
        tableView.register(ReviewCountCell.self, forCellReuseIdentifier: ReviewCountCellConfig.reuseId)
    }
    
    func setupLoader() {
        addSubview(loader)
    }
    
    func configureTableView() {
        guard let delegate else {
            return
        }
        tableView.delegate = delegate.returnConfig()
        tableView.dataSource = delegate.returnConfig()
    }

}
