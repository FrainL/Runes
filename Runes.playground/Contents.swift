//: Playground - noun: a place where people can play

import UIKit
import Runes
import FxJSON

var str = "Hello, playground"

let foo = { (a: Int) -> Int? in
	return a + 1
}

let seque = [foo,foo,foo,foo]

let value = [3,4,5,6]

seque <*> value

let json: JSON = [3,4,5,6]

seque.map { $0 }

let foo2: (JSON.Iterator.Element) -> JSON? = { _ in nil }

json.map(foo2)

let some = json >>- foo2

print(some)
