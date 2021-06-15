import UIKit

class ArtListVM {
    let background = UIColor(red: 80/255.0, green: 80/255.0, blue: 80/255.0, alpha: 1)

    var title = "List of artwork..."
    
    let bottomInset = CGFloat(1)
    let estimatedHeight = CGFloat(150)
    
    private var currentCount = 0
    
    func cancelCatalogsFetch() {
        dataTask?.cancel()
    }
    
    func fetch(infoRequest: ArtRequest = ArtRequest(page: nil), completion: @escaping (Result<[Art], NetworkError>) -> ()) {
        fetchData(infoRequest: infoRequest) { result in
            completion(result)
        }
    }
    
    func fetchNext(completion: @escaping (Result<[Art], NetworkError>) -> ()) {
        dataTask?.cancel()
        dataTask = infoService.fetchAnoterArtPage { result in
            switch result {
            case .failure(let err):
                completion(.failure(err))
            case .success(let response):
                guard let artObjects = response?.artObjects else { return }
                let infos = artObjects.map { Art(artResponse: $0) }
                completion(.success(infos))
            }
        }
    }

    // MARK: - Properties
    private var dataTask: URLSessionDataTask?
    private let infoService = InfoService()
    
    // MARK: - Helper
    private func fetchData(infoRequest: ArtRequest = ArtRequest(page: nil), completion: @escaping (Result<[Art], NetworkError>) -> ()) {
        
        dataTask = infoService.fetchArt(infoRequest: infoRequest, completion: { result in
       
            switch result {
            case .failure(let err):
                completion(.failure(err))
            case .success(let response):
                guard let artObjects = response?.artObjects else { return }
                let infos = artObjects.map { Art(artResponse: $0) }
                completion(.success(infos))
            }
        })
    }
}
