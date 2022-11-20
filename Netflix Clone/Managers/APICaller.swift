//
//  AOICaller.swift
//  Netflix Clone
//
//  Created by Ahmed Salem on 18/11/2022.
//

import Foundation
 

struct Constants{
    static let API_KEY = "ea487dcf7972dedc93f01ffbd321dc99"
    static let baseURL = "https://api.themoviedb.org"
    static let YoutubeAPI_Key = "AIzaSyDqX8axTGeNpXRiISTGL7Tya7fjKJDYi4g"
    static let YoutubeBaseURL = "https://youtube.googleapis.com/youtube/v3/search?"
}

enum APIError: Error
{
    case failedToGetData
}

class APICaller
{
    static let shared = APICaller()
    
    func getTrendingMovies(completion: @escaping (Result<[Title],Error>) -> Void)
    {
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/movie/day?api_key=\(Constants.API_KEY)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){
            data, _ , error in
            
            guard let data = data , error  == nil else{
                return
            }
            
            do{
//                let results =  try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                let results =  try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
//                print(results.results[0].original_name)
            }catch{
                completion(.failure(APIError.failedToGetData))
//                print(error.localizedDescription)
            }
            
            
        }
        
        task.resume()
        
        
        
        
    }
    
    func getTrendingTvs(completion: @escaping (Result<[Title], Error>)-> Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/tv/day?api_key=\(Constants.API_KEY)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){
            data, _ , error in
            
            guard let data = data , error  == nil else{
                return
            }
            
            do{
                let results =  try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
//                let results =  try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
//                print(results)
            }catch{
                completion(.failure(APIError.failedToGetData))
//                print(error.localizedDescription)
            }
            
            
        }
        task.resume()
    }
    
    
    func getUpcomingMovies(completion: @escaping (Result<[Title], Error>)-> Void)
    {
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/upcoming?api_key=\(Constants.API_KEY)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){
            data, _ , error in
            
            guard let data = data , error  == nil else{
                return
            }
            
            do{
                let results =  try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
//                let results =  try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
//                print(results)
            }catch{
                completion(.failure(APIError.failedToGetData))

//                print(error.localizedDescription)
            }
            
            
        }
        task.resume()
    }
    
    
    func getPopularMovies(completion: @escaping (Result<[Title], Error>)-> Void)
    {
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/popular?api_key=\(Constants.API_KEY)&language=en-US&page=1") else { return }
        
     
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){
            data, _ , error in
            
            guard let data = data , error  == nil else{
                return
            }
            
            do{
                let results =  try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
//                let results =  try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
//                print(results)
            }catch{
                completion(.failure(APIError.failedToGetData))
//                print(error.localizedDescription)
            }
            
            
        }
        task.resume()
    }
    
    
    func getTopRated(completion: @escaping (Result<[Title], Error>)-> Void)
    {
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/top_rated?api_key=\(Constants.API_KEY)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){
            data, _ , error in
            
            guard let data = data , error  == nil else{
                return
            }
            
            do{
                let results =  try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
//                let results =  try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
//                print(results)
            }catch{
                completion(.failure(APIError.failedToGetData))
//                print(error.localizedDescription)
            }
            
            
        }
        task.resume()
    }
    
    func getDiscoverMovies(completion: @escaping (Result<[Title], Error>)-> Void)
    {
    
        guard let url = URL(string: "\(Constants.baseURL)/3/discover/movie?api_key=\(Constants.API_KEY)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate") else { return }
        
  
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){
            data, _ , error in
            
            guard let data = data , error  == nil else{
                return
            }
            
            do{
                let results =  try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
//                let results =  try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
//                print(results)
            }catch{
                completion(.failure(APIError.failedToGetData))
//                print(error.localizedDescription)
            }
            
            
        }
        task.resume()
    }
    
    func MovieSearch(with query:String ,completion: @escaping (Result<[Title], Error>)-> Void)
    {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else{
            return
        }
    
        guard let url = URL(string: "\(Constants.baseURL)/3/search/movie?api_key=\(Constants.API_KEY)&query=\(query)") else { return }
        
  
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){
            data, _ , error in
            
            guard let data = data , error  == nil else{
                return
            }
            
            do{
                let results =  try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
//                let results =  try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
//                print(results)
            }catch{
                completion(.failure(APIError.failedToGetData))
//                print(error.localizedDescription)
            }
            
            
        }
        task.resume()
    }
    
    func getMovie(with query: String, completion: @escaping (Result<VideoElement, Error>)-> Void)
    {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else{
            return
        }
        guard let url = URL(string: "\(Constants.YoutubeBaseURL)q=\(query)&key=\(Constants.YoutubeAPI_Key)") else{
            return
        }
        
        print(url)
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){
            data, _ , error in
            
            guard let data = data , error  == nil else{
                return
            }
            
            do{
                let results =  try JSONDecoder().decode(YoutubeSearchResponse.self, from: data)
                completion(.success(results.items[0]))
//                let results =  try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                print(results.items[0])
            }catch{
                completion(.failure(error))
                print(error.localizedDescription)
            }
            
            
        }
        task.resume()
    }
}
