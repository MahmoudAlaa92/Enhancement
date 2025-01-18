//
//  VCPreview.swift
//  Enhancement
//
//  Created by Mahmoud Alaa on 19/01/2025.
//

import SwiftUI

struct VCPreview<T: UIViewController>: UIViewControllerRepresentable {
    
    let viewController: T
    
    init (_ viewControllerBuilder: @escaping () -> T){
        viewController = viewControllerBuilder()
    }
    
    
    func makeUIViewController(context: Context) -> T {
        viewController
    }
    
    func updateUIViewController(_ uiViewController: T, context: Context) { }
}
