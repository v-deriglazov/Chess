//
//  VDMove.m
//  ChessEngine
//
//  Created by Vladimir Deriglazov on 9/3/14.
//  Copyright (c) 2014 PMMedia. All rights reserved.
//

#import "VDMove.h"

#import "VDFigure.h"
#import "VDBoard.h"

/*
 @class VDBoard, VDFigure;
 
 @interface VDMove : NSObject
 
 + (id)moveOnBoard:(VDBoard *)board figure:(VDFigure *)figure toField:(VDField)field;
 + (id)castleOnBoard:(VDBoard *)board;
 + (id)longCastleOnBoard:(VDBoard *)board;
 
 @property (nonatomic, weak) VDBoard *board;
 @property (nonatomic, weak) VDFigure *figure;
 @property (nonatomic) VDField from;
 @property (nonatomic) VDField to;
 @property (nonatomic, strong) VDFigure *killedFigure; // enemy figure or pawn on the 8/1 row
 
 @property (nonatomic) BOOL castle;
 @property (nonatomic) BOOL longCastle;
 
 @property (nonatomic, weak) VDFigure *appearedFigure; // after move pawn on the 8/1 row
 
 @property (nonatomic) BOOL check;
 @property (nonatomic) BOOL checkMate;
 
 */

@implementation VDMove

+ (id)moveOnBoard:(VDBoard *)board figure:(VDFigure *)figure toField:(VDField)field
{
	VDMove *move = [VDMove new];
	
	move.board = board;
	move.figure = figure;
	move.from = figure.field;
	move.to = field;
	move.figWasMoved = figure.moved;
	
	VDFigure *killedFig = [board figureOnField:field];
	move.killedFigure = killedFig;
	
	//TODO: handle pawn on 8/1 row
	
//	move.appearedFigure
	
	return move;
}

+ (id)castleOnBoard:(VDBoard *)board
{
	VDMove *move = [VDMove new];
	
	VDFigure *king = (VDFigure *)[board kingForColor:board.moveOrder];
	move.board = board;
	move.figure = king;
	move.from = king.field;
	move.to = VDFieldFromString(board.moveOrder == VDColorWhite ? @"g1" :  @"g8");
	move.castle = YES;
	
	return move;
}

+ (id)longCastleOnBoard:(VDBoard *)board
{
	VDMove *move = [VDMove new];
	
	VDFigure *king = (VDFigure *)[board kingForColor:board.moveOrder];
	move.board = board;
	move.figure = king;
	move.from = king.field;
	move.to = VDFieldFromString(board.moveOrder == VDColorWhite ? @"c1" :  @"c8");
	move.longCastle = YES;
	
	return move;
}

- (NSString *)fullDescription
{
	NSString *baseStr = nil;
	if (self.longCastle)
	{
		baseStr = @"0-0-0";
	}
	else if (self.castle)
	{
		baseStr = @"0-0";
	}
	else
	{
		baseStr = [NSString stringWithFormat:@"%@%@-%@", self.figure.letter, NSStringFromField(self.from), NSStringFromField(self.to)];
	}
	
	NSString *additionalStr = @"";
	if (self.check)
		additionalStr = @"+";
	else if (self.checkMate)
		additionalStr = @"#";
	
	NSString *result = [NSString stringWithFormat:@"%@%@", baseStr, additionalStr];
	
	return result;
}

@end
