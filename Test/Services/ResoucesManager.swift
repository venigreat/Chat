//
//  ResoucesManager.swift
//  Test
//
//  Created by a.belyaev3 on 20.10.2020.
//  Copyright © 2020 a.belyaev3. All rights reserved.
//

import Foundation
import UIKit

enum FileName: String {
    
    case avatar = "avatar.png"
    case title = "title.txt"
    case profession = "profession.txt"
    case theme = "theme.txt"
}

class ResoucesManager {
    
    let dir: URL?
    
    init() {
        dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    }
    
    func write(vc: UIViewController, value: UIImage, fileName: FileName) {
        if let dir = dir {
            let fileURL = dir.appendingPathComponent(fileName.rawValue)
            do {
                if let data = value.pngData() {
                    try data.write(to: fileURL)
                }
            } catch {
                let alert = Alert(title: "Ошибка", message: "Ошибка сохранения изображения")
                alert.addRepeatButton { _ in
                    self.write(vc: vc, value: value, fileName: fileName)
                }
                DispatchQueue.main.async {
                    vc.present(alert.alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    func write(vc: UIViewController, value: String, fileName: FileName) {
        if let dir = dir {
            let fileURL = dir.appendingPathComponent(fileName.rawValue)
            do {
                try value.write(to: fileURL, atomically: true, encoding: .utf8)
            } catch {
                let alert = Alert(title: "Ошибка", message: "Ошибка сохранения изображения")
                alert.addRepeatButton { _ in
                    self.write(vc: vc, value: value, fileName: fileName)
                }
                DispatchQueue.main.async {
                    vc.present(alert.alert, animated: true, completion: nil)
                }
                
            }
        }
    }
    
    func read(fileName: FileName) -> String? {
        if let dir = dir {
            let fileURL = dir.appendingPathComponent(fileName.rawValue)
            do {
                let text = try String(contentsOf: fileURL, encoding: .utf8)
                return text
            } catch {
                print("ERROR READ")
            }
        }
        return nil
    }
    
    func readImage(fileName: FileName) -> UIImage? {
        if let dir = dir {
            let fileURL = dir.appendingPathComponent(fileName.rawValue).path
            let image = UIImage(contentsOfFile: fileURL)
                return image
        }
        return nil
    }
    
    func isFileExist(file: FileName) -> Bool {
        if let dir = dir {
            let fileURL = dir.appendingPathComponent(file.rawValue).path
            return FileManager.default.fileExists(atPath: fileURL)
        }
        return false
    }
}
