//
//  VDBoardViewController.m
//  ChessMAC
//
//  Created by Vladimir Deriglazov on 9/1/14.
//  Copyright (c) 2014 PMMedia. All rights reserved.
//

#import "VDBoardViewController.h"
#import "VDBoardView.h"
#import "VDFigureView.h"
#import "ChessEngine/VDFigure.h"
#import "ChessEngine/VDBoard.h"

@interface VDBoardViewController () <VDBoardViewDelegate, VDFigureViewDelegate>

@property (nonatomic, strong) VDBoardView *boardView;
@property (nonatomic, strong) NSMutableArray *figureViews;

@property (nonatomic, weak) VDFigure *selectedFigure;
@property (nonatomic, strong) NSSet *possibleMoves;

@end

@implementation VDBoardViewController

- (void)loadView
{
	NSView *view = [NSView new];
	[self setView:view];
}

- (VDBoardView *)boardView
{
	if (_boardView == nil)
	{
		_boardView = [[VDBoardView alloc] initWithFrame:self.view.bounds];
		_boardView.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
		_boardView.delegate = self;
		_boardView.orientation = VDBoardOrientaionBottom;
		[self.view addSubview:_boardView positioned:NSWindowBelow relativeTo:nil];
	}
	return _boardView;
}

- (void)setBoard:(VDBoard *)board
{
	if (_board != board)
	{
		NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
		if (_board != nil)
		{
			[center removeObserver:self name:VDBoardFigureDidMoveNotification object:_board];
			[center removeObserver:self name:VDBoardFigureDidDownNotification object:_board];
			[center removeObserver:self name:VDBoardFigureDidAppearNotification object:_board];
			[center removeObserver:self name:VDBoardMoveDidCompleteNotification object:_board];
			[center removeObserver:self name:VDBoardCheckNotification object:_board];
			[center removeObserver:self name:VDBoardCheckMateNotification object:_board];
		}
		_board = board;
		if (_board != nil)
		{
			[center addObserver:self selector:@selector(figureDidMoveOnBoard:) name:VDBoardFigureDidMoveNotification object:_board];
			[center addObserver:self selector:@selector(figureDidDownOnBoard:) name:VDBoardFigureDidDownNotification object:_board];
			[center addObserver:self selector:@selector(figureDidAppearOnBoard:) name:VDBoardFigureDidAppearNotification object:_board];
			[center addObserver:self selector:@selector(moveDidCompleteOnBoard:) name:VDBoardMoveDidCompleteNotification object:_board];
			[center addObserver:self selector:@selector(checkOnBoard:) name:VDBoardCheckNotification object:_board];
			[center addObserver:self selector:@selector(mateOnBoard:) name:VDBoardCheckMateNotification object:_board];
		}
		[self refreshFigureViews];
	}
}

- (void)refreshFigureViews
{
	if (_figureViews != nil)
	{
		[_figureViews enumerateObjectsUsingBlock:^(VDFigureView *view, NSUInteger idx, BOOL *stop)
		{
			view.delegate = nil;
			[view removeFromSuperview];
		}];
		[_figureViews removeAllObjects];
	}
	_figureViews = nil;
	[self figureViews];
}

- (NSMutableArray *)figureViews
{
	if (_figureViews == nil)
	{
		_figureViews = [NSMutableArray new];
		NSMutableArray *figures = [self.board.whiteFigures mutableCopy];
		[figures addObjectsFromArray:self.board.blackFigures];
		[figures enumerateObjectsUsingBlock:^(VDFigure *fig, NSUInteger idx, BOOL *stop)
		{
			VDFigureView *figureView = [VDFigureView new];
			figureView.figure = fig;
			figureView.delegate = self;
			[self.view addSubview:figureView];
			[_figureViews addObject:figureView];
		}];
		[self recalcFigureFramesOnBoard:self.boardView];
	}
	return _figureViews;
}

- (VDFigureView *)viewForFigure:(VDFigure *)fig
{
	if (![self.board.whiteFigures containsObject:fig] && ![self.board.blackFigures containsObject:fig])
		return nil;
	
	__block VDFigureView *result = nil;
	[self.figureViews enumerateObjectsUsingBlock:^(VDFigureView *view, NSUInteger idx, BOOL *stop)
	{
		if (view.figure == fig)
		{
			result = view;
			*stop = YES;
		}
	}];
	
	NSAssert(result != nil, @"Cannot find figureview for figure on board");
	return result;
}

