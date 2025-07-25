import UIKit

final class StubView: UIView {

    // MARK: - Properties

    private let label = UILabel()

    // MARK: - Init

    init(text: String) {
        super.init(frame: .zero)
        configureAppearance()
        configureLabel(with: text)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods

    private func configureAppearance() {
        backgroundColor = .systemBackground
    }
    
    private func configureLabel(with text: String) {
        label.text = text
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setupLayout() {
        addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -16)
        ])
    }
}
