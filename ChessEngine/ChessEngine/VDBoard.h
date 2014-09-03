//
//  VDBoard.h
//  ChessEngine
//
//  Created by Vladimir Deriglazov on 9/1/14.
//  Copyright (c) 2014 PMMedia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VDField.h"

@class VDFigure, VDKing;

extern NSString *const VDBoardFigureDidMoveNotification;
extern NSString *const VDBoardFigureDidDownNotification;
extern NSString *const VDBoardFigureDidAppearNotification;
extern NSString *const VDBoardMoveDidCompleteNotification;
extern NSString *const VDBoardCheckNotification;
extern NSString *const VDBoardCheckMateNotification;

	extern NSString *const VDBoardFigureKey;
	extern NSString *const VDBoardFieldKey;


@interface VDBoard : NSObject //<NSCopying, NSCoding>

- (id)initNewGame;
- (id)initWithWhiteFigures:(NSArray *)whiteFigures blackFigures:(NSArray *)blackFigures moveOrder:(VDColor)color options:(NSDictionary *)options; // DI

@property (nonatomic, readonly) NSArray *whiteFigures;
@property (nonatomic, readonly) NSArray *blackFigures;
@property (nonatomic, readonly) VDColor moveOrder;

- (BOOL)canMoveFigure:(VDFigure *)figure toField:(VDField)field;
- (NSSet *)possibleMovesForFigure:(VDFigure *)figure;
- (void)moveFigure:(VDFigure *)figure toField:(VDField)field kingUnderCheck:(BOOL *)flag;

- (VDKing *)kingForColor:(VDColor)color;
- (VDFigure *)figureOnField:(VDField)field;

@end
