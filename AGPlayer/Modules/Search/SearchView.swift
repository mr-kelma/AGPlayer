import UIKit
import Combine

final class SearchView: UIView {
    
    // MARK: - Properties
    
    let searchController = UISearchController(searchResultsController: nil)
    let tableView = UITableView()
    
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private let emptyStateLabel: UILabel = {
        let label = UILabel()
        label.text = "No results found"
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        label.isHidden = true
        return label
    }()
    
    private let searchTextPublisher = PassthroughSubject<String, Never>()
    var textPublisher: AnyPublisher<String, Never> {
        searchTextPublisher.eraseToAnyPublisher()
    }

    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureAppearance()
        setupLayout()
        setupSearchController()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public methods
    
    func showEmptyState() {
        activityIndicator.stopAnimating()
        tableView.isHidden = true
        emptyStateLabel.isHidden = false
    }
    
    func showLoading() {
        activityIndicator.startAnimating()
        tableView.isHidden = true
        emptyStateLabel.isHidden = true
    }

    func showResults() {
        activityIndicator.stopAnimating()
        tableView.isHidden = false
        emptyStateLabel.isHidden = true
    }
    
    // MARK: - Private methods
    
    private func configureAppearance() {
        backgroundColor = .systemBackground
        activityIndicator.hidesWhenStopped = true
    }
    
    private func setupLayout() {
        [tableView, activityIndicator, emptyStateLabel].forEach { addSubview($0) }
        tableView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        emptyStateLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),

            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),

            emptyStateLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            emptyStateLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Artists, Songs, Lyrics and More"
        searchController.searchBar.autocapitalizationType = .none
    }
}

// MARK: - UISearchResultsUpdating

extension SearchView: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let keyword = searchController.searchBar.text ?? ""
        searchTextPublisher.send(keyword)
    }
}
