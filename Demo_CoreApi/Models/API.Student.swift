//
//  Student.swift
//  Demo_CoreApi
//
//  Created by Khánh Vỹ Đinh on 14/06/2021.
//

import Foundation
extension APIManager.Student{
    struct QueryString {
        func allStudent() -> String {
            APIManager.Path.base_url+APIManager.Path.student_path+"/.json"
        }
    }
    struct QueryParam {
        func studentParam(student:Student) -> [String:Any] {
            return [:]
        }
    }
    struct StudentResult {
        var student:[Student]
    }
    static func getAllStudents(competion:@escaping APICompletion<StudentResult> ){
        let api=API.share()
        let url=QueryString.init().allStudent()
        api.request(urlString: url, completion: {
            apiResult in
            switch apiResult{
            case .failure(let err): competion(.failure(err))
            case .success(let data):
                guard let data=data else {
                    competion(.failure(.Error("Data is not found")))
                    return
                }
                if let arrjson = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [JSON]{
                    let students=arrjson.map({
                        json in Student(name: json["name"] as! String, age: json["age"] as! Int, imageUrl: json["image"] as! String)
                    })
                    competion(.success(StudentResult(student: students)))
                }
                else{
                    competion(.failure(.Error("Format Data error")))
                }
            }
        })
    }
}
