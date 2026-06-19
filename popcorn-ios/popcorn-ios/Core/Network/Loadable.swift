enum Loadable<T> {
    case idle
    case loading
    case loaded(T)
    case failed(Error)
}
