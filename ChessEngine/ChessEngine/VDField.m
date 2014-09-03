//
//  VDField.m
//  ChessEngine
//
//  Created by Vladimir Deriglazov on 8/29/14.
//  Copyright (c) 2014 PMMedia. All rights reserved.
//

#import "VDField.h"

NSUInteger const kVDBoardSize = 8;

VDField VDFieldMake(NSUInteger row, NSUInteger col)
{
	VDField field;
	field.row = row;
	field.column = col;
	return field;
}

VDField VDFieldZero = {NSIntegerMax, NSIntegerMax};



NSString *NSStringFromField(VDField field)
{
	if (field.row >= kVDBoardSize || field.column >= kVDBoardSize)
	{
//		@throw @"Incorrect string to conversion to vdfield";
		return @"";
	}
	
	NSArray *letters = @[@"a", @"b", @"c", @"d", @"e", @"f", @"g", @"h"];
	return [NSString stringWithFormat:@"%@%lu", letters[field.column], field.row + 1];
}

VDField VDFieldFromString(NSString *str)
{
	if (str.length != 2)
		return VDFieldZero;
	
	NSArray *letters = @[@"a", @"b", @"c", @"d", @"e", @"f", @"g", @"h"];
	NSString *rowStr = [str substringToIndex:1];
	
	VDField field = VDFieldMake([[str substringFromIndex:1] integerValue] - 1, [letters indexOfObject:rowStr]);
	if (field.column >= kVDBoardSize || field.row >= kVDBoardSize)
	{
//		@throw @"Incorrect string to conversion to vdfield";
		return VDFieldZero;
	}
	return field;
}

VDColor VDFieldColor(VDField field)
{
	VDColor result = ((field.column + field.row) % 2 != 0) ? VDColorWhite : VDColorBlack;
	return result;
}

BOOL VDFieldsAreEqual(VDField field1, VDField field2)
{
	return (field1.column == field2.column) && (field1.row == field2.row);
}

NSArray *HorizontalFieldsWithField(VDField field, BOOL inclusionFlag)
{
	NSMutableArray *result = [NSMutableArray new];
	for (NSUInteger col = 0; col < kVDBoardSize; col++)
	{
		if (!inclusionFlag && col == field.column)
			continue;
		
		[result addObject:NSStringFromField(VDFieldMake(field.row, col))];
	}
	
	return result;
}

NSArray *VerticalFieldsWithField(VDField field, BOOL inclusionFlag)
{
	NSMutableArray *result = [NSMutableArray new];
	for (NSUInteger row = 0; row < kVDBoardSize; row++)
	{
		if (!inclusionFlag && row == field.row)
			continue;
		
		[result addObject:NSStringFromField(VDFieldMake(row, field.column))];
	}
	return result;
}

NSArray *DiagonalsFieldsWithField(VDField field, BOOL inclusionFlag)
{
	NSMutableArray *result = [NSMutableArray new];
	for (NSUInteger col = 0; col < kVDBoardSize; col++)
	{
		if (!inclusionFlag && col == field.column)
			continue;
		
		NSInteger row = (int)field.row - (field.column - col);
		if (row >= 0 && row < kVDBoardSize)
		{
			[result addObject:NSStringFromField(VDFieldMake(row, col))];
		}
	}
	
	for (NSUInteger col = 0; col < kVDBoardSize; col++)
	{
		if (col == field.column)
			continue;
		
		NSInteger row = (int)field.row + (field.column - col);
		if (row >= 0 && row < kVDBoardSize)
		{
			[result addObject:NSStringFromField(VDFieldMake(row, col))];
		}
	}
	
	return result;
}

NSArray *NearbyFieldsToField(VDField field, BOOL inclusionFlag)
{
	NSMutableArray *result = [NSMutableArray new];
	
	for (NSInteger i = 0; i < 3;  i++)
	{
		NSInteger col = field.column - 1 + i;
		if (col < 0 || col >= kVDBoardSize)
			continue;
		
		for (NSInteger j = 0; j < 3;  j++)
		{
			NSInteger row = field.row - 1 + j;
			if (row < 0 || row >= kVDBoardSize)
				continue;
			
			if (!inclusionFlag && col == field.column && row == field.row)
				continue;
			
			[result addObject:NSStringFromField(VDFieldMake(row, col))];
		}
	}
	
	return result;
}

