//
//  VDHistory.h
//  ChessEngine
//
//  Created by Vladimir Deriglazov on 9/1/14.
//  Copyright (c) 2014 PMMedia. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VDMove;

extern NSString *const VDHistoryUpdateNotification;

@interface VDHistory : NSObject

- (NSUInteger)fullMoveCount; // white and black move
- (NSString *)fullMoveRepAtIndex:(NSUInteger)index;

- (NSUInteger)moveCount;
- (VDMove *)moveAtIndex:(NSUInteger)index;

- (void)addMove:(VDMove *)move;
- (void)removeLastMove;

@end
