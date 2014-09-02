//
//  VDRook.m
//  ChessEngine
//
//  Created by Vladimir Deriglazov on 8/29/14.
//  Copyright (c) 2014 PMMedia. All rights reserved.
//

#import "VDRook.h"

@implementation VDRook

- (NSSet *)possibleMoves
{
	NSMutableSet *result = [NSMutableSet setWithArray:HorizontalFieldsWithField(self.field)];
	[result addObjectsFromArray:VerticalFieldsWithField(self.field)];
	return result;
}

- (NSString *)letter
{
	return @"R";
}

- (CGFloat)price
{
	return 4;
}

@end
