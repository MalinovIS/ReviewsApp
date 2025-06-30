import UIKit

final class ReviewsViewController: UIViewController {

    private lazy var reviewsView: DisplaysReviews = ReviewsView()
    private let viewModel: ReviewsViewModel

    init(viewModel: ReviewsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = reviewsView
        reviewsView.delegate = self
        title = "Отзывы"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        reviewsView.startLoader()
        setupViewModel()
        viewModel.getReviews()
    }
    
}

extension ReviewsViewController: ReviewsViewDelegate {
    func returnConfig() -> ReviewsViewModel {
        return viewModel
    }
    
}

// MARK: - Private

private extension ReviewsViewController {

    func setupViewModel() {
        viewModel.onStateChange = { [weak self] _ in
            guard let self = self else { return }
            self.reviewsView.reloadTableView()
            self.reviewsView.stopLoader()
        }
    }

}
