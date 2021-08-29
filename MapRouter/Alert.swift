//
//  Alert.swift
//  MapRouter
//
//  Created by Eʟᴅᴀʀ Tᴇɴɢɪᴢᴏᴠ on 29.08.2021.
//

import UIKit

extension UIViewController {
    
    func alertAddAdress(title: String, placeholder: String, completion: @escaping (String) -> Void) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let alertOK = UIAlertAction(title: "OK", style: .default) { _ in
            guard let tfText  = alert.textFields?.first?.text else { return }
            completion(tfText)
        }
        let alertCancel = UIAlertAction(title: "Cancel", style: .destructive) { _ in
            
        }
                
        alert.addTextField { tf in
            tf.placeholder = placeholder
        }
        
        alert.addAction(alertOK)
        alert.addAction(alertCancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    func alertError(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertOK = UIAlertAction(title: "OK", style: .default)
        
        alert.addAction(alertOK)
        present(alert, animated: true, completion: nil)
    }
    
}
