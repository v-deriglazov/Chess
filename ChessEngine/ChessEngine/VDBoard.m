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

#import "VDMove.h"

NSString *const VDBoardFigureDidMoveNotification = @"VDBoardFigureDidMoveNotification";
NSString *const VDBoardFigureDidDownNotification = @"VDBoardFigureDidDownNotification";
NSString *const VDBoardFigureDidAppearNotification = @"VDBoardFigureDidAppearNotification";
NSString *const VDBoardMoveDidCompleteNotification = @"VDBoardMoveDidCompleteNotification";
NSString *const VDBoardCheckNotification = @"VDBoardCheckNotification";
NSString *const VDBoardCheckMateNotification = @"VDBoardCheckMateNotification";

	NSString *const VDBoardFigureKey = @"VDBoardFigureKey";
	NSString *const VDBoardFieldKey = @"VDBoardFieldKey";

@interface VDFigure (BoardAddition)
@property (nonatomic) BOOL moved;
@end


@interface VDBoard ()
{
	NSMutableArray *_whiteFigures;
	NSMutableArray *_blackFigures;
}

@property (nonatomic) VDColor moveOrder;
@property (nonatomic, strong) VDMove *temporaryMove;

@property (nonatomic, strong) NSMutableDictionary *options;

@end


@implementation VDBoard

@synthesize whiteFigures = _whiteFigures;
@synthesize blackFigures = _blackFigures;

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

- (NSSet *)possibleMovesForFigure:(VDFigure *)figure
{
	NSMutableSet *result = [NSMutableSet new];
	do
	{
		if (self.moveOrder != figure.color)
			break;

		NSMutableSet *figures = [NSMutableSet setWithArray:self.whiteFigures];
		[figures addObjectsFromArray:self.blackFigures];
		NSSet *rawResult = [figure rawPossibleMovesWithFigures:figures];
		for (NSString *fieldStr in rawResult)
		{
			if ([self canMoveFigure:figure toField:VDFieldFromString(fieldStr)])
			{
				[result addObject:fieldStr];
			}
		}
		
		[result unionSet:[self additionalPossibleMovesForFigure:figure]];
//		for (NSString *fieldStr in rawResult)
//		{
//			if ([self canMoveFigure:figure toField:VDFieldFromString(fieldStr)])
//			{
//				[result addObject:fieldStr];
//			}
//		}
	} while (NO);

	return result;
}

- (BOOL)canMoveFigure:(VDFigure *)figure toField:(VDField)field
{
	return [self canMoveFigure:figure toField:field checkOwnKing:YES];
}

- (BOOL)canMoveFigure:(VDFigure *)figure toField:(VDField)field checkOwnKing:(BOOL)checkKing
{
	BOOL result = NO;
	do
	{
		if (figure == nil || figure.color != self.moveOrder)
			break;
		
		VDColor currentMoveOrder = self.moveOrder;
		NSArray *figures = [self figuresForColor:currentMoveOrder];
		if (![figures containsObject:figure])
			break;
		
		VDFigure *figOnField = [self figureOnField:field];
		if (figOnField != nil && figOnField.color == figure.color)
			break;
		
		NSMutableSet *allFigures = [NSMutableSet setWithArray:self.whiteFigures];
		[allFigures addObjectsFromArray:self.blackFigures];
		NSSet *rawPossibleMoves = [figure rawPossibleMovesWithFigures:allFigures];
		
		NSSet *additionalPossibleMoves = [self additionalPossibleMovesForFigure:figure];
		NSString *fieldStr = NSStringFromField(field);
		if (![rawPossibleMoves containsObject:fieldStr] && ![additionalPossibleMoves containsObject:fieldStr])
			break;
		
#warning Check field accessibility (lines, diagonals, pawn...)
		
		if (checkKing)
		{
			VDMove *move = [VDMove moveOnBoard:self figure:figure toField:field];
			[self makeMove:move notify:NO];
			self.temporaryMove = move;
			
			VDField kingField = [self kingForColor:currentMoveOrder].field;

			NSArray *enemyFigures = [self figuresForColor:self.moveOrder];
			BOOL canBeatKing = NO;
			for (VDFigure *enemyFigure in enemyFigures)
			{
				canBeatKing = [self canMoveFigure:enemyFigure toField:kingField checkOwnKing:NO];
				if (canBeatKing)
				{
					break;
				}
			}
			
			[self undoMove:move notify:NO];
			self.temporaryMove = nil;
			
			if (canBeatKing)
				break;
		}
		
		result = YES;
	} while (NO);
	
	return result;
}