NSSet *HorizontalFieldsWithFieldWithHardAndSoftTraps(VDField field, NSSet *hardTraps, NSSet *softTraps)
{
	__block NSMutableSet *result = [NSMutableSet new];
	
	BOOL (^block) (int col) = ^BOOL (int col)
	{
		NSString *fieldStr = NSStringFromField(VDFieldMake(field.row, col));
		if ([hardTraps containsObject:fieldStr])
		{
			return NO;
		}
		else if ([softTraps containsObject:fieldStr])
		{
			[result addObject:fieldStr];
			return NO;
		}
		else
		{
			[result addObject:fieldStr];
			return YES;
		}
	};
	
	for (int col = (int)field.column + 1; col < kVDBoardSize; col++)
	{
		if (!block(col))
		{
			break;
		}
	}
	
	for (int col = (int)field.column - 1; col >= 0; col--)
	{
		if (!block(col))
		{
			break;
		}
	}
	
	return result;
}

NSSet *VerticalFieldsWithFieldWithHardAndSoftTraps(VDField field, NSSet *hardTraps, NSSet *softTraps)
{
	__block NSMutableSet *result = [NSMutableSet new];
	
	BOOL (^block) (int col) = ^BOOL (int row)
	{
		NSString *fieldStr = NSStringFromField(VDFieldMake(row, field.column));
		if ([hardTraps containsObject:fieldStr])
		{
			return NO;
		}
		else if ([softTraps containsObject:fieldStr])
		{
			[result addObject:fieldStr];
			return NO;
		}
		else
		{
			[result addObject:fieldStr];
			return YES;
		}
	};
	
	for (int row = (int)field.row + 1; row < kVDBoardSize; row++)
	{
		if (!block(row))
		{
			break;
		}
	}
	
	for (int row = (int)field.row - 1; row >= 0; row--)
	{
		if (!block(row))
		{
			break;
		}
	}
	
	return result;
}

NSSet *DiagonalsFieldsWithFieldWithHardAndSoftTraps(VDField field, NSSet *hardTraps, NSSet *softTraps)
{
	__block NSMutableSet *result = [NSMutableSet new];
	
	BOOL (^block) (int row, int col) = ^BOOL (int row, int col)
	{
		NSString *fieldStr = NSStringFromField(VDFieldMake(row, col));
		if ([hardTraps containsObject:fieldStr])
		{
			return NO;
		}
		else if ([softTraps containsObject:fieldStr])
		{
			[result addObject:fieldStr];
			return NO;
		}
		else
		{
			[result addObject:fieldStr];
			return YES;
		}
	};
	
	for (int col = (int)field.column + 1; col < kVDBoardSize; col++)
	{
		int row = (int)field.row - ((int)field.column - col);
		if (!block(row, col))
			break;
	}
	
	for (int col = (int)field.column + 1; col < kVDBoardSize; col++)
	{
		int row = (int)field.row + ((int)field.column - col);
		if (!block(row, col))
			break;
	}
	
	for (int col = (int)field.column - 1; col >= 0; col--)
	{
		int row = (int)field.row - ((int)field.column - col);
		if (!block(row, col))
			break;
	}
	
	for (int col = (int)field.column - 1; col >= 0; col--)
	{
		int row = (int)field.row + ((int)field.column - col);
		if (!block(row, col))
			break;
	}
	
	return result;
}

NSSet *NearbyFieldsWithFieldWithHardAndSoftTraps(VDField field, NSSet *hardTraps, NSSet *softTraps)
{
	NSMutableSet *result = [NSMutableSet new];
	
	for (NSInteger i = 0; i < 3;  i++)
	{
		NSInteger col = field.column - 1 + i;
		if (col < 0 || col >= kVDBoardSize)
			continue;
		
		for (NSInteger j = 0; j < 3;  j++)
		{
			NSInteger row = field.row - 1 + j;
			if (row < 0 || row >= kVDBoardSize)
				continue;
			
			if (col == field.column && row == field.row)
				continue;
			
			NSString *fieldStr = NSStringFromField(VDFieldMake(row, col));
			if (![hardTraps containsObject:fieldStr])
			{
				[result addObject:fieldStr];
			}
		}
	}
	
	return result;
}
