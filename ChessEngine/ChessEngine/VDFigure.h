//
//  VDFigure.h
//  ChessEngine
//
//  Created by Vladimir Deriglazov on 8/29/14.
//  Copyright (c) 2014 PMMedia. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "VDField.h"

typedef enum : NSUInteger
{
	VDFigureTypeUnknown,
    VDFigureTypeKing,
    VDFigureTypeQueen,
    VDFigureTypeRook,
	VDFigureTypeBishop,
	VDFigureTypeKnight,
	VDFigureTypePawn,
} VDFigureType;

@interface VDFigure : NSObject //<NSCopying, NSCoding>

- (id)initOnField:(VDField)field color:(VDColor)color;
- (id)initOnField:(VDField)field color:(VDColor)color isMoved:(BOOL)isMoved;	// DI

@property (nonatomic) VDField field;
@property (nonatomic, readonly) VDFigureType type;
@property (nonatomic, readonly) VDColor color;
@property (nonatomic, readonly) BOOL moved;

@property (nonatomic, readonly) NSSet *possibleMoves;
- (NSSet *)rawPossibleMovesWithFigures:(NSSet *)figures;
- (void)obtainFromFigures:(NSSet *)figures hardTraps:(NSSet **)hardTraps softTraps:(NSSet **)softTraps;

@property (nonatomic, readonly) NSString *letter;

@end


@interface VDFigure (Analytics)
@property (nonatomic, readonly) CGFloat price;
@end
