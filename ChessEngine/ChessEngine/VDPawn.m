//
//  VDPawn.m
//  ChessEngine
//
//  Created by Vladimir Deriglazov on 8/29/14.
//  Copyright (c) 2014 PMMedia. All rights reserved.
//

#import "VDPawn.h"

@implementation VDPawn

- (NSSet *)possibleMoves
{
	NSMutableSet *result = [NSMutableSet new];
	if (self.color == VDColorWhite)
	{
		NSAssert(self.field.row < kVDBoardSize - 1, @"Pawn on the last row");
		[result addObject:NSStringFromField(VDFieldMake(self.field.row + 1, self.field.column))];
		if (!self.moved)
		{
			NSAssert(self.field.row == 1, @"Pawn inconsistency");
			[result addObject:NSStringFromField(VDFieldMake(self.field.row + 2, self.field.column))];
		}
	}
	else
	{
		NSAssert(self.field.row > 0, @"Pawn on the last row");
		[result addObject:NSStringFromField(VDFieldMake(self.field.row - 1, self.field.column))];
		if (!self.moved)
		{
			NSAssert(self.field.row == kVDBoardSize - 2, @"Pawn inconsistency");
			[result addObject:NSStringFromField(VDFieldMake(self.field.row - 2, self.field.column))];
		}
	}
	
	return result;
}

- (NSSet *)beatFields
{
	NSMutableSet *result = [NSMutableSet new];
	int step = (self.color == VDColorWhite) ? 1 : -1;
	VDField field = self.field;
	
	NSAssert(field.row + step >= 0 && field.row + step < kVDBoardSize, @"Pawn stays on the last row!");
	
	if (field.column > 0)
	{
		[result addObject:NSStringFromField(VDFieldMake(field.row + step, field.column - 1))];
	}
	if (field.column < kVDBoardSize - 1)
	{
		[result addObject:NSStringFromField(VDFieldMake(field.row + step, field.column + 1))];
	}
	
	return result;
}

- (NSSet *)rawPossibleMovesWithFigures:(NSSet *)figures
{
	NSMutableSet *hardTraps = nil;
	NSMutableSet *softTraps = nil;
	[self obtainFromFigures:figures hardTraps:&hardTraps softTraps:&softTraps];
	
	NSMutableSet *result = [self.beatFields mutableCopy];
	[result intersectSet:softTraps];
	
	NSMutableSet *set = [[self possibleMoves] mutableCopy];
	[set minusSet:hardTraps];
	[set minusSet:softTraps];
	
	[result unionSet:set];
	
#warning BUG and optimize
	
	return result;
}

- (NSString *)letter
{
	return @"p";
}

- (CGFloat)price
{
	return 1;
}

@end
