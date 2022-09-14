//
//  APIService.swift
//  ScrollReaderTest
//
//  Created by Taehyung Lee on 2022/09/13.
//

import SwiftUI
import FirebaseStorage  // for saving image to Storage
import FirebaseFirestore
import FirebaseFirestoreSwift

import Combine

enum WineAPI {
    private static let base = URL(string: "https://api.themoviedb.org/3")!
    
}

class APIService {
    static let shared:APIService = APIService()
    
    let db = Firestore.firestore()
    
    // http request
    func run<T: Decodable>(_ request: URLRequest) -> AnyPublisher<T, Error> {
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .map { $0.data }
            .handleEvents(receiveOutput: { print(NSString(data: $0, encoding: String.Encoding.utf8.rawValue)!) })
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    /// firebase 를 통해서 데이터 가져오기
    func requestWineData(firstQuery:Query?, pagingCnt:Int,
                         completedAction:@escaping ([WineDataModel], Query?)->Void) {
        let first:Query = firstQuery ?? self.db.collection("wines")
            .order(by: "koreanName")
            .limit(to: pagingCnt)
        first.addSnapshotListener { (snapshot, error) in
            guard let snapshot = snapshot else {
                ERROR_LOG("Error retreving cities: \(error.debugDescription)")
                return
            }
            
            guard let lastSnapshot = snapshot.documents.last else {
                // The collection is empty.
                ERROR_LOG("lastSnapshot is null")
                return
            }
            
            // Construct a new query starting after this document,
            // retrieving the next 25 cities.
            let nextQuery:Query = self.db.collection("wines")
                .order(by: "koreanName")
                .start(afterDocument: lastSnapshot)
            
            // Use the query for pagination.
            if let err = error {
                ERROR_LOG("Error getting documents: \(err)")
            } else {
                do {
                    var resultList:[WineDataModel] = []
                    for document in snapshot.documents {
                        let data = try JSONSerialization.data(withJSONObject: document.data(), options: [.fragmentsAllowed])
                        let wineModel:WineDataModel = try JSONDecoder().decode(WineDataModel.self, from:data)
                        resultList.append(wineModel)

                    }
                    completedAction(resultList, nextQuery)
                    
                } catch (let error) {
                    ERROR_LOG("Error Decoder : \(error.localizedDescription)")
                }
            }
        }
        
    }
    
    
}
