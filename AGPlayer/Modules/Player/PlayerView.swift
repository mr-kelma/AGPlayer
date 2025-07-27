import UIKit

final class PlayerView: UIView {
    
    // MARK: - Properties
    
    let coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.backgroundColor = .secondarySystemBackground
        return imageView
    }()
    
    let trackNameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    let artistNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    let playPauseButton = UIButton(type: .system)
    
    let dismissButton: UIButton = {
        let button = UIButton(type: .system)
        let config = UIImage.SymbolConfiguration(pointSize: 14, weight: .bold)
        button.setImage(UIImage(systemName: "chevron.down", withConfiguration: config), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureAppearance()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods

    private func configureAppearance() {
        backgroundColor = .red
        playPauseButton.setTitle("Play", for: .normal)
    }

    private func setupLayout() {
        [coverImageView, trackNameLabel, artistNameLabel, playPauseButton, dismissButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }

        NSLayoutConstraint.activate([
            coverImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 32),
            coverImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            coverImageView.widthAnchor.constraint(equalToConstant: 250),
            coverImageView.heightAnchor.constraint(equalTo: coverImageView.widthAnchor),

            dismissButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            dismissButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),

            trackNameLabel.topAnchor.constraint(equalTo: coverImageView.bottomAnchor, constant: 24),
            trackNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            trackNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            artistNameLabel.topAnchor.constraint(equalTo: trackNameLabel.bottomAnchor, constant: 8),
            artistNameLabel.leadingAnchor.constraint(equalTo: trackNameLabel.leadingAnchor),
            artistNameLabel.trailingAnchor.constraint(equalTo: trackNameLabel.trailingAnchor),

            playPauseButton.topAnchor.constraint(equalTo: artistNameLabel.bottomAnchor, constant: 24),
            playPauseButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
