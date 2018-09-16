//
//  PlaceData.swift
//  Weather Assignment
//
//  Created by Eman Elsayed on 9/13/18.
//  Copyright © 2018 Eman Elsayed. All rights reserved.
//

import UIKit
import CoreData

class PlaceData {
    
    var annotationsArray : Array<Annotation>?
    
    internal class var sharedInstance: PlaceData {
        struct Singleton {
            static let instance = PlaceData()
        }
        return Singleton.instance
    }
    
    /// Adding Annotation
    ///
    /// - Parameter annotation: annotation object
    func addAnnotation(annotation: Annotation) -> Void {
        annotationsArray?.append(annotation)
    }
    
    /// Removing Annotation 
    ///
    /// - Parameter annotation: annotation object
    func removeAnnotation(index: Int) -> Void {
        guard index < (annotationsArray?.count)! else {
            return
        }
        annotationsArray?.remove(at: index)
    }
    
}