- (NSSet *)additionalPossibleMovesForFigure:(VDFigure *)figure
{
	NSMutableSet *result = [NSMutableSet new];
	if (figure.type == VDFigureTypePawn)
	{
		VDField figureField = figure.field;
		VDMove *lastMove = self.temporaryMove ?: [self.delegate lastMoveForBoard:self];
		if (lastMove.figure.type == VDFigureTypePawn)
		{
			VDField from = lastMove.from;
			VDField to = lastMove.to;
			int rowDiff = (int)from.row - (int)to.row;
			int colDiff = (int)to.column - (int)figureField.column;
			if (fabs(rowDiff) == 2 && to.row == figureField.row && fabs(colDiff) == 1)
			{
				VDField moveToField = VDFieldMake(to.row + ((int)from.row - (int)to.row) / 2, to.column);
				NSString *moveToFieldStr = NSStringFromField(moveToField);
				NSAssert([((VDPawn *)figure).beatFields containsObject:moveToFieldStr], @"");
				[result addObject:moveToFieldStr];
			}
		}
	}
	else if (figure.type == VDFigureTypeKing && !figure.moved)
	{
//		do
//		{
//			VDFigure *rook = [self figureOnField:VDFieldFromString(@"h1")];//or H8!!!!
//			if (rook.type != VDFigureTypeRook || rook.color != figure.color || rook.moved)
//				break;
//			
//			VDField field = VDFieldFromString(@"g1");
//			[result addObject:NSStringFromField(field)];
//		} while (NO);
		//castle, long castle
		//TODO: Implement castling
		
	}
	return result;
}

- (void)makeMove:(VDMove *)move notify:(BOOL)flag
{
	//TODO: write a lot of asserts!!!
	NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];

	VDFigure *fig = move.figure;
	fig.field = move.to;
	if (flag)
	{
		NSDictionary *userInfo = @{VDBoardFigureKey : fig, VDBoardFieldKey : NSStringFromField(move.from)};
		[defaultCenter postNotificationName:VDBoardFigureDidMoveNotification object:self userInfo:userInfo];
	}
	
	if (move.longCastle)
	{
		//TODO: implement longCastle
	}
	
	if (move.castle)
	{
		//TODO: implement castle
	}
	
	VDFigure *killedFig = move.killedFigure;
	if (killedFig != nil)
	{
		NSMutableArray *figs = [self figuresForColor:killedFig.color];
		[figs removeObject:killedFig];
		
		if (flag)
		{
			NSDictionary *userInfo = @{VDBoardFigureKey : killedFig};
			[defaultCenter postNotificationName:VDBoardFigureDidDownNotification object:self userInfo:userInfo];
		}
	}
	
	VDFigure *appearedFigure = move.appearedFigure;
	if (appearedFigure != nil)
	{
		NSMutableArray *figs = [self figuresForColor:appearedFigure.color];
		[figs addObject:appearedFigure];
		
		if (flag)
		{
			NSDictionary *userInfo = @{VDBoardFigureKey : appearedFigure};
			[defaultCenter postNotificationName:VDBoardFigureDidAppearNotification object:self userInfo:userInfo];
		}
	}
	
	self.moveOrder = (self.moveOrder == VDColorWhite) ? VDColorBlack : VDColorWhite;
	
	if (flag)
	{
		[self.delegate move:move didCompleteOnBoard:self];
		[defaultCenter postNotificationName:VDBoardMoveDidCompleteNotification object:self userInfo:nil];
	}
}

