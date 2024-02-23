//
//  Thumbnail.swift
//  Intermedia-Marvel
//
//  Created by Nicolas Famularo on 23/02/2024.
//

import Foundation

struct Thumbnail: Codable {
    let path: String?
    let fileExtension: String?
    
    enum CodingKeys: String, CodingKey {
        case path
        case fileExtension = "extension"
    }
}

extension Thumbnail {
    
    enum ImageFileRatio : String {
        case portrait, standard, landscape
    }
    
    enum ImageFileSize : String {
        case small, medium, large, xlarge, fantastic, amazing
    }
    
    func getFileURL(ratio: ImageFileRatio = .standard, size: ImageFileSize = .xlarge ) -> String? {
        guard let path = self.path, let fileExtension = self.fileExtension else {
            return nil
        }
        
        var url = "\(path)/\(ratio)_\(size).\(fileExtension)"
        if url.hasPrefix("http://") {
            url = url.replacingOccurrences(of: "http://", with: "https://")
        } else if !url.hasPrefix("https://") {
            url = "https://" + url
        }
        
        return url
    }
    
}
