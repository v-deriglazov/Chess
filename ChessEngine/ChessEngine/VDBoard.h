//
//  VDBoard.h
//  ChessEngine
//
//  Created by Vladimir Deriglazov on 9/1/14.
//  Copyright (c) 2014 PMMedia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VDField.h"

@class VDFigure, VDKing, VDMove, VDBoard;

extern NSString *const VDBoardFigureDidMoveNotification;
extern NSString *const VDBoardFigureDidDownNotification;
extern NSString *const VDBoardFigureDidAppearNotification;
extern NSString *const VDBoardMoveDidCompleteNotification;
extern NSString *const VDBoardCheckNotification;
extern NSString *const VDBoardCheckMateNotification;

	extern NSString *const VDBoardFigureKey;
	extern NSString *const VDBoardFieldKey;

@protocol VDBoardDelegate <NSObject>

- (VDMove *)lastMoveForBoard:(VDBoard *)board;
- (void)move:(VDMove *)move didCompleteOnBoard:(VDBoard *)board;
- (void)move:(VDMove *)move didUndoOnBoard:(VDBoard *)board;

@end

@interface VDBoard : NSObject //<NSCopying, NSCoding>

- (id)initNewGame;
- (id)initWithWhiteFigures:(NSArray *)whiteFigures blackFigures:(NSArray *)blackFigures moveOrder:(VDColor)color options:(NSDictionary *)options; // DI

@property (nonatomic, readonly) NSArray *whiteFigures;
@property (nonatomic, readonly) NSArray *blackFigures;
@property (nonatomic, readonly) VDColor moveOrder;
@property (nonatomic, weak) id<VDBoardDelegate> delegate;

- (BOOL)canMoveFigure:(VDFigure *)figure toField:(VDField)field;
- (NSSet *)possibleMovesForFigure:(VDFigure *)figure;
- (void)moveFigure:(VDFigure *)figure toField:(VDField)field kingUnderCheck:(BOOL *)flag;

- (void)makeMove:(VDMove *)move notify:(BOOL)flag;
- (void)undoMove:(VDMove *)move notify:(BOOL)flag;

- (VDKing *)kingForColor:(VDColor)color;
- (VDFigure *)figureOnField:(VDField)field;

@end
