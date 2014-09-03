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

- (NSSet *)rawPossibleMovesWithFigures:(NSSet *)figures
{
	NSMutableSet *hardTraps = nil;
	NSMutableSet *softTraps = nil;
	[self obtainFromFigures:figures hardTraps:&hardTraps softTraps:&softTraps];
	
	NSMutableSet *result = [HorizontalFieldsWithFieldWithHardAndSoftTraps(self.field, hardTraps, softTraps) mutableCopy];
	[result unionSet:VerticalFieldsWithFieldWithHardAndSoftTraps(self.field, hardTraps, softTraps)];
	[result unionSet:DiagonalsFieldsWithFieldWithHardAndSoftTraps(self.field, hardTraps, softTraps)];
	
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