- (void)undoMove:(VDMove *)move notify:(BOOL)flag
{
	//TODO: write a lot of asserts!!!
	NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
	
	VDFigure *appearedFigure = move.appearedFigure;
	if (appearedFigure != nil)
	{
		NSMutableArray *figs = [self figuresForColor:appearedFigure.color];
		[figs removeObject:appearedFigure];
		
		if (flag)
		{
			NSDictionary *userInfo = @{VDBoardFigureKey : appearedFigure};
			[defaultCenter postNotificationName:VDBoardFigureDidDownNotification object:self userInfo:userInfo];
		}
	}
	
	VDFigure *killedFig = move.killedFigure;
	if (killedFig != nil)
	{
		NSMutableArray *figs = [self figuresForColor:killedFig.color];
		[figs addObject:killedFig];
		
		if (flag)
		{
			NSDictionary *userInfo = @{VDBoardFigureKey : killedFig};
			[defaultCenter postNotificationName:VDBoardFigureDidAppearNotification object:self userInfo:userInfo];
		}
		
	}
	
	VDFigure *fig = move.figure;
	fig.field = move.from;
	fig.moved = move.figWasMoved;
	if (flag)
	{
		NSDictionary *userInfo = @{VDBoardFigureKey : fig, VDBoardFieldKey : NSStringFromField(move.to)};
		[defaultCenter postNotificationName:VDBoardFigureDidMoveNotification object:self userInfo:userInfo];
	}
	
	if (move.longCastle)
	{
		//TODO: implement longCastle
	}
	
	if (move.castle)
	{
		//TODO: implement castle
	}
	
	self.moveOrder = (self.moveOrder == VDColorWhite) ? VDColorBlack : VDColorWhite;
	
	if (flag)
	{
		[self.delegate move:move didUndoOnBoard:self];
		[defaultCenter postNotificationName:VDBoardMoveDidCompleteNotification object:self userInfo:nil];
	}
}

- (void)moveFigure:(VDFigure *)figure toField:(VDField)field kingUnderCheck:(BOOL *)flag
{
	if (![self canMoveFigure:figure toField:field])
		return;
	
	VDMove *move = [VDMove moveOnBoard:self figure:figure toField:field];
	[self makeMove:move notify:YES];
	
	/*
	 static NSString *const VDBoardFigureDidMoveNotification = @"VDBoardFigureDidMoveNotification";
	 static NSString *const VDBoardFigureDidDownNotification = @"VDBoardFigureDidDownNotification";
	 static NSString *const VDBoardFigureDidAppearNotification = @"VDBoardFigureDidAppearNotification";
	 static NSString *const VDBoardMoveDidCompleteNotification = @"VDBoardMoveDidCompleteNotification";
	 static NSString *const VDBoardCheckedNotification = @"VDBoardCheckedNotification";
	 static NSString *const VDBoardCheckMateNotification = @"VDBoardCheckMateNotification";
	 */

	if (flag != NULL)
	{
		flag = NO;
	}
}

#pragma mark - Helper methods

- (NSMutableArray *)figuresForColor:(VDColor)color
{
	return (color == VDColorWhite) ? _whiteFigures : _blackFigures;
}

- (VDKing *)kingForColor:(VDColor)color
{
	__block VDKing *king = nil;
	NSArray *figures = [self figuresForColor:color];
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

- (VDFigure *)figureOnField:(VDField)field
{
	__block VDFigure *result = nil;
	NSMutableArray *figures = [self.whiteFigures mutableCopy];
	[figures addObjectsFromArray:self.blackFigures];
	[figures enumerateObjectsUsingBlock:^(VDFigure *fig, NSUInteger idx, BOOL *stop)
	{
		if (VDFieldsAreEqual(field, fig.field))
		{
			result = fig;
			*stop = YES;
		}
	}];
	return result;
}

@end
