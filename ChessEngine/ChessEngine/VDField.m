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
	
	VDField field = VDFieldMake([letters indexOfObject:rowStr], [[str substringFromIndex:1] integerValue] - 1);
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

NSArray *HorizontalFieldsWithField(VDField field)
{
	NSMutableArray *result = [NSMutableArray new];
	for (NSUInteger col = 0; col < kVDBoardSize; col++)
	{
		[result addObject:NSStringFromField(VDFieldMake(field.row, col))];
	}
	
	return result;
}

NSArray *VerticalFieldsWithField(VDField field)
{
	NSMutableArray *result = [NSMutableArray new];
	for (NSUInteger row = 0; row < kVDBoardSize; row++)
	{
		[result addObject:NSStringFromField(VDFieldMake(row, field.column))];
	}
	return result;
}

NSArray *DiagonalsFieldsWithField(VDField field)
{
	NSMutableArray *result = [NSMutableArray new];
	for (NSUInteger col = 0; col < kVDBoardSize; col++)
	{
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

NSArray *NearbyFieldsToField(VDField field)
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
			
			[result addObject:NSStringFromField(VDFieldMake(row, col))];
		}
	}
	
	return result;
}
