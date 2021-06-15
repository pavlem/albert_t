import Foundation

class ArtRequest {
    let page: Int?
    let apiKey = "0fiuZFh4"
    let ps = 10
    
    init(page: Int?) {
        self.page = page
    }
}

extension ArtRequest {
    
    func body() -> NetworkService.JSON {
        var params: [String: Any] = [
            "key": apiKey,
        ]
        
        if let page = self.page {
            params["p"] = page
            params["ps"] = ps
        } else {
            params["p"] = 1
            params["ps"] = ps
        }
        
        return params
    }
}
