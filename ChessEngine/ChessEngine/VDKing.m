//
//  VDKing.m
//  ChessEngine
//
//  Created by Vladimir Deriglazov on 8/29/14.
//  Copyright (c) 2014 PMMedia. All rights reserved.
//

#import "VDKing.h"

@implementation VDKing

- (NSSet *)possibleMoves
{
	return [NSSet setWithArray:NearbyFieldsToField(self.field, NO)];
}

- (NSSet *)rawPossibleMovesWithFigures:(NSSet *)figures
{
	NSMutableSet *hardTraps = nil;
	NSMutableSet *softTraps = nil;
	[self obtainFromFigures:figures hardTraps:&hardTraps softTraps:&softTraps];
	return NearbyFieldsWithFieldWithHardAndSoftTraps(self.field, hardTraps, softTraps);
}

- (NSString *)letter
{
	return @"K";
}

@end
