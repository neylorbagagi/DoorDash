import UIKit

extension UIImageView {
    func setImage(from urlString: String?, placeholder: UIImage? = nil) {
        self.image = placeholder
        guard let urlString = urlString, let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, let data = data, error == nil, let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self.image = image
            }
        }
        task.resume()
    }
}
