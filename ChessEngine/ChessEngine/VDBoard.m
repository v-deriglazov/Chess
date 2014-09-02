//
//  VDBoard.m
//  ChessEngine
//
//  Created by Vladimir Deriglazov on 9/1/14.
//  Copyright (c) 2014 PMMedia. All rights reserved.
//

#import "VDBoard.h"

#import "VDKing.h"
#import "VDQueen.h"
#import "VDRook.h"
#import "VDBishop.h"
#import "VDKnight.h"
#import "VDPawn.h"

static NSString *const VDBoardFigureDidDownNotification = @"VDBoardFigureDidDownNotification";
static NSString *const VDBoardMoveDidCompleteNotification = @"VDBoardMoveDidCompleteNotification";
static NSString *const VDBoardKingDidCheckedNotification = @"VDBoardKingDidCheckedNotification";
static NSString *const VDBoardCheckMateNotification = @"VDBoardCheckMateNotification";

@interface VDBoard ()

@property (nonatomic, strong) NSMutableArray *whiteFigures;
@property (nonatomic, strong) NSMutableArray *blackFigures;
@property (nonatomic) VDColor moveOrder;

@property (nonatomic, strong) NSMutableDictionary *options;

@end


@implementation VDBoard

- (id)initNewGame
{
	NSArray *whiteFigs = [self startFiguresForColor:VDColorWhite];
	NSArray *blackFigs = [self startFiguresForColor:VDColorBlack];
	return [self initWithWhiteFigures:whiteFigs blackFigures:blackFigs moveOrder:VDColorWhite options:nil];
}

- (id)initWithWhiteFigures:(NSArray *)whiteFigures blackFigures:(NSArray *)blackFigures moveOrder:(VDColor)color options:(NSDictionary *)options
{
	self = [super init];
	if (self)
	{
		__block BOOL whiteKing = NO;
		__block BOOL blackKing = NO;
		[whiteFigures enumerateObjectsUsingBlock:^(VDFigure *fig, NSUInteger idx, BOOL *stop)
		{
			NSAssert(fig.color == VDColorWhite, @"Incorrect color");
			whiteKing = whiteKing || [fig isKindOfClass:[VDKing class]];
		}];
		[blackFigures enumerateObjectsUsingBlock:^(VDFigure *fig, NSUInteger idx, BOOL *stop)
		 {
			 NSAssert(fig.color == VDColorBlack, @"Incorrect color");
			blackKing = blackKing || [fig isKindOfClass:[VDKing class]];
		 }];
		NSAssert(whiteKing && blackKing, @"King absent!");
		
		_whiteFigures = [whiteFigures mutableCopy];
		_blackFigures = [blackFigures mutableCopy];
		_moveOrder = color;
		_options = [options mutableCopy];
	}
	return self;
}

- (NSArray *)startFiguresForColor:(VDColor)color
{
	NSMutableArray *result = [NSMutableArray new];
	
	NSUInteger row = (color == VDColorWhite) ? 1 : kVDBoardSize - 2;
	for (NSUInteger col = 0; col < kVDBoardSize; col++)
	{
		VDPawn *pawn = [[VDPawn alloc] initOnField:VDFieldMake(row, col) color:color];
		[result addObject:pawn];
	}
	
	row = (color == VDColorWhite) ? 0 : kVDBoardSize - 1;
	
	VDRook *rook = [[VDRook alloc] initOnField:VDFieldMake(row, 0) color:color];
	[result addObject:rook];
	rook = [[VDRook alloc] initOnField:VDFieldMake(row, kVDBoardSize - 1) color:color];
	[result addObject:rook];
	
	VDKnight *knight = [[VDKnight alloc] initOnField:VDFieldMake(row, 1) color:color];
	[result addObject:knight];
	knight = [[VDKnight alloc] initOnField:VDFieldMake(row, kVDBoardSize - 2) color:color];
	[result addObject:knight];
	
	VDBishop *bishop = [[VDBishop alloc] initOnField:VDFieldMake(row, 2) color:color];
	[result addObject:bishop];
	bishop = [[VDBishop alloc] initOnField:VDFieldMake(row, kVDBoardSize - 3) color:color];
	[result addObject:bishop];
	
	VDQueen *queen = [[VDQueen alloc] initOnField:VDFieldMake(row, 3) color:color];
	[result addObject:queen];
	VDKing *king = [[VDKing alloc] initOnField:VDFieldMake(row, 4) color:color];
	[result addObject:king];
	
	return result;
}

#pragma mark - Board Logic

- (BOOL)canMoveFigure:(VDFigure *)figure toField:(VDField)field
{
	return NO;
}

- (void)moveFigure:(VDFigure *)figure toField:(VDField)field kingUnderCheck:(BOOL *)flag
{
	if (![self canMoveFigure:figure toField:field])
		return;
	
	
	/*
	 VDBoardFigureDidDownNotification;
	 VDBoardMoveDidCompleteNotification;
	 VDBoardKingDidCheckedNotification;
	 VDBoardCheckMateNotification;
	 */
	
	if (flag != NULL)
	{
		flag = NO;
	}
}

- (VDKing *)kingForColor:(VDColor)color
{
	__block VDKing *king = nil;
	NSArray *figures = (color == VDColorWhite) ? self.whiteFigures : self.blackFigures;
	[figures enumerateObjectsUsingBlock:^(VDFigure *fig, NSUInteger idx, BOOL *stop)
	{
		if ([fig isKindOfClass:[VDKing class]])
		{
			king = (VDKing *)fig;
			*stop = YES;
		}
	}];
	return king;
}

@end
