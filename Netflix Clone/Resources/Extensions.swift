//
//  Extensions.swift
//  Netflix Clone
//
//  Created by Ahmed Salem on 18/11/2022.
//

import Foundation

extension String {
    func capitalizeFirstLetter() -> String
    {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
