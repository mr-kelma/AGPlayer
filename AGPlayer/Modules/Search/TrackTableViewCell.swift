import UIKit

final class TrackTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let reuseIdentifier = "TrackTableViewCell"
    
    private let coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.backgroundColor = .secondarySystemBackground
        return imageView
    }()
    
    private let trackNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()
    
    private let artistNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
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
    
    // MARK: - Lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        coverImageView.image = nil
        trackNameLabel.text = nil
        artistNameLabel.text = nil
    }
    
    // MARK: - Public methods
    
    func configure(with track: Track) {
        trackNameLabel.text = track.trackName?.isEmpty == false ? track.trackName : "Unknown song"
        artistNameLabel.text = track.artistName?.isEmpty == false ? track.artistName : "Unknown artist"
        
        // To cache pictures can use, for example, Kingfisher
        if let urlString = track.artworkUrl100,
           let url = URL(string: urlString) {
            coverImageView.loadImage(from: url, placeholder: UIImage(systemName: "placeholder"))
        }
    }
    
    // MARK: - Private methods
    
    private func setupLayout() {
        let labelsStackView = UIStackView(arrangedSubviews: [trackNameLabel, artistNameLabel])
        labelsStackView.axis = .vertical
        labelsStackView.spacing = 2
        
        [coverImageView, labelsStackView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            coverImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            coverImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            coverImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            coverImageView.heightAnchor.constraint(equalToConstant: 50),
            coverImageView.widthAnchor.constraint(equalTo: coverImageView.heightAnchor),
            
            labelsStackView.leadingAnchor.constraint(equalTo: coverImageView.trailingAnchor, constant: 8),
            labelsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            labelsStackView.centerYAnchor.constraint(equalTo: coverImageView.centerYAnchor)
        ])
    }
}
