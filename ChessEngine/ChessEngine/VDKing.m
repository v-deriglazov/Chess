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
	return [NSSet setWithArray:NearbyFieldsToField(self.field)];
}

- (NSString *)letter
{
	return @"K";
}

@end
