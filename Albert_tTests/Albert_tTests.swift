import XCTest
@testable import Albert_t

class Albert_tTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchArtListFromJSONResponse() {
        let asyncExpectation = expectation(description: "Async block executed")

        Albert_tTests.fetchMOCArt { (artList) in
            XCTAssert(artList.count == 10)
            asyncExpectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testArtDetailsVMInit() {
        let asyncExpectation = expectation(description: "Async block executed")

        Albert_tTests.fetchMOCArt { (artList) in
            
            let artCellVM = ArtCellVM(art: artList.first!)
            let artCellDetailsVM = ArtDetailsVM(artCellVM: artCellVM)
            XCTAssert(artCellDetailsVM.title == artCellVM.title)
            XCTAssert(artCellDetailsVM.longTitle == artCellVM.longTitle)
            XCTAssert(artCellDetailsVM.imageUrl == artCellVM.imageUrlString)
            XCTAssert(artCellDetailsVM.imageHeaderUrl == artCellVM.imageHeaderUrlString)

            XCTAssert(artCellDetailsVM.textColor == artCellVM.textColor)
            XCTAssert(artCellDetailsVM.backgroundColor == artCellVM.backgroundColor)

            asyncExpectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testArtCellVMInit() {
        let asyncExpectation = expectation(description: "Async block executed")

        Albert_tTests.fetchMOCArt { (artList) in
            
            let artItem = artList.first!
            let artCellVM = ArtCellVM(art: artItem)
            XCTAssert(artCellVM.title == artItem.title)
            XCTAssert(artCellVM.longTitle == artItem.longTitle)
            XCTAssert(artCellVM.imageUrlString == artItem.imageUrl)
            XCTAssert(artCellVM.imageHeaderUrlString == artItem.headerImageUrl)

            asyncExpectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
    }
    
    // MARK: - Helper
    static func fetchMOCArt(delay: Int = 0, completion: @escaping ([Art]) -> Void) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay)) {
            let filePath = "artListMOC"
            loadJsonDataFromFile(filePath, completion: { data in
                if let json = data {
                    do {
                        let response = try JSONDecoder().decode(ArtDetailsResponse.self, from: json)
                        let artList = response.artObjects.map { Art(artResponse: $0) }
                        completion(artList)
                    } catch _ as NSError {
                        fatalError("Couldn't load data from \(filePath)")
                    }
                }
            })
        }
    }

    static func loadJsonDataFromFile(_ path: String, completion: (Data?) -> Void) {
        if let fileUrl = Bundle.main.url(forResource: path, withExtension: "json") {
            do {
                let data = try Data(contentsOf: fileUrl, options: [])
                completion(data as Data)
            } catch {
                completion(nil)
            }
        }
    }
}
