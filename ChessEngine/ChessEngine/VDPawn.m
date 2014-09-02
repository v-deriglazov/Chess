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
			NSAssert(self.field.row == 6, @"Pawn inconsistency");
			[result addObject:NSStringFromField(VDFieldMake(self.field.row - 2, self.field.column))];
		}
	}
	
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
