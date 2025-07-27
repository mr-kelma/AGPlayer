import UIKit

final class TrackTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let reuseIdentifier = "TrackTableViewCell"
    
    private let coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 6
        imageView.backgroundColor = .secondarySystemBackground
        return imageView
    }()
    
    private let trackNameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .label
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let artistNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        coverImageView.image = nil
        trackNameLabel.text = nil
        artistNameLabel.text = nil
    }
    
    // MARK: - Public methods
    
    func configure(with track: Track) {
        trackNameLabel.text = track.trackName
        artistNameLabel.text = track.artistName

        if let urlString = track.trackViewUrl,
           let url = URL(string: urlString) {
            coverImageView.loadImage(from: url, placeholder: UIImage(systemName: "music.note"))
        }
    }
    
    // MARK: - Private methods
    
    private func setupLayout() {
        contentView.addSubview(coverImageView)
        contentView.addSubview(trackNameLabel)
        contentView.addSubview(artistNameLabel)

        NSLayoutConstraint.activate([
            coverImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            coverImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            coverImageView.widthAnchor.constraint(equalToConstant: 60),
            coverImageView.heightAnchor.constraint(equalToConstant: 60),

            trackNameLabel.topAnchor.constraint(equalTo: coverImageView.topAnchor),
            trackNameLabel.leadingAnchor.constraint(equalTo: coverImageView.trailingAnchor, constant: 12),
            trackNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            artistNameLabel.topAnchor.constraint(equalTo: trackNameLabel.bottomAnchor, constant: 4),
            artistNameLabel.leadingAnchor.constraint(equalTo: trackNameLabel.leadingAnchor),
            artistNameLabel.trailingAnchor.constraint(equalTo: trackNameLabel.trailingAnchor),
            artistNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }
}
