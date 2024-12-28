//
//  BaseApi.swift
//  Enhancement
//
//  Created by Mahmoud Alaa on 03/12/2024.
//

import Foundation
import Alamofire
class BaseApi<T: TargetType> {
    
    func fetchData<M: Decodable>(target: T ,responseClass: M.Type, completion: @escaping (Result<M?,Error>) -> Void) {
        let method = Alamofire.HTTPMethod(rawValue: target.method.rawValue)
        let headers = Alamofire.HTTPHeaders(target.headers ?? [:])
        let params = buildParams(task: target.task)
        
        AF.request(target.baseURL + target.path, method: method, parameters: params.0, encoding: params.1, headers: headers).validate().responseDecodable(of: responseClass.self) { response in //
     
            let statusCode = response.response?.statusCode
            
            switch response.result {
                
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                let erorrDiscription = NSError(domain: target.baseURL, code: statusCode ?? 0, userInfo: [NSLocalizedDescriptionKey: error.localizedDescription])
                
                completion(.failure(erorrDiscription))
            }
        }
    }
    
    private func buildParams(task: Task) -> ([String : Any], ParameterEncoding) {
        switch task {
        case .requestPlain:
            return ([:], URLEncoding.default)
        case .requestParameters(Parameters: let parameters, encoding: let encoding):
            return (parameters, encoding)
        }
    }
}
 
