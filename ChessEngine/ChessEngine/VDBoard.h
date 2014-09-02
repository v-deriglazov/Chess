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

static NSString *const VDBoardFigureDidDownNotification;
static NSString *const VDBoardMoveDidCompleteNotification;
static NSString *const VDBoardKingDidCheckedNotification;
static NSString *const VDBoardCheckMateNotification;

@interface VDBoard : NSObject //<NSCopying, NSCoding>

- (id)initNewGame;
- (id)initWithWhiteFigures:(NSArray *)whiteFigures blackFigures:(NSArray *)blackFigures moveOrder:(VDColor)color options:(NSDictionary *)options; // DI

@property (nonatomic, readonly) NSArray *whiteFigures;
@property (nonatomic, readonly) NSArray *blackFigures;
@property (nonatomic, readonly) VDColor moveOrder;

- (BOOL)canMoveFigure:(VDFigure *)figure toField:(VDField)field;
- (void)moveFigure:(VDFigure *)figure toField:(VDField)field kingUnderCheck:(BOOL *)flag;

- (VDKing *)kingForColor:(VDColor)color;

@end
