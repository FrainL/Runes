/**
    map a function over a sequence of values

    This will return a new sequence resulting from the transformation function being applied to each value in the sequence

    - parameter f: A transformation function from type `T` to type `U`
    - parameter a: A value of type `[T]`

    - returns: A value of type `[U]`
*/
public func <^> <T: Sequence, ElementOfResult>(f: (T.Iterator.Element) -> ElementOfResult, a: T) -> [ElementOfResult] {
    return a.map(f)
}

/**
    apply a sequence of functions to a sequence of values

    This will return a new array resulting from the matrix of each function being applied to each value in the sequence

    - parameter fs: a sequence of transformation functions from type `T` to type `U`
    - parameter a: A value of type `[T]`

    - returns: A value of type `[U]`
*/
public func <*> <T: Sequence, U: Sequence, ElementOfResult>(fs: T, a: U) -> [ElementOfResult]
    where T.Iterator.Element == (U.Iterator.Element) -> ElementOfResult {
    return a.apply(fs)
}

/**
    flatMap a function over an sequence of values (left associative)

    apply a function to each value of a sequence and flatten the resulting array

    - parameter f: A transformation function from type `T` to type `[U]`
    - parameter a: A value of type `[T]`

    - returns: A value of type `[U]`
*/
public func >>- <T: Sequence, ElementOfResult>(a: T, f: (T.Iterator.Element) throws -> [ElementOfResult]) rethrows -> [ElementOfResult] {
    return try a.flatMap(f)
}

public func >>- <T: Sequence, ElementOfResult>(a: T, f: (T.Iterator.Element) throws -> ElementOfResult?) rethrows -> [ElementOfResult] {
    return try a.flatMap(f)
}

/**
    flatMap a function over a sequence of values (right associative)

    apply a function to each value of an sequence and flatten the resulting array

    - parameter f: A transformation function from type `T` to type `[U]`
    - parameter a: A value of type `[T]`

    - returns: A value of type `[U]`
*/
public func -<< <T: Sequence, ElementOfResult>(f: (T.Iterator.Element) throws -> [ElementOfResult], a: T) rethrows -> [ElementOfResult] {
  return try a.flatMap(f)
}

public func -<< <T: Sequence, ElementOfResult>(f: (T.Iterator.Element) throws -> ElementOfResult?, a: T) rethrows -> [ElementOfResult] {
    return try a.flatMap(f)
}

/**
    compose two functions that produce sequences of values, from left to right

    produces a function that applies that flatMaps the second function over each element in the result of the first function

    - parameter f: A transformation function from type `T` to type `[U]`
    - parameter g: A transformation function from type `U` to type `[V]`

    - returns: A value of type `[V]`
*/
public func >-> <T, U: Sequence, V>(f: @escaping (T) -> U, g: @escaping (U.Iterator.Element) -> [V]) -> (T) -> [V] {
    return { x in f(x) >>- g }
}

/**
    compose two functions that produce sequences of values, from right to left

    produces a function that applies that flatMaps the first function over each element in the result of the second function

    - parameter f: A transformation function from type `U` to type `[V]`
    - parameter g: A transformation function from type `T` to type `[U]`

    - returns: A value of type `[V]`
*/
public func <-< <T, U: Sequence, V>(f: @escaping (U.Iterator.Element) -> [V], g: @escaping (T) -> U) -> (T) -> [V] {
    return { x in g(x) >>- f }
}

/**
    Wrap a value in a minimal context of `[]`

    - parameter a: A value of type `T`

    - returns: The provided value wrapped in an array
*/
public func pure<T>(_ a: T) -> [T] {
    return [a]
}

public extension Sequence {
    /**
     apply a sequence of functions to `self`
     
     This will return a new array resulting from the matrix of each function being applied to each value inside `self`
     
     - parameter fs: A sequence of transformation functions from type `Element` to type `T`
     
     - returns: A value of type `[T]`
     */
    func apply<T: Sequence, ElementOfResult>(_ fs: T) -> [ElementOfResult]
        where T.Iterator.Element == (Iterator.Element) -> ElementOfResult {
            return fs.flatMap { self.map($0) }
    }
}
