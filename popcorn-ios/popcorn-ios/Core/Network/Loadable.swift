enum Loadable<T> {
    case idle
    case loading
    case loaded(T)
    case failed(Error)
}

extension Loadable {
    var value: T? {
        if case .loaded(let v) = self { return v}
        return nil
    }
    
    func map<U>(_ transform: (T) -> U) -> Loadable<U> {
        switch self {
            case .idle:          return .idle
            case .loading:       return .loading
            case .failed(let e): return .failed(e)
            case .loaded(let v): return .loaded(transform(v))
        }
    }
}
