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
}
