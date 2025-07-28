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
    
    let currentTimeLabel: UILabel = {
        let label = UILabel()
        label.font = .monospacedDigitSystemFont(ofSize: 16, weight: .medium)
        label.textColor = .white
        label.text = "0:00"
        return label
    }()
    
    let durationLabel: UILabel = {
        let label = UILabel()
        label.font = .monospacedDigitSystemFont(ofSize: 16, weight: .medium)
        label.textColor = .white
        label.text = "0:00"
        return label
    }()
    
    let dividerLabel: UILabel = {
        let label = UILabel()
        label.font = .monospacedDigitSystemFont(ofSize: 16, weight: .medium)
        label.textColor = .white
        label.text = "/"
        return label
    }()
    
    let playPauseButton: UIButton = {
        let button = UIButton(type: .system)
        let config = UIImage.SymbolConfiguration(pointSize: 16, weight: .bold)
        button.setImage(UIImage(systemName: "play.fill", withConfiguration: config), for: .normal)
        button.backgroundColor = .white
        button.tintColor = .clear
        button.layer.cornerRadius = 24
        button.clipsToBounds = true
        return button
    }()
    
    let dismissButton: UIButton = {
        let button = UIButton(type: .system)
        let config = UIImage.SymbolConfiguration(pointSize: 16, weight: .bold)
        button.setImage(UIImage(systemName: "chevron.down", withConfiguration: config), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    private let gradientLayer = CAGradientLayer()
    
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureAppearance()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
    
    // MARK: - Public methods
    
    func updateCurrentTime(_ seconds: Double) {
        currentTimeLabel.text = formatTime(seconds)
    }

    func updateDuration(_ seconds: Double) {
        durationLabel.text = formatTime(seconds)
    }
    
    func updatePlayState(isPlaying: Bool) {
        let config = UIImage.SymbolConfiguration(pointSize: 16, weight: .bold)
        let imageName = isPlaying ? "pause.fill" : "play.fill"
        let image = UIImage(systemName: imageName, withConfiguration: config)
        playPauseButton.setImage(image, for: .normal)
    }
    
    // MARK: - Private methods

    private func configureAppearance() {
        self.backgroundColor = .lightGray
        layer.insertSublayer(gradientLayer, at: 0)
    }

    private func formatTime(_ seconds: Double) -> String {
        guard seconds.isFinite else { return "0:00" }

        let intSec = Int(seconds)
        return String(format: "%d:%02d", intSec / 60, intSec % 60)
    }
    
    private func setupLayout() {
        let labelsStackView = UIStackView(arrangedSubviews: [trackNameLabel, artistNameLabel])
        labelsStackView.axis = .vertical
        labelsStackView.spacing = 4
        
        let timeStackView = UIStackView(arrangedSubviews: [currentTimeLabel, dividerLabel, durationLabel])
        timeStackView.axis = .horizontal
        timeStackView.spacing = 4
        
        [coverImageView, labelsStackView, timeStackView, playPauseButton, dismissButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }

        NSLayoutConstraint.activate([
            coverImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 48),
            coverImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            coverImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            coverImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            coverImageView.heightAnchor.constraint(equalTo: coverImageView.widthAnchor),

            dismissButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 12),
            dismissButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),

            labelsStackView.topAnchor.constraint(equalTo: coverImageView.bottomAnchor, constant: 24),
            labelsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            labelsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),

            playPauseButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            playPauseButton.topAnchor.constraint(equalTo: labelsStackView.bottomAnchor, constant: 24),
            playPauseButton.heightAnchor.constraint(equalToConstant: 48),
            playPauseButton.widthAnchor.constraint(equalTo: playPauseButton.heightAnchor),
            
            timeStackView.leadingAnchor.constraint(equalTo: playPauseButton.trailingAnchor, constant: 12),
            timeStackView.centerYAnchor.constraint(equalTo: playPauseButton.centerYAnchor)
        ])
    }
    
    func updateGradient(from image: UIImage?) {
        guard let image = image else { return }
        
        let downscaled = image.scaled(to: CGSize(width: 50, height: 50))

        DispatchQueue.global(qos: .userInteractive).async {
            let dominantColors = downscaled.extractDominantColors(maxCount: 2)
            guard dominantColors.count >= 2 else { return }

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) { [weak self] in
                guard let self = self else { return }
                
                let animation = CATransition()
                animation.type = .fade
                animation.duration = 0.25
                self.gradientLayer.add(animation, forKey: "fadeTransition")

                self.gradientLayer.colors = dominantColors.map { $0.cgColor }
                self.gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
                self.gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)

                self.playPauseButton.tintColor = dominantColors.last?.lighter(by: 20)
            }
        }
    }
}
