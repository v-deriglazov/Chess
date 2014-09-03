//
//  ChessEngineTests.m
//  ChessEngineTests
//
//  Created by Vladimir Deriglazov on 8/29/14.
//  Copyright (c) 2014 PMMedia. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "VDField.h"

#import "VDKing.h"
#import "VDQueen.h"
#import "VDRook.h"
#import "VDBishop.h"
#import "VDKnight.h"
#import "VDPawn.h"

#import "VDBoard.h"

#import "VDGame.h"

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
	
	NSArray *horizontal = HorizontalFieldsWithField(field, YES);
	NSArray *trueAnswer = @[@"a1", @"b1", @"c1", @"d1", @"e1", @"f1", @"g1", @"h1"];
	XCTAssertEqualObjects(horizontal, trueAnswer, @"");
	
	horizontal = HorizontalFieldsWithField(field, NO);
	trueAnswer = @[@"b1", @"c1", @"d1", @"e1", @"f1", @"g1", @"h1"];
	XCTAssertEqualObjects(horizontal, trueAnswer, @"");
	
	NSArray *vertical = VerticalFieldsWithField(field, YES);
	trueAnswer = @[@"a1", @"a2", @"a3", @"a4", @"a5", @"a6", @"a7", @"a8"];
	XCTAssertEqualObjects(vertical, trueAnswer, @"");
	
	vertical = VerticalFieldsWithField(field, NO);
	trueAnswer = @[@"a2", @"a3", @"a4", @"a5", @"a6", @"a7", @"a8"];
	XCTAssertEqualObjects(vertical, trueAnswer, @"");
	
	NSArray *diagonal = DiagonalsFieldsWithField(field, YES);
	trueAnswer = @[@"a1", @"b2", @"c3", @"d4", @"e5", @"f6", @"g7", @"h8"];
	XCTAssertEqualObjects(diagonal, trueAnswer, @"");
	
	diagonal = DiagonalsFieldsWithField(field, NO);
	trueAnswer = @[@"b2", @"c3", @"d4", @"e5", @"f6", @"g7", @"h8"];
	XCTAssertEqualObjects(diagonal, trueAnswer, @"");
	
	NSArray *nearBy = NearbyFieldsToField(field, YES);
	trueAnswer = @[@"a1", @"a2", @"b1", @"b2"];
	XCTAssertEqualObjects(nearBy, trueAnswer, @"");
	
	nearBy = NearbyFieldsToField(field, NO);
	trueAnswer = @[@"a2", @"b1", @"b2"];
	XCTAssertEqualObjects(nearBy, trueAnswer, @"");
	
	//------------------------------------------------------------------
	
	field = VDFieldMake(3, 3);
	XCTAssert(field.row == 3 && field.column == 3, @"");
	XCTAssert(VDFieldColor(field) == VDColorBlack, @"");
	XCTAssertEqualObjects(NSStringFromField(field), @"d4", @"");
	
	horizontal = HorizontalFieldsWithField(field, YES);
	trueAnswer = @[@"a4", @"b4", @"c4", @"d4", @"e4", @"f4", @"g4", @"h4"];
	XCTAssertEqualObjects(horizontal, trueAnswer, @"");
	
	horizontal = HorizontalFieldsWithField(field, NO);
	trueAnswer = @[@"a4", @"b4", @"c4", @"e4", @"f4", @"g4", @"h4"];
	XCTAssertEqualObjects(horizontal, trueAnswer, @"");
	
	vertical = VerticalFieldsWithField(field, YES);
	trueAnswer = @[@"d1", @"d2", @"d3", @"d4", @"d5", @"d6", @"d7", @"d8"];
	XCTAssertEqualObjects(vertical, trueAnswer, @"");
	
	vertical = VerticalFieldsWithField(field, NO);
	trueAnswer = @[@"d1", @"d2", @"d3", @"d5", @"d6", @"d7", @"d8"];
	XCTAssertEqualObjects(vertical, trueAnswer, @"");
	
	diagonal = DiagonalsFieldsWithField(field, YES);
	trueAnswer = @[@"a1", @"b2", @"c3", @"d4", @"e5", @"f6", @"g7", @"h8",
				   @"a7", @"b6", @"c5", @"e3", @"f2", @"g1"];
	XCTAssertEqualObjects(diagonal, trueAnswer, @"");
	
	diagonal = DiagonalsFieldsWithField(field, NO);
	trueAnswer = @[@"a1", @"b2", @"c3", @"e5", @"f6", @"g7", @"h8",
				   @"a7", @"b6", @"c5", @"e3", @"f2", @"g1"];
	XCTAssertEqualObjects(diagonal, trueAnswer, @"");
	
	nearBy = NearbyFieldsToField(field, YES);
	trueAnswer = @[@"c3", @"c4", @"c5", @"d3", @"d4", @"d5", @"e3", @"e4", @"e5"];
	XCTAssertEqualObjects(nearBy, trueAnswer, @"");
	
	nearBy = NearbyFieldsToField(field, NO);
	trueAnswer = @[@"c3", @"c4", @"c5", @"d3", @"d5", @"e3", @"e4", @"e5"];
	XCTAssertEqualObjects(nearBy, trueAnswer, @"");
	
	//------------------------------------------------------------------
	
	field = VDFieldMake(7, 4);
	XCTAssert(field.row == 7 && field.column == 4, @"");
	XCTAssert(VDFieldColor(field) == VDColorWhite, @"");
	XCTAssertEqualObjects(NSStringFromField(field), @"e8", @"");
	
	horizontal = HorizontalFieldsWithField(field, YES);
	trueAnswer = @[@"a8", @"b8", @"c8", @"d8", @"e8", @"f8", @"g8", @"h8"];
	XCTAssertEqualObjects(horizontal, trueAnswer, @"");
	
	horizontal = HorizontalFieldsWithField(field, NO);
	trueAnswer = @[@"a8", @"b8", @"c8", @"d8", @"f8", @"g8", @"h8"];
	XCTAssertEqualObjects(horizontal, trueAnswer, @"");
	
	vertical = VerticalFieldsWithField(field, YES);
	trueAnswer = @[@"e1", @"e2", @"e3", @"e4", @"e5", @"e6", @"e7", @"e8"];
	XCTAssertEqualObjects(vertical, trueAnswer, @"");
	
	vertical = VerticalFieldsWithField(field, NO);
	trueAnswer = @[@"e1", @"e2", @"e3", @"e4", @"e5", @"e6", @"e7"];
	XCTAssertEqualObjects(vertical, trueAnswer, @"");
	
	diagonal = DiagonalsFieldsWithField(field, YES);
	trueAnswer = @[@"a4", @"b5", @"c6", @"d7", @"e8",
				   @"f7", @"g6", @"h5"];
	XCTAssertEqualObjects(diagonal, trueAnswer, @"");
	
	diagonal = DiagonalsFieldsWithField(field, NO);
	trueAnswer = @[@"a4", @"b5", @"c6", @"d7",
				   @"f7", @"g6", @"h5"];
	XCTAssertEqualObjects(diagonal, trueAnswer, @"");
	
	nearBy = NearbyFieldsToField(field, YES);
	trueAnswer = @[@"d7", @"d8", @"e7", @"e8", @"f7", @"f8"];
	XCTAssertEqualObjects(nearBy, trueAnswer, @"");
	
	nearBy = NearbyFieldsToField(field, NO);
	trueAnswer = @[@"d7", @"d8", @"e7", @"f7", @"f8"];
	XCTAssertEqualObjects(nearBy, trueAnswer, @"");
	
	//------------------------------------------------------------------
	
	field = VDFieldMake(2, 6);
	XCTAssert(field.row == 2 && field.column == 6, @"");
	XCTAssert(VDFieldColor(field) == VDColorBlack, @"");
	XCTAssertEqualObjects(NSStringFromField(field), @"g3", @"");
	
	horizontal = HorizontalFieldsWithField(field, YES);
	trueAnswer = @[@"a3", @"b3", @"c3", @"d3", @"e3", @"f3", @"g3", @"h3"];
	XCTAssertEqualObjects(horizontal, trueAnswer, @"");
	
	horizontal = HorizontalFieldsWithField(field, NO);
	trueAnswer = @[@"a3", @"b3", @"c3", @"d3", @"e3", @"f3", @"h3"];
	XCTAssertEqualObjects(horizontal, trueAnswer, @"");
	
	vertical = VerticalFieldsWithField(field, YES);
	trueAnswer = @[@"g1", @"g2", @"g3", @"g4", @"g5", @"g6", @"g7", @"g8"];
	XCTAssertEqualObjects(vertical, trueAnswer, @"");
	
	vertical = VerticalFieldsWithField(field, NO);
	trueAnswer = @[@"g1", @"g2", @"g4", @"g5", @"g6", @"g7", @"g8"];
	XCTAssertEqualObjects(vertical, trueAnswer, @"");
	
	diagonal = DiagonalsFieldsWithField(field, YES);
	trueAnswer = @[@"e1", @"f2", @"g3", @"h4",
				   @"b8", @"c7", @"d6", @"e5", @"f4", @"h2"];
	XCTAssertEqualObjects(diagonal, trueAnswer, @"");
	
	diagonal = DiagonalsFieldsWithField(field, NO);
	trueAnswer = @[@"e1", @"f2", @"h4",
				   @"b8", @"c7", @"d6", @"e5", @"f4", @"h2"];
	XCTAssertEqualObjects(diagonal, trueAnswer, @"");
	
	nearBy = NearbyFieldsToField(field, YES);
	trueAnswer = @[@"f2", @"f3", @"f4", @"g2", @"g3", @"g4", @"h2", @"h3", @"h4"];
	XCTAssertEqualObjects(nearBy, trueAnswer, @"");
	
	nearBy = NearbyFieldsToField(field, NO);
	trueAnswer = @[@"f2", @"f3", @"f4", @"g2", @"g4", @"h2", @"h3", @"h4"];
	XCTAssertEqualObjects(nearBy, trueAnswer, @"");
	
	//------------------------------------------------------------------
	
	field = VDFieldMake(0, 7);
	XCTAssert(field.row == 0 && field.column == 7, @"");
	XCTAssert(VDFieldColor(field) == VDColorWhite, @"");
	XCTAssertEqualObjects(NSStringFromField(field), @"h1", @"");
	
	horizontal = HorizontalFieldsWithField(field, YES);
	trueAnswer = @[@"a1", @"b1", @"c1", @"d1", @"e1", @"f1", @"g1", @"h1"];
	XCTAssertEqualObjects(horizontal, trueAnswer, @"");
	
	horizontal = HorizontalFieldsWithField(field, NO);
	trueAnswer = @[@"a1", @"b1", @"c1", @"d1", @"e1", @"f1", @"g1"];
	XCTAssertEqualObjects(horizontal, trueAnswer, @"");
	
	vertical = VerticalFieldsWithField(field, YES);
	trueAnswer = @[@"h1", @"h2", @"h3", @"h4", @"h5", @"h6", @"h7", @"h8"];
	XCTAssertEqualObjects(vertical, trueAnswer, @"");
	
	vertical = VerticalFieldsWithField(field, NO);
	trueAnswer = @[@"h2", @"h3", @"h4", @"h5", @"h6", @"h7", @"h8"];
	XCTAssertEqualObjects(vertical, trueAnswer, @"");
	
	diagonal = DiagonalsFieldsWithField(field, YES);
	trueAnswer = @[@"h1", @"a8", @"b7", @"c6", @"d5", @"e4", @"f3", @"g2"];
	XCTAssertEqualObjects(diagonal, trueAnswer, @"");
	
	diagonal = DiagonalsFieldsWithField(field, NO);
	trueAnswer = @[@"a8", @"b7", @"c6", @"d5", @"e4", @"f3", @"g2"];
	XCTAssertEqualObjects(diagonal, trueAnswer, @"");
	
	nearBy = NearbyFieldsToField(field, YES);
	trueAnswer = @[@"g1", @"g2", @"h1", @"h2"];
	XCTAssertEqualObjects(nearBy, trueAnswer, @"");
	
	nearBy = NearbyFieldsToField(field, NO);
	trueAnswer = @[@"g1", @"g2", @"h2"];
	XCTAssertEqualObjects(nearBy, trueAnswer, @"");
	
	//------------------------------------------------------------------
	
	field = VDFieldMake(5, 0);
	XCTAssert(field.row == 5 && field.column == 0, @"");
	XCTAssert(VDFieldColor(field) == VDColorWhite, @"");;
	XCTAssertEqualObjects(NSStringFromField(field), @"a6", @"");
	
	horizontal = HorizontalFieldsWithField(field, YES);
	trueAnswer = @[@"a6", @"b6", @"c6", @"d6", @"e6", @"f6", @"g6", @"h6"];
	XCTAssertEqualObjects(horizontal, trueAnswer, @"");
	
	horizontal = HorizontalFieldsWithField(field, NO);
	trueAnswer = @[@"b6", @"c6", @"d6", @"e6", @"f6", @"g6", @"h6"];
	XCTAssertEqualObjects(horizontal, trueAnswer, @"");
	
	vertical = VerticalFieldsWithField(field, YES);
	trueAnswer = @[@"a1", @"a2", @"a3", @"a4", @"a5", @"a6", @"a7", @"a8"];
	XCTAssertEqualObjects(vertical, trueAnswer, @"");
	
	vertical = VerticalFieldsWithField(field, NO);
	trueAnswer = @[@"a1", @"a2", @"a3", @"a4", @"a5", @"a7", @"a8"];
	XCTAssertEqualObjects(vertical, trueAnswer, @"");
	
	diagonal = DiagonalsFieldsWithField(field, YES);
	trueAnswer = @[@"a6", @"b7", @"c8",
				   @"b5", @"c4", @"d3", @"e2", @"f1"];
	XCTAssertEqualObjects(diagonal, trueAnswer, @"");
	
	diagonal = DiagonalsFieldsWithField(field, NO);
	trueAnswer = @[@"b7", @"c8",
				   @"b5", @"c4", @"d3", @"e2", @"f1"];
	XCTAssertEqualObjects(diagonal, trueAnswer, @"");
	
	nearBy = NearbyFieldsToField(field, YES);
	trueAnswer = @[@"a5", @"a6", @"a7", @"b5", @"b6", @"b7"];
	XCTAssertEqualObjects(nearBy, trueAnswer, @"");
	
	nearBy = NearbyFieldsToField(field, NO);
	trueAnswer = @[@"a5", @"a7", @"b5", @"b6", @"b7"];
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
	NSSet *moves = nil;
	NSSet *trueMoves = nil;
	VDFigure *fig = nil;
	
	fig = [[VDKing alloc] initOnField:VDFieldFromString(@"e1") color:VDColorWhite isMoved:NO];
	XCTAssert(fig.type == VDFigureTypeKing, @"Incorrect figure type");
	XCTAssert([fig.letter isEqualToString:@"K"], @"Incorrect letter of figure");
	XCTAssertFalse(fig.moved, @"Incorrect moved bool");
	XCTAssert(fig.color == VDColorWhite, @"Incorrect figure color");
	moves = [fig possibleMoves];
	trueMoves = [NSSet setWithArray:@[@"d1", @"d2", @"e2", @"f1", @"f2"]];
	XCTAssert([moves isEqualToSet:trueMoves], @"Possible moves check");
	
	fig.field = VDFieldFromString(@"g3");
	XCTAssertTrue(fig.moved, @"Incorrect moved bool");
	XCTAssert(VDFieldsAreEqual(fig.field, VDFieldMake(2, 6)), @"Incorrect field");
	moves = [fig possibleMoves];
	trueMoves = [NSSet setWithArray:@[@"f2", @"f3", @"f4", @"g2", @"g4", @"h2", @"h3", @"h4"]];
	XCTAssert([moves isEqualToSet:trueMoves], @"Possible moves check");
	
	//------------------------------------------------------------------
	
	fig = [[VDQueen alloc] initOnField:VDFieldFromString(@"d1") color:VDColorWhite isMoved:NO];
	XCTAssert(fig.type == VDFigureTypeQueen, @"Incorrect figure type");
	XCTAssert([fig.letter isEqualToString:@"Q"], @"Incorrect letter of figure");
	XCTAssertFalse(fig.moved, @"Incorrect moved bool");
	XCTAssert(fig.color == VDColorWhite, @"Incorrect figure color");
	moves = [fig possibleMoves];
	trueMoves = [NSSet setWithArray:@[@"a1", @"b1", @"c1", @"e1", @"f1", @"g1", @"h1", @"c2", @"b3", @"a4",
									  @"e2", @"f3", @"g4", @"h5", @"d2", @"d3", @"d4", @"d5", @"d6", @"d7", @"d8"]];
	XCTAssert([moves isEqualToSet:trueMoves], @"Possible moves check");
	
	fig.field = VDFieldFromString(@"b7");
	XCTAssertTrue(fig.moved, @"Incorrect moved bool");
	XCTAssert(VDFieldsAreEqual(fig.field, VDFieldMake(6, 1)), @"Incorrect field");
	moves = [fig possibleMoves];
	trueMoves = [NSSet setWithArray:@[@"b1", @"b2", @"b3", @"b4", @"b5", @"b6", @"b8",
									  @"a7", @"c7", @"d7", @"e7", @"f7", @"g7", @"h7",
									  @"a6", @"a8", @"c8", @"c6", @"d5", @"e4", @"f3", @"g2", @"h1"]];
	XCTAssert([moves isEqualToSet:trueMoves], @"Possible moves check");
	
	//------------------------------------------------------------------
	
	fig = [[VDRook alloc] initOnField:VDFieldFromString(@"a8") color:VDColorBlack isMoved:NO];
	XCTAssert(fig.type == VDFigureTypeRook, @"Incorrect figure type");
	XCTAssert([fig.letter isEqualToString:@"R"], @"Incorrect letter of figure");
	XCTAssertFalse(fig.moved, @"Incorrect moved bool");
	XCTAssert(fig.color == VDColorBlack, @"Incorrect figure color");
	moves = [fig possibleMoves];
	trueMoves = [NSSet setWithArray:@[@"a1", @"a2", @"a3", @"a4", @"a5", @"a6", @"a7",
									  @"b8", @"c8", @"d8", @"e8", @"f8", @"g8", @"h8"]];
	XCTAssert([moves isEqualToSet:trueMoves], @"Possible moves check");
	
	fig.field = VDFieldFromString(@"f7");
	XCTAssertTrue(fig.moved, @"Incorrect moved bool");
	XCTAssert(VDFieldsAreEqual(fig.field, VDFieldMake(6, 5)), @"Incorrect field");
	moves = [fig possibleMoves];
	trueMoves = [NSSet setWithArray:@[@"a7", @"b7", @"c7", @"d7", @"e7", @"g7", @"h7",
									  @"f1", @"f2", @"f3", @"f4", @"f5", @"f6", @"f8"]];
	XCTAssert([moves isEqualToSet:trueMoves], @"Possible moves check");
	
	//------------------------------------------------------------------
	
	fig = [[VDBishop alloc] initOnField:VDFieldFromString(@"f8") color:VDColorBlack isMoved:NO];
	XCTAssert(fig.type == VDFigureTypeBishop, @"Incorrect figure type");
	XCTAssert([fig.letter isEqualToString:@"B"], @"Incorrect letter of figure");
	XCTAssertFalse(fig.moved, @"Incorrect moved bool");
	XCTAssert(fig.color == VDColorBlack, @"Incorrect figure color");
	moves = [fig possibleMoves];
	trueMoves = [NSSet setWithArray:@[@"e7", @"d6", @"c5", @"b4", @"a3", @"g7", @"h6"]];
	XCTAssert([moves isEqualToSet:trueMoves], @"Possible moves check");
	
	fig.field = VDFieldFromString(@"d3");
	XCTAssertTrue(fig.moved, @"Incorrect moved bool");
	XCTAssert(VDFieldsAreEqual(fig.field, VDFieldMake(2, 3)), @"Incorrect field");
	moves = [fig possibleMoves];
	trueMoves = [NSSet setWithArray:@[@"c2", @"b1", @"e4", @"f5", @"g6", @"h7", @"c4", @"b5", @"a6", @"e2", @"f1"]];
	XCTAssert([moves isEqualToSet:trueMoves], @"Possible moves check");
	
	//------------------------------------------------------------------
	
	fig = [[VDKnight alloc] initOnField:VDFieldFromString(@"b1") color:VDColorWhite isMoved:NO];
	XCTAssert(fig.type == VDFigureTypeKnight, @"Incorrect figure type");
	XCTAssert([fig.letter isEqualToString:@"N"], @"");
	XCTAssertFalse(fig.moved, @"Incorrect moved bool");
	XCTAssert(fig.color == VDColorWhite, @"Incorrect figure color");
	moves = [fig possibleMoves];
	trueMoves = [NSSet setWithArray:@[@"a3", @"c3", @"d2"]];
	XCTAssert([moves isEqualToSet:trueMoves], @"Possible moves check");
	
	fig.field = VDFieldFromString(@"c4");
	XCTAssertTrue(fig.moved, @"Incorrect moved bool");
	XCTAssert(VDFieldsAreEqual(fig.field, VDFieldMake(3, 2)), @"Incorrect field");
	moves = [fig possibleMoves];
	trueMoves = [NSSet setWithArray:@[@"a3", @"a5", @"b2", @"b6", @"d2", @"d6", @"e3", @"e5"]];
	XCTAssert([moves isEqualToSet:trueMoves], @"Possible moves check");
	
	fig.field = VDFieldFromString(@"g5");
	XCTAssertTrue(fig.moved, @"Incorrect moved bool");
	XCTAssert(VDFieldsAreEqual(fig.field, VDFieldMake(4, 6)), @"Incorrect field");
	moves = [fig possibleMoves];
	trueMoves = [NSSet setWithArray:@[@"e4", @"e6", @"f3", @"f7", @"h3", @"h7"]];
	XCTAssert([moves isEqualToSet:trueMoves], @"Possible moves check");
	
	//------------------------------------------------------------------
	
	fig = [[VDPawn alloc] initOnField:VDFieldFromString(@"b2") color:VDColorWhite isMoved:NO];
	XCTAssert(fig.type == VDFigureTypePawn, @"Incorrect figure type");
	XCTAssert([fig.letter isEqualToString:@"p"], @"Incorrect letter of figure");
	XCTAssertFalse(fig.moved, @"Incorrect moved bool");
	XCTAssert(fig.color == VDColorWhite, @"Incorrect figure color");
	moves = [fig possibleMoves];
	trueMoves = [NSSet setWithArray:@[@"b3", @"b4"]];
	XCTAssert([moves isEqualToSet:trueMoves], @"Possible moves check");
	
	fig.field = VDFieldFromString(@"g5");
	XCTAssertTrue(fig.moved, @"Incorrect moved bool");
	XCTAssert(VDFieldsAreEqual(fig.field, VDFieldMake(4, 6)), @"Incorrect field");
	moves = [fig possibleMoves];
	trueMoves = [NSSet setWithArray:@[@"g6"]];
	XCTAssert([moves isEqualToSet:trueMoves], @"Possible moves check");
	
	//------------------------------------------------------------------
	
	fig = [[VDPawn alloc] initOnField:VDFieldFromString(@"d7") color:VDColorBlack isMoved:NO];
	XCTAssert(fig.type == VDFigureTypePawn, @"Incorrect figure type");
	XCTAssert([fig.letter isEqualToString:@"p"], @"Incorrect letter of figure");
	XCTAssertFalse(fig.moved, @"Incorrect moved bool");
	XCTAssert(fig.color == VDColorBlack, @"Incorrect figure color");
	moves = [fig possibleMoves];
	trueMoves = [NSSet setWithArray:@[@"d6", @"d5"]];
	XCTAssert([moves isEqualToSet:trueMoves], @"Possible moves check");
	
	fig.field = VDFieldFromString(@"f3");
	XCTAssertTrue(fig.moved, @"Incorrect moved bool");
	XCTAssert(VDFieldsAreEqual(fig.field, VDFieldMake(2, 5)), @"Incorrect field");
	moves = [fig possibleMoves];
	trueMoves = [NSSet setWithArray:@[@"f2"]];
	XCTAssert([moves isEqualToSet:trueMoves], @"Possible moves check");
	
	//------------------------------------------------------------------
}

