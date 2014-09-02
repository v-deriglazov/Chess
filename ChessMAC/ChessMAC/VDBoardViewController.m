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

@interface VDBoardViewController () <VDBoardViewDelegate>

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
		_board = board;
		self.figureViews = nil;
		[self figureViews];
	}
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
			[self.view addSubview:figureView];
			[_figureViews addObject:figureView];
		}];
		[self recalcFigureFramesOnBoard:self.boardView];
	}
	return _figureViews;
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
	
}

@end
