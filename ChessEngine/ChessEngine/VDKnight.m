//
//  VDKnight.m
//  ChessEngine
//
//  Created by Vladimir Deriglazov on 8/29/14.
//  Copyright (c) 2014 PMMedia. All rights reserved.
//

#import "VDKnight.h"

@implementation VDKnight

- (NSSet *)possibleMoves
{
	NSMutableSet *result = [NSMutableSet new];
	VDField field = self.field;
	if (field.column > 1)
	{
		if (field.row > 0)
		{
			[result addObject:NSStringFromField(VDFieldMake(field.row - 1, field.column - 2))];
		}
		if (field.row < kVDBoardSize - 1)
		{
			[result addObject:NSStringFromField(VDFieldMake(field.row + 1, field.column - 2))];
		}
	}
	if (field.column < kVDBoardSize - 2)
	{
		if (field.row > 0)
		{
			[result addObject:NSStringFromField(VDFieldMake(field.row - 1, field.column + 2))];
		}
		if (field.row < kVDBoardSize - 1)
		{
			[result addObject:NSStringFromField(VDFieldMake(field.row + 1, field.column + 2))];
		}
	}
	
	if (field.column > 0)
	{
		if (field.row > 1)
		{
			[result addObject:NSStringFromField(VDFieldMake(field.row - 2, field.column - 1))];
		}
		if (field.row < kVDBoardSize - 2)
		{
			[result addObject:NSStringFromField(VDFieldMake(field.row + 2, field.column - 1))];
		}
	}
	if (field.column < kVDBoardSize - 1)
	{
		if (field.row > 1)
		{
			[result addObject:NSStringFromField(VDFieldMake(field.row - 2, field.column + 1))];
		}
		if (field.row < kVDBoardSize - 2)
		{
			[result addObject:NSStringFromField(VDFieldMake(field.row + 2, field.column + 1))];
		}
	}
	
	return result;
}

- (NSString *)letter
{
	return @"N";
}

- (CGFloat)price
{
	return 2;
}

@end
