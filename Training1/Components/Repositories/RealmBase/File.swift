//
//  File.swift
//  Training1
//
//  Created by Sanledi Buli on 28/03/20.
//  Copyright © 2020 Working Home. All rights reserved.
//

import Foundation

internal final class File {

    static func path(_ name: String, extension ext: String = "") -> URL? {

        guard let documentURL = try? FileManager.default
            .url(for: .documentDirectory,
                 in: .userDomainMask,
                 appropriateFor: nil,
                 create: true) else {

                    return nil
        }

        if ext.isEmpty {
            return documentURL.appendingPathComponent("\(name)")
        }

        return documentURL.appendingPathComponent("\(name).\(ext)")
    }

    public func copyFilesFromBundleToDocuments(fileName: String, ofType: String) {
        guard let documentsPath: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else {
            return
        }

        let storePath: String = documentsPath + "/" + fileName + "." + ofType
        let path = Bundle.main.path(forResource: fileName, ofType: ofType)
        if FileManager.default.fileExists(atPath: storePath) {
            do {
                try  FileManager.default.removeItem(atPath: storePath)
            } catch {
                print("Error removing pre-populated Realm \(error)")
            }
        }
        if let bundledPath = path {
            do {
                try FileManager.default.copyItem(atPath: bundledPath, toPath: storePath)
            } catch {
                print("Error copying pre-populated Realm \(error)")
            }
        } else {
            print("\(fileName).\(ofType) exists")
        }
    }

}
