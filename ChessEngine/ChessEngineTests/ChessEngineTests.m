//
//  ChessEngineTests.m
//  ChessEngineTests
//
//  Created by Vladimir Deriglazov on 8/29/14.
//  Copyright (c) 2014 PMMedia. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "VDField.h"


@interface ChessEngineTests : XCTestCase

@end

@implementation ChessEngineTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testFieldLogic
{
	VDField field = VDFieldMake(0, 0);
	XCTAssert(field.row == 0 && field.column == 0, @"");
	XCTAssert(VDFieldColor(field) == VDColorBlack, @"");
	XCTAssertEqualObjects(NSStringFromField(field), @"a1", @"");
	
	NSArray *horizontal = HorizontalFieldsWithField(field);
	NSArray *trueAnswer = @[@"a1", @"b1", @"c1", @"d1", @"e1", @"f1", @"g1", @"h1"];
	XCTAssertEqualObjects(horizontal, trueAnswer, @"");
	
	NSArray *vertical = VerticalFieldsWithField(field);
	trueAnswer = @[@"a1", @"a2", @"a3", @"a4", @"a5", @"a6", @"a7", @"a8"];
	XCTAssertEqualObjects(vertical, trueAnswer, @"");
	
	NSArray *diagonal = DiagonalsFieldsWithField(field);
	trueAnswer = @[@"a1", @"b2", @"c3", @"d4", @"e5", @"f6", @"g7", @"h8"];
	XCTAssertEqualObjects(diagonal, trueAnswer, @"");
	
	NSArray *nearBy = NearbyFieldsToField(field);
	trueAnswer = @[@"a1", @"a2", @"b1", @"b2"];
	XCTAssertEqualObjects(nearBy, trueAnswer, @"");
	
	//------------------------------------------------------------------
	
	field = VDFieldMake(3, 3);
	XCTAssert(field.row == 3 && field.column == 3, @"");
	XCTAssert(VDFieldColor(field) == VDColorBlack, @"");
	XCTAssertEqualObjects(NSStringFromField(field), @"d4", @"");
	
	horizontal = HorizontalFieldsWithField(field);
	trueAnswer = @[@"a4", @"b4", @"c4", @"d4", @"e4", @"f4", @"g4", @"h4"];
	XCTAssertEqualObjects(horizontal, trueAnswer, @"");
	
	vertical = VerticalFieldsWithField(field);
	trueAnswer = @[@"d1", @"d2", @"d3", @"d4", @"d5", @"d6", @"d7", @"d8"];
	XCTAssertEqualObjects(vertical, trueAnswer, @"");
	
	diagonal = DiagonalsFieldsWithField(field);
	trueAnswer = @[@"a1", @"b2", @"c3", @"d4", @"e5", @"f6", @"g7", @"h8",
				   @"a7", @"b6", @"c5", @"e3", @"f2", @"g1"];
	XCTAssertEqualObjects(diagonal, trueAnswer, @"");
	
	nearBy = NearbyFieldsToField(field);
	trueAnswer = @[@"c3", @"c4", @"c5", @"d3", @"d4", @"d5", @"e3", @"e4", @"e5"];
	XCTAssertEqualObjects(nearBy, trueAnswer, @"");
	
	//------------------------------------------------------------------
	
	field = VDFieldMake(7, 4);
	XCTAssert(field.row == 7 && field.column == 4, @"");
	XCTAssert(VDFieldColor(field) == VDColorWhite, @"");
	XCTAssertEqualObjects(NSStringFromField(field), @"e8", @"");
	
	horizontal = HorizontalFieldsWithField(field);
	trueAnswer = @[@"a8", @"b8", @"c8", @"d8", @"e8", @"f8", @"g8", @"h8"];
	XCTAssertEqualObjects(horizontal, trueAnswer, @"");
	
	vertical = VerticalFieldsWithField(field);
	trueAnswer = @[@"e1", @"e2", @"e3", @"e4", @"e5", @"e6", @"e7", @"e8"];
	XCTAssertEqualObjects(vertical, trueAnswer, @"");
	
	diagonal = DiagonalsFieldsWithField(field);
	trueAnswer = @[@"a4", @"b5", @"c6", @"d7", @"e8",
				   @"f7", @"g6", @"h5"];
	XCTAssertEqualObjects(diagonal, trueAnswer, @"");
	
	nearBy = NearbyFieldsToField(field);
	trueAnswer = @[@"d7", @"d8", @"e7", @"e8", @"f7", @"f8"];
	XCTAssertEqualObjects(nearBy, trueAnswer, @"");
	
	//------------------------------------------------------------------
	
	field = VDFieldMake(2, 6);
	XCTAssert(field.row == 2 && field.column == 6, @"");
	XCTAssert(VDFieldColor(field) == VDColorBlack, @"");
	XCTAssertEqualObjects(NSStringFromField(field), @"g3", @"");
	
	horizontal = HorizontalFieldsWithField(field);
	trueAnswer = @[@"a3", @"b3", @"c3", @"d3", @"e3", @"f3", @"g3", @"h3"];
	XCTAssertEqualObjects(horizontal, trueAnswer, @"");
	
	vertical = VerticalFieldsWithField(field);
	trueAnswer = @[@"g1", @"g2", @"g3", @"g4", @"g5", @"g6", @"g7", @"g8"];
	XCTAssertEqualObjects(vertical, trueAnswer, @"");
	
	diagonal = DiagonalsFieldsWithField(field);
	trueAnswer = @[@"e1", @"f2", @"g3", @"h4",
				   @"b8", @"c7", @"d6", @"e5", @"f4", @"h2"];
	XCTAssertEqualObjects(diagonal, trueAnswer, @"");
	
	nearBy = NearbyFieldsToField(field);
	trueAnswer = @[@"f2", @"f3", @"f4", @"g2", @"g3", @"g4", @"h2", @"h3", @"h4"];
	XCTAssertEqualObjects(nearBy, trueAnswer, @"");
	
	//------------------------------------------------------------------
	
	field = VDFieldMake(0, 7);
	XCTAssert(field.row == 0 && field.column == 7, @"");
	XCTAssert(VDFieldColor(field) == VDColorWhite, @"");
	XCTAssertEqualObjects(NSStringFromField(field), @"h1", @"");
	
	horizontal = HorizontalFieldsWithField(field);
	trueAnswer = @[@"a1", @"b1", @"c1", @"d1", @"e1", @"f1", @"g1", @"h1"];
	XCTAssertEqualObjects(horizontal, trueAnswer, @"");
	
	vertical = VerticalFieldsWithField(field);
	trueAnswer = @[@"h1", @"h2", @"h3", @"h4", @"h5", @"h6", @"h7", @"h8"];
	XCTAssertEqualObjects(vertical, trueAnswer, @"");
	
	diagonal = DiagonalsFieldsWithField(field);
	trueAnswer = @[@"h1", @"a8", @"b7", @"c6", @"d5", @"e4", @"f3", @"g2"];
	XCTAssertEqualObjects(diagonal, trueAnswer, @"");
	
	nearBy = NearbyFieldsToField(field);
	trueAnswer = @[@"g1", @"g2", @"h1", @"h2"];
	XCTAssertEqualObjects(nearBy, trueAnswer, @"");
	
	//------------------------------------------------------------------
	
	field = VDFieldMake(5, 0);
	XCTAssert(field.row == 5 && field.column == 0, @"");
	XCTAssert(VDFieldColor(field) == VDColorWhite, @"");;
	XCTAssertEqualObjects(NSStringFromField(field), @"a6", @"");
	
	horizontal = HorizontalFieldsWithField(field);
	trueAnswer = @[@"a6", @"b6", @"c6", @"d6", @"e6", @"f6", @"g6", @"h6"];
	XCTAssertEqualObjects(horizontal, trueAnswer, @"");
	
	vertical = VerticalFieldsWithField(field);
	trueAnswer = @[@"a1", @"a2", @"a3", @"a4", @"a5", @"a6", @"a7", @"a8"];
	XCTAssertEqualObjects(vertical, trueAnswer, @"");
	
	diagonal = DiagonalsFieldsWithField(field);
	trueAnswer = @[@"a6", @"b7", @"c8",
				   @"b5", @"c4", @"d3", @"e2", @"f1"];
	XCTAssertEqualObjects(diagonal, trueAnswer, @"");
	
	nearBy = NearbyFieldsToField(field);
	trueAnswer = @[@"a5", @"a6", @"a7", @"b5", @"b6", @"b7"];
	XCTAssertEqualObjects(nearBy, trueAnswer, @"");
	
	//------------------------------------------------------------------
	
//	//c1,h5
//	
//	field = VDFieldMake(0, 7);
//	XCTAssert(field.row == 0 && field.column == 7, @"");
//	XCTAssert(VDFieldColor(field) == VDColorBlack, @"");
//	XCTAssertEqualObjects(NSStringFromField(field), @"h1", @"");
//	
//	horizontal = HorizontalFieldsWithField(field);
//	trueAnswer = @[@"a1", @"b1", @"c1", @"d1", @"e1", @"f1", @"g1", @"h1"];
//	XCTAssertEqualObjects(horizontal, trueAnswer, @"");
//	
//	vertical = VerticalFieldsWithField(field);
//	trueAnswer = @[@"h1", @"h2", @"h3", @"h4", @"h5", @"h6", @"h7", @"h8"];
//	XCTAssertEqualObjects(vertical, trueAnswer, @"");
//	
//	diagonal = DiagonalsFieldsWithField(field);
//	trueAnswer = @[@"h1", @"a8", @"b7", @"c6", @"d5", @"e4", @"f3", @"g2"];
//	XCTAssertEqualObjects(diagonal, trueAnswer, @"");
//	
//	nearBy = NearbyFieldsToField(field);
//	trueAnswer = @[@"g1", @"g2", @"h1", @"h2"];
//	XCTAssertEqualObjects(nearBy, trueAnswer, @"");
//	
//	//------------------------------------------------------------------
//	
//	field = VDFieldMake(0, 7);
//	XCTAssert(field.row == 0 && field.column == 7, @"");
//	XCTAssert(VDFieldColor(field) == VDColorBlack, @"");
//	XCTAssertEqualObjects(NSStringFromField(field), @"h1", @"");
//	
//	horizontal = HorizontalFieldsWithField(field);
//	trueAnswer = @[@"a1", @"b1", @"c1", @"d1", @"e1", @"f1", @"g1", @"h1"];
//	XCTAssertEqualObjects(horizontal, trueAnswer, @"");
//	
//	vertical = VerticalFieldsWithField(field);
//	trueAnswer = @[@"h1", @"h2", @"h3", @"h4", @"h5", @"h6", @"h7", @"h8"];
//	XCTAssertEqualObjects(vertical, trueAnswer, @"");
//	
//	diagonal = DiagonalsFieldsWithField(field);
//	trueAnswer = @[@"h1", @"a8", @"b7", @"c6", @"d5", @"e4", @"f3", @"g2"];
//	XCTAssertEqualObjects(diagonal, trueAnswer, @"");
//	
//	nearBy = NearbyFieldsToField(field);
//	trueAnswer = @[@"g1", @"g2", @"h1", @"h2"];
//	XCTAssertEqualObjects(nearBy, trueAnswer, @"");
//	
//	//------------------------------------------------------------------
}

- (void)testFigureLogic
{
	
}

- (void)testBoardLogic
{
	
}

- (void)testGameAndHistoryLogic
{
	
}

@end
