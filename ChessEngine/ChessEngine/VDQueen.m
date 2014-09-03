//
//  VDQueen.m
//  ChessEngine
//
//  Created by Vladimir Deriglazov on 8/29/14.
//  Copyright (c) 2014 PMMedia. All rights reserved.
//

#import "VDQueen.h"

@implementation VDQueen

- (NSSet *)possibleMoves
{
	NSMutableSet *result = [NSMutableSet setWithArray:HorizontalFieldsWithField(self.field, NO)];
	[result addObjectsFromArray:VerticalFieldsWithField(self.field, NO)];
	[result addObjectsFromArray:DiagonalsFieldsWithField(self.field, NO)];
	return result;
}

- (NSString *)letter
{
	return @"Q";
}

- (CGFloat)price
{
	return 5;
}

@end
