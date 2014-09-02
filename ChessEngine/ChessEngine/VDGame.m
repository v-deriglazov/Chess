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

@interface VDGame ()

@property (nonatomic, strong) VDBoard *board;
@property (nonatomic) NSTimeInterval timeLimit;
@property (nonatomic) NSTimeInterval whiteTime;
@property (nonatomic) NSTimeInterval blackTime;
@property (nonatomic, strong) VDHistory *history;

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
		_timeLimit = timeLimit;
		_whiteTime = whiteTime;
		_blackTime = blackTime;
		_history = history;
	}
	return self;
}

@end
