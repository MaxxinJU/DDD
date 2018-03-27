//
//  DYZBTests.swift
//  DYZBTests
//
//  Created by maxine on 2018/1/19.
//  Copyright © 2018年 maxine. All rights reserved.
//

import XCTest
@testable import DYZB

class DYZBTests: XCTestCase {
    
    override func setUp() {
        
        super.setUp()
      
    }
    
    override func tearDown() {
    
        super.tearDown()
        
    }
    //测试网络请求
    func testGet() {
        //Given
        let expectation = self.expectation(description: "NETWORK IS TIMEOUT");
        //When
        NetworkTools.requestData(type: .get, urlString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom") { (result) in
            
            XCTAssertNotNil(result, "NOT NIL")
            expectation.fulfill()
        }
        //Then:延迟时间
        self.wait(for: [expectation], timeout: 5)
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
