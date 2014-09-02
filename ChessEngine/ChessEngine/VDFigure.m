//
//  VDFigure.m
//  ChessEngine
//
//  Created by Vladimir Deriglazov on 8/29/14.
//  Copyright (c) 2014 PMMedia. All rights reserved.
//

#import "VDFigure.h"

#import "VDKing.h"
#import "VDQueen.h"
#import "VDRook.h"
#import "VDBishop.h"
#import "VDKnight.h"
#import "VDPawn.h"

@interface VDFigure ()

@property (nonatomic) VDColor color;
@property (nonatomic) BOOL moved;

@end


@implementation VDFigure

- (id)initOnField:(VDField)field color:(VDColor)color;
{
	return [self initOnField:field color:color isMoved:NO];
}
- (id)initOnField:(VDField)field color:(VDColor)color isMoved:(BOOL)isMoved
{
	self = [super init];
	if (self)
	{
		_color = color;
		_moved = isMoved;
		_field = field;
	}
	return self;
}

- (void)setField:(VDField)field
{
	if (!VDFieldsAreEqual(_field, field))
	{
		_field = field;
		//TODO: post notification?
		self.moved = YES;
	}
}

- (NSSet *)possibleMoves
{
	return nil;
}

- (NSString *)letter
{
	return @"A";
}

- (NSString *)description
{
	return [NSString stringWithFormat:@"%@%@", self.letter, NSStringFromField(self.field)];
}

- (VDFigureType)type
{
	VDFigureType type = VDFigureTypeUnknown;
	if ([self isKindOfClass:[VDKing class]])
	{
		type = VDFigureTypeKing;
	}
	else if ([self isKindOfClass:[VDQueen class]])
	{
		type = VDFigureTypeQueen;
	}
	else if ([self isKindOfClass:[VDRook class]])
	{
		type = VDFigureTypeRook;
	}
	else if ([self isKindOfClass:[VDBishop class]])
	{
		type = VDFigureTypeBishop;
	}
	else if ([self isKindOfClass:[VDKnight class]])
	{
		type = VDFigureTypeKnight;
	}
	else if ([self isKindOfClass:[VDPawn class]])
	{
		type = VDFigureTypePawn;
	}
	return type;
}

@end



@implementation VDFigure (Analytics)

- (CGFloat)price
{
	return 0;
}

@end
