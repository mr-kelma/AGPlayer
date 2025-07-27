import UIKit

final class StartView: UIView {

    // MARK: - Properties
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(resource: .logo))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
        backgroundColor = .white
    }
    
    private func setupLayout() {
        addSubview(logoImageView)
        
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 250),
            logoImageView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
}
