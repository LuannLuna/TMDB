//
//  UIImageView+Extensions.swift
//
//  Created by Luann Marques Luna on 21/02/21.
//

import UIKit

extension UIImageView {
    private func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                DispatchQueue.main.async() { [weak self] in
                    self?.image = #imageLiteral(resourceName: "placeholder")
                }
            }
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: imgBaseUrl + link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
