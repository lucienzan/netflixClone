//
//  TextExtension.swift
//  netFlix
//
//  Created by Daniel on 1/27/24.
//
extension String {
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
