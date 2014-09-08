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


@implementation VDMove

+ (id)moveOnBoard:(VDBoard *)board figure:(VDFigure *)figure toField:(VDField)field
{
	VDMove *move = [VDMove new];
	
	move.board = board;
	move.figure = figure;
	move.from = figure.field;
	move.to = field;
	move.figWasMoved = figure.moved;
	
	int colDiff = (int)figure.field.column - (int)field.column;
	if (figure.type == VDFigureTypeKing && ABS(colDiff) == 2)
	{
		if (field.column == kVDBoardSize - 2)
			move.castle = YES;
		else
			move.longCastle = YES;
	}
	
	VDFigure *killedFig = [board figureOnField:field];
	//beat on a passage!
	if (killedFig == nil && figure.type == VDFigureTypePawn && move.from.column != move.to.column)
	{
		killedFig = [board figureOnField:VDFieldMake(move.from.row, move.to.column)];
		NSAssert(killedFig != nil && killedFig.color != figure.color, @"Beat on a passage incorrect");
	}
	move.killedFigure = killedFig;
	
	//TODO: handle pawn on 8/1 row
	
//	move.appearedFigure
	
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
		NSString *separator = (self.killedFigure != nil) ? @"x" : @"-";
		baseStr = [NSString stringWithFormat:@"%@%@%@%@", self.figure.letter, NSStringFromField(self.from), separator, NSStringFromField(self.to)];
	}
	
	if (self.appearedFigure != nil)
	{
		baseStr = [NSString stringWithFormat:@"%@%@", baseStr, self.appearedFigure.letter];
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
