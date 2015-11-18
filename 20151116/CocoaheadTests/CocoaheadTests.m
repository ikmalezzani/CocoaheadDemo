//
//  CocoaheadTests.m
//  CocoaheadTests
//
//  Created by Ikmal Ezzani on 11/13/15.
//  Copyright © 2015 Mindvalley. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSNumber+Math.h"

@interface CocoaheadTests : XCTestCase

@end

@implementation CocoaheadTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    NSNumber *one = @(1);
    NSNumber *two = @(2);
    NSNumber *four = @(4);

    XCTAssertTrue([two integerValue] == 2);
    XCTAssertTrue([[two multiply:two] integerValue] == 4);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
