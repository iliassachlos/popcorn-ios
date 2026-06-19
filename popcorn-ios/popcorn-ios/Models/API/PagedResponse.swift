struct PagedResponse<T: Decodable>: Decodable {
    let page: Int
    let results: [T]
    let total_pages: Int
    let total_results: Int
}
