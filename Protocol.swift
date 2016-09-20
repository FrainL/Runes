//
//  Protocol.swift
//  Runes
//
//  Created by Frain on 16/9/20.
//  Copyright © 2016年 thoughtbot. All rights reserved.
//

import Foundation

public protocol Functor {
    
    associatedtype Value
    
    func map<T: Functor>(f: (Value) -> T) -> T
}

public protocol Applicative {
    
    associatedtype Value
    
}
