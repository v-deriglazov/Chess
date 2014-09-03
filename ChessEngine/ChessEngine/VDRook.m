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
	NSMutableSet *result = [NSMutableSet setWithArray:HorizontalFieldsWithField(self.field, NO)];
	[result addObjectsFromArray:VerticalFieldsWithField(self.field, NO)];
	return result;
}

- (NSSet *)rawPossibleMovesWithFigures:(NSSet *)figures
{
	NSMutableSet *hardTraps = nil;
	NSMutableSet *softTraps = nil;
	[self obtainFromFigures:figures hardTraps:&hardTraps softTraps:&softTraps];
	
	NSMutableSet *result = [HorizontalFieldsWithFieldWithHardAndSoftTraps(self.field, hardTraps, softTraps) mutableCopy];
	[result unionSet:VerticalFieldsWithFieldWithHardAndSoftTraps(self.field, hardTraps, softTraps)];
	
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
