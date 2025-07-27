import Combine
import UIKit

final class SearchViewController: UIViewController {
    
    // MARK: - Properties
    
    var presenter: SearchPresenterProtocol!
    
    private var searchView: SearchView {
        view as! SearchView
    }

    private var debounceCancellable: AnyCancellable?
    private var currentResults: [Track] = []
    
    // MARK: - LifeCycle
    
    override func loadView() {
        view = SearchView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
        setupBindings()
        setupTableView()
    }

    // MARK: - Private methods
    
    private func configureAppearance() {
        title = "Search"
        view.backgroundColor = .systemBackground
        navigationItem.searchController = searchView.searchController
        definesPresentationContext = true
    }
    
    private func setupBindings() {
        debounceCancellable = searchView.textPublisher
            .handleEvents(receiveOutput: { [weak self] text in
                guard text.count >= 3 else { return }
                self?.searchView.showLoading()
            })
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .sink { [weak self] keyword in
                guard keyword.count >= 3 else {
                    self?.currentResults = []
                    self?.searchView.showResults()
                    self?.searchView.tableView.reloadData()
                    return
                }
                self?.presenter.didSearch(for: keyword)
            }
    }

    private func setupTableView() {
        searchView.tableView.rowHeight = UITableView.automaticDimension
        searchView.tableView.estimatedRowHeight = 80

        searchView.tableView.dataSource = self
        searchView.tableView.register(TrackTableViewCell.self, forCellReuseIdentifier: TrackTableViewCell.reuseIdentifier)
    }

}

// MARK: - SearchViewInput

extension SearchViewController: SearchViewInput {
    func displayResults(_ results: [Track]) {
        currentResults = results
        if results.isEmpty {
            searchView.showEmptyState()
        } else {
            searchView.showResults()
            searchView.tableView.reloadData()
        }
    }

    func displayError(_ error: Error) {
        searchView.showEmptyState()
        print("Error: \(error.localizedDescription)")
    }
}

// MARK: - UITableViewDataSource

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        currentResults.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let track = currentResults[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: TrackTableViewCell.reuseIdentifier, for: indexPath) as! TrackTableViewCell
        cell.configure(with: track)
        return cell
    }
}
