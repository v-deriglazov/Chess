//
//  VDMove.m
//  ChessEngine
//
//  Created by Vladimir Deriglazov on 9/3/14.
//  Copyright (c) 2014 PMMedia. All rights reserved.
//

#import "VDMove.h"

#import "VDFigure.h"

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
	return move;
}

+ (id)castleOnBoard:(VDBoard *)board
{
	VDMove *move = [VDMove new];
	return move;
}

+ (id)longCastleOnBoard:(VDBoard *)board
{
	VDMove *move = [VDMove new];
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
