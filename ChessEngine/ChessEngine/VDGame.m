//
//  VDGame.m
//  ChessEngine
//
//  Created by Vladimir Deriglazov on 9/1/14.
//  Copyright (c) 2014 PMMedia. All rights reserved.
//

#import "VDGame.h"

#import "VDBoard.h"
#import "VDHistory.h"

@interface VDGame () <VDBoardDelegate>

@property (nonatomic, strong) VDBoard *board;
@property (nonatomic) NSTimeInterval timeLimit;
@property (nonatomic) NSTimeInterval whiteTime;
@property (nonatomic) NSTimeInterval blackTime;
@property (nonatomic, strong) VDHistory *history;

@property (nonatomic) NSInteger currentIndex;
@end

@implementation VDGame

+ (id)standardGameWithoutTimeLimits
{
	return [[self alloc] initWithBoard:[[VDBoard alloc] initNewGame]];
}

- (id)initWithBoard:(VDBoard *)board
{
	return [self initWithBoard:board timeLimit:NSTimeIntervalSince1970];
}

- (id)initWithBoard:(VDBoard *)board timeLimit:(NSTimeInterval)timeLimit
{
	return [self initWithBoard:board timeLimit:timeLimit currentWhiteTime:0 currentBlackTime:0];
}

- (id)initWithBoard:(VDBoard *)board timeLimit:(NSTimeInterval)timeLimit currentWhiteTime:(NSTimeInterval)whiteTime currentBlackTime:(NSTimeInterval)blackTime
{
	return [self initWithBoard:board timeLimit:timeLimit currentWhiteTime:whiteTime currentBlackTime:blackTime history:nil];
}

- (id)initWithBoard:(VDBoard *)board timeLimit:(NSTimeInterval)timeLimit currentWhiteTime:(NSTimeInterval)whiteTime currentBlackTime:(NSTimeInterval)blackTime history:(VDHistory *)history
{
	if (board == nil)
		return nil;
	
	self = [super init];
	if (self)
	{
		_board = board;
		_board.delegate = self;
		_timeLimit = timeLimit;
		_whiteTime = whiteTime;
		_blackTime = blackTime;
		_history = history ? : [VDHistory new];
		_currentIndex = _history.moveCount - 1;
	}
	return self;
}

#pragma mark - 

- (BOOL)canUndo
{
	return (self.currentIndex >= 0);
}

- (BOOL)canRedo
{
	return (self.currentIndex < self.history.moveCount - 1);
}

- (void)undoMove
{
	NSAssert(self.currentIndex >= 0 && self.currentIndex < self.history.moveCount, @"");
	VDMove *currentMove = [self.history moveAtIndex:self.currentIndex];
	[self.board undoMove:currentMove notify:YES];
}

- (void)redoMove
{
	NSAssert(self.currentIndex >= 0 && self.currentIndex < self.history.moveCount - 1, @"");
	VDMove *nextMove = [self.history moveAtIndex:self.currentIndex + 1];
	[self.board makeMove:nextMove notify:YES];
}

#pragma mark - VDBoardDelegate

- (VDMove *)lastMoveForBoard:(VDBoard *)board
{
	VDMove *move = nil;
	if (self.currentIndex >= 0 && self.currentIndex < self.history.moveCount)
		move = [self.history moveAtIndex:self.currentIndex];
	return move;
}

- (void)move:(VDMove *)move didCompleteOnBoard:(VDBoard *)board
{
	if (self.currentIndex == self.history.moveCount - 1)
	{
		[self.history addMove:move];
	}

	self.currentIndex++;
}

- (void)move:(VDMove *)move didUndoOnBoard:(VDBoard *)board
{
	VDMove *currentMove = [self.history moveAtIndex:self.currentIndex];
	NSAssert(currentMove == move, @"");
	self.currentIndex--;
}

@end
