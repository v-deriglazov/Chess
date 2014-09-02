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
	NSMutableSet *result = [NSMutableSet setWithArray:HorizontalFieldsWithField(self.field)];
	[result addObjectsFromArray:VerticalFieldsWithField(self.field)];
	[result addObjectsFromArray:DiagonalsFieldsWithField(self.field)];
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
