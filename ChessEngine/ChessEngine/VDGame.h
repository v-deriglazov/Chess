//
//  VDGame.h
//  ChessEngine
//
//  Created by Vladimir Deriglazov on 9/1/14.
//  Copyright (c) 2014 PMMedia. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VDBoard, VDHistory;

@interface VDGame : NSObject

+ (id)standardGameWithoutTimeLimits;
- (id)initWithBoard:(VDBoard *)board;
- (id)initWithBoard:(VDBoard *)board timeLimit:(NSTimeInterval)timeLimit;
- (id)initWithBoard:(VDBoard *)board timeLimit:(NSTimeInterval)timeLimit currentWhiteTime:(NSTimeInterval)whiteTime currentBlackTime:(NSTimeInterval)blackTime;
- (id)initWithBoard:(VDBoard *)board timeLimit:(NSTimeInterval)timeLimit currentWhiteTime:(NSTimeInterval)whiteTime currentBlackTime:(NSTimeInterval)blackTime history:(VDHistory *)history; // DI

@property (nonatomic, readonly) VDBoard *board;
@property (nonatomic, readonly) NSTimeInterval timeLimit;
@property (nonatomic, readonly) NSTimeInterval whiteTime;
@property (nonatomic, readonly) NSTimeInterval blackTime;

@end
