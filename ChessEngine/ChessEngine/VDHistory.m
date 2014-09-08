//
//  VDHistory.m
//  ChessEngine
//
//  Created by Vladimir Deriglazov on 9/1/14.
//  Copyright (c) 2014 PMMedia. All rights reserved.
//

#import "VDHistory.h"

#import "VDMove.h"

NSString *const VDHistoryUpdateNotification = @"VDHistoryUpdateNotification";

@interface VDHistory ()
@property (nonatomic, strong) NSMutableArray *moves;
@end


@implementation VDHistory

- (NSMutableArray *)moves
{
	if (_moves == nil)
	{
		_moves = [NSMutableArray new];
	}
	return _moves;
}

- (NSUInteger)fullMoveCount
{
	return ceilf(1.0f * self.moves.count / 2);
}

- (NSString *)fullMoveRepAtIndex:(NSUInteger)index
{
	NSMutableString *result = nil;
	if (index < self.fullMoveCount)
	{
		NSUInteger moveIndex = index * 2;
		VDMove *move = self.moves[moveIndex];
		result = [move.fullDescription mutableCopy];
		
		moveIndex++;
		if (moveIndex < self.moves.count)
		{
			move = self.moves[moveIndex];
			[result appendFormat:@" %@", move.fullDescription];
		}
	}
	return result;
}

- (NSUInteger)moveCount
{
	return self.moves.count;
}

- (VDMove *)moveAtIndex:(NSUInteger)index
{
	if (index < self.moves.count)
	{
		return self.moves[index];
	}
	return nil;
}

- (void)addMove:(VDMove *)move
{
	if (move)
	{
		[self.moves addObject:move];
		//TODO: some asserts?
		[[NSNotificationCenter defaultCenter] postNotificationName:VDHistoryUpdateNotification object:self userInfo:nil];
	}
}

- (void)removeLastMove
{
	if (self.moves.count)
	{
		[self.moves removeLastObject];
		//TODO: some asserts?
		[[NSNotificationCenter defaultCenter] postNotificationName:VDHistoryUpdateNotification object:self userInfo:nil];
	}
}

@end