#pragma mark - 

- (void)setSelectedFigure:(VDFigure *)selectedFigure
{
	if (_selectedFigure != selectedFigure)
	{
		VDFigureView *view = [self viewForFigure:_selectedFigure];
		view.selected = NO;
		
		_selectedFigure = selectedFigure;
		
		view = [self viewForFigure:_selectedFigure];
		view.selected = YES;
		
		self.possibleMoves = [self.board possibleMovesForFigure:_selectedFigure];
	}
}

- (void)setPossibleMoves:(NSSet *)possibleMoves
{
	if (![_possibleMoves isEqualToSet:possibleMoves])
	{
		_possibleMoves = possibleMoves;
		self.boardView.highlightedFields = _possibleMoves;
	}
}

#pragma mark - Board Notifications

- (void)figureDidMoveOnBoard:(NSNotification *)notification
{
	VDFigure *fig = notification.userInfo[VDBoardFigureKey];
	VDFigureView *view = [self viewForFigure:fig];
	view.frame = [self.boardView rectForField:view.figure.field];
}

- (void)figureDidDownOnBoard:(NSNotification *)notification
{
	VDFigure *fig = notification.userInfo[VDBoardFigureKey];
	VDFigureView *view = [self viewForFigure:fig];
	view.delegate = nil;
	[view removeFromSuperview];
	[self.figureViews removeObject:view];
}

- (void)figureDidAppearOnBoard:(NSNotification *)notification
{
//TODO: Implemnt figureDidAppearOnBoard
}

- (void)moveDidCompleteOnBoard:(NSNotification *)notification
{
	NSLog(@"moveDidCompleteOnBoard");
	self.selectedFigure = nil;
}

- (void)checkOnBoard:(NSNotification *)notification
{
	NSAlert *alert = [NSAlert alertWithMessageText:@"Check" defaultButton:@"OK" alternateButton:nil otherButton:nil informativeTextWithFormat:@"Do something"];
	[alert runModal];
}

- (void)mateOnBoard:(NSNotification *)notification
{
	NSAlert *alert = [NSAlert alertWithMessageText:@"Mate" defaultButton:@"OK" alternateButton:nil otherButton:nil informativeTextWithFormat:@"Game over"];
	[alert runModal];
}

#pragma mark - VDBoardViewDelegate

- (void)recalcFigureFramesOnBoard:(VDBoardView *)boardView
{
	[self.figureViews enumerateObjectsUsingBlock:^(VDFigureView *view, NSUInteger idx, BOOL *stop)
	{
		view.frame = [self.boardView rectForField:view.figure.field];
	}];
}

- (void)clickOnField:(VDField)field board:(VDBoardView *)boardView
{
	NSLog(@"clickOnField %@", NSStringFromField(field));
	if (self.selectedFigure)
	{
		if ([self.board canMoveFigure:self.selectedFigure toField:field])
		{
			[self.board moveFigure:self.selectedFigure toField:field kingUnderCheck:NULL];
			self.selectedFigure = nil;
		}
	}
	else
	{
		self.selectedFigure = nil;
	}
}

#pragma mark - VDFigureViewDelegate

- (void)figureViewDidSelect:(VDFigureView *)figureView
{
	VDFigure *clickedFig = figureView.figure;
	
	if (self.selectedFigure)
	{
		if (clickedFig == self.selectedFigure)
			self.selectedFigure = nil;
		else if (clickedFig.color == self.board.moveOrder)
			self.selectedFigure = clickedFig;
		else
		{
			VDField fieldToMove = clickedFig.field;
			if ([self.board canMoveFigure:self.selectedFigure toField:fieldToMove])
			{
				[self.board moveFigure:self.selectedFigure toField:fieldToMove kingUnderCheck:NULL];
				self.selectedFigure = nil;
			}
		}
	}
	else if (clickedFig.color == self.board.moveOrder)
	{
		self.selectedFigure = clickedFig;
	}
}

- (void)figureView:(VDFigureView *)figureView didLeftAtPoint:(NSPoint)point
{
	//TODO: Implement figureViewDidLeftAtPoint:
}

@end