- (void)testBoardLogic
{
	VDBoard *board = [[VDBoard alloc] initNewGame];
	XCTAssert(board.whiteFigures.count == 16, @"Incorrect white figures count");
	XCTAssert(board.blackFigures.count == 16, @"Incorrect black figures count");

	VDFigure *fig = nil;
	
	fig = [board figureOnField:VDFieldFromString(@"a2")];
	XCTAssert(fig.type == VDFigureTypePawn, @"Incorrect figure type");
	XCTAssert(fig.color == VDColorWhite, @"Incorrect figure color");
	
	fig = [board figureOnField:VDFieldFromString(@"d2")];
	XCTAssert(fig.type == VDFigureTypePawn, @"Incorrect figure type");
	XCTAssert(fig.color == VDColorWhite, @"Incorrect figure color");
	
	fig = [board figureOnField:VDFieldFromString(@"f2")];
	XCTAssert(fig.type == VDFigureTypePawn, @"Incorrect figure type");
	XCTAssert(fig.color == VDColorWhite, @"Incorrect figure color");
	
	fig = [board figureOnField:VDFieldFromString(@"h2")];
	XCTAssert(fig.type == VDFigureTypePawn, @"Incorrect figure type");
	XCTAssert(fig.color == VDColorWhite, @"Incorrect figure color");
	
	fig = [board figureOnField:VDFieldFromString(@"a1")];
	XCTAssert(fig.type == VDFigureTypeRook, @"Incorrect figure type");
	XCTAssert(fig.color == VDColorWhite, @"Incorrect figure color");
	
	fig = [board figureOnField:VDFieldFromString(@"c1")];
	XCTAssert(fig.type == VDFigureTypeBishop, @"Incorrect figure type");
	XCTAssert(fig.color == VDColorWhite, @"Incorrect figure color");
	
	fig = [board figureOnField:VDFieldFromString(@"f1")];
	XCTAssert(fig.type == VDFigureTypeBishop, @"Incorrect figure type");
	XCTAssert(fig.color == VDColorWhite, @"Incorrect figure color");
	
	fig = [board figureOnField:VDFieldFromString(@"g1")];
	XCTAssert(fig.type == VDFigureTypeKnight, @"Incorrect figure type");
	XCTAssert(fig.color == VDColorWhite, @"Incorrect figure color");
	
	fig = [board figureOnField:VDFieldFromString(@"b7")];
	XCTAssert(fig.type == VDFigureTypePawn, @"Incorrect figure type");
	XCTAssert(fig.color == VDColorBlack, @"Incorrect figure color");
	
	fig = [board figureOnField:VDFieldFromString(@"d7")];
	XCTAssert(fig.type == VDFigureTypePawn, @"Incorrect figure type");
	XCTAssert(fig.color == VDColorBlack, @"Incorrect figure color");
	
	fig = [board figureOnField:VDFieldFromString(@"d8")];
	XCTAssert(fig.type == VDFigureTypeQueen, @"Incorrect figure type");
	XCTAssert(fig.color == VDColorBlack, @"Incorrect figure color");
	
	fig = [board figureOnField:VDFieldFromString(@"h8")];
	XCTAssert(fig.type == VDFigureTypeRook, @"Incorrect figure type");
	XCTAssert(fig.color == VDColorBlack, @"Incorrect figure color");
	
	XCTAssert(board.moveOrder == VDColorWhite, @"Incorrect move order");
	
	fig = [board kingForColor:VDColorWhite];
	XCTAssert(fig.type == VDFigureTypeKing, @"Incorrect king");
	XCTAssert(fig.color == VDColorWhite, @"Incorrect figure color");
	XCTAssert(VDFieldsAreEqual(fig.field, VDFieldFromString(@"e1")), @"Incorrect king position");
	
	fig = [board kingForColor:VDColorBlack];
	XCTAssert(fig.type == VDFigureTypeKing, @"Incorrect king");
	XCTAssert(fig.color == VDColorBlack, @"Incorrect figure color");
	XCTAssert(VDFieldsAreEqual(fig.field, VDFieldFromString(@"e8")), @"Incorrect king position");
	
	
	
	
	
}

- (void)testGameAndHistoryLogic
{
	
}

@end
