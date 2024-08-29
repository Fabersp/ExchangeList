//
//  URLProtocolMock.swift
//  ExchangeList
//
//  Created by Fabricio Padua on 8/29/24.
//

import Foundation

class URLProtocolMock: URLProtocol {
    static var testURLs = [URL?: Data]()
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        if let url = request.url, let data = URLProtocolMock.testURLs[url] {
            self.client?.urlProtocol(self, didReceive: HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!, cacheStoragePolicy: .notAllowed)
            self.client?.urlProtocol(self, didLoad: data)
        } else {
            let error = NSError(domain: "URLProtocolMock", code: 404, userInfo: nil)
            self.client?.urlProtocol(self, didFailWithError: error)
        }
        
        self.client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() {
        // Required method; does nothing in this mock.
    }
}
