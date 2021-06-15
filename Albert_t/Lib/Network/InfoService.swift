import UIKit

class InfoService: NetworkService {
    
    // MARK: - API
    func fetch(image imageUrl: String, completion: @escaping (Result<UIImage, NetworkError>) -> ()) -> URLSessionDataTask? {

        guard let url = URL(string: imageUrl) else { return nil }

        let task = URLSession.shared.dataTask(with: url) { (data, resp, err) in

            if let err = err {
                completion(.failure(NetworkError.error(err: err)))
                return
            }

            guard let data = data else {
                completion(.failure(.unknown))
                return
            }

            guard let img = UIImage(data: data) else {
                completion(.failure(.unknown))
                return
            }

            completion(.success(img))
        }
        task.resume()
        return task
    }

    func fetchArt(infoRequest: ArtRequest? = nil, completion: @escaping (Result<ArtDetailsResponse?, NetworkError>) -> ()) -> URLSessionDataTask? {
        
        let infoRequest = infoRequest == nil ? ArtRequest(page: 1) : infoRequest!
        
        return load(urlString: urlString, path: path, method: .get, params: infoRequest.body(), headers: nil) { (result: Result<ArtDetailsResponse?, NetworkError>) in

            switch result {
            case .success(let catalogResponse):
                self.artPage += 1
                completion(.success(catalogResponse))
            case .failure(let err):
                completion(.failure(err))
            }
        }
    }
    
    func fetchAnoterArtPage(completion: @escaping (Result<ArtDetailsResponse?, NetworkError>) -> ()) -> URLSessionDataTask? {
        return fetchArt(infoRequest: ArtRequest(page: artPage)) { result in
            completion(result)
        }
    }
    
    private var artPage = 1

    // MARK: - Properties
    private let scheme = "https://"
    private let host = "www.rijksmuseum.nl/"
    private let path = "api/en/collection"

    private var urlString: String {
        return scheme + host
    }
}
