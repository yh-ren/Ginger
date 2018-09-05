//
//  DataManager.swift
//  Ginger
//
//  Created by Sabrina Ren on 2018-08-27.
//  Copyright © 2018 Sabrina Ren. All rights reserved.
//

import Foundation

public class DataManager {
    
    // access Document Directory
    
    static fileprivate func getDocumentDirectory() -> URL {
        if let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            return url
        } else {
            fatalError("Unable to access document directory")
        }
    }
    
    // save any kind of codable objects
    
    static func save <T:Encodable> (_ object:T, with fileName:String) {
        let url = getDocumentDirectory().appendingPathComponent(fileName, isDirectory: false) // url points to file we're encoding
        
        let encoder = JSONEncoder() // creates JSON representation of data model
        
        do {
            let data = try encoder.encode(object) // encoder gives data object that is stored in the 'data' constant -> can save to disk
            if FileManager.default.fileExists(atPath: url.path) {
                try FileManager.default.removeItem(at: url) // overwrite file if it already exsits
            }
            FileManager.default.createFile(atPath: url.path, contents: data, attributes: nil)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    // load any kind of codable objects
    
    static func load <T:Decodable> (_ fileName:String, with type:T.Type) -> T{
        let url = getDocumentDirectory().appendingPathComponent(fileName, isDirectory: false) // url points to file we're looking for
        if !FileManager.default.fileExists(atPath: url.path) {
            fatalError("File not found at path \(url.path)") // throw error if file does not exist
        }
        
        if let data = FileManager.default.contents(atPath: url.path) { // if we are able to get content from url
            do {
                let model = try JSONDecoder().decode(type, from: data)
                return model
                // try to create object of ToDo type by decoding given decodable file
            } catch {
                fatalError(error.localizedDescription)
            }
        } else {
            fatalError("Data unavailable at path \(url.path)")
        }
        
    }
    
    // load data from a file
    
    static func loadData (_ fileName:String) -> Data? {
        let url = getDocumentDirectory().appendingPathComponent(fileName, isDirectory: false) // url points to file we're looking for
        if !FileManager.default.fileExists(atPath: url.path) {
            fatalError("File not found at path \(url.path)") // throw error if file does not exist
        }
        
        if let data = FileManager.default.contents(atPath: url.path) {
            return data
            
        } else {
            fatalError("Data unavailable at path \(url.path)")
        }
        
    }
    
    // load all files from a directory
    
    static func loadAll <T:Decodable> (_ type:T.Type) -> [T] {
        do {
            let files = try FileManager.default.contentsOfDirectory(atPath: getDocumentDirectory().path) // try to create list of files in Directory
            
            var modelObjects = [T]() // empty array of model objects
            
            for fileName in files {
                modelObjects.append(load(fileName, with: type)) // array of fileNames that can be returned after iterating through 'files' array
            }
            return modelObjects
            
        } catch {
            fatalError("Could not load any files")
        }
    }
    
    // delete a file
    
    static func delete(_ fileName:String) {
        let url = getDocumentDirectory().appendingPathComponent(fileName, isDirectory: false)
        
        if FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.removeItem(at: url)
            } catch {
                fatalError(error.localizedDescription)
            }
        }
    }
}
