//
//  VDGameWindowController.m
//  ChessMAC
//
//  Created by Vladimir Deriglazov on 9/1/14.
//  Copyright (c) 2014 PMMedia. All rights reserved.
//

#import "VDGameWindowController.h"
#import "ChessEngine/VDGame.h"
#import "VDBoardViewController.h"
#import "VDAnnotationViewController.h"

@interface VDGameWindowController ()

@property (nonatomic, strong) VDGame *game;

@property (nonatomic, strong) VDBoardViewController *boardController;
@property (nonatomic, strong) VDAnnotationViewController *annotationController;

@property (nonatomic, weak) IBOutlet NSView *boardView;
@property (nonatomic, weak) IBOutlet NSView *annotationView;

@end

@implementation VDGameWindowController

- (id)initWithGame:(VDGame *)game
{
    self = [super initWithWindowNibName:[self windowNibName]];
    if (self)
	{
        _game = game;
    }
    return self;
}

- (NSString *)windowNibName
{
	return @"VDGameWindowController";
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    [self boardController];
	[self annotationController];
}

- (VDBoardViewController *)boardController
{
	if (_boardController == nil)
	{
		_boardController = [VDBoardViewController new];
		_boardController.board = self.game.board;
		_boardController.view.frame = self.boardView.bounds;
		_boardController.view.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
		[self.boardView addSubview:_boardController.view];
	}
	return _boardController;
}

- (VDAnnotationViewController *)annotationController
{
	if (_annotationController == nil)
	{
		_annotationController = [VDAnnotationViewController new];
		_annotationController.history = self.game.history;
		_annotationController.view.frame = self.annotationView.bounds;
		_annotationController.view.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
		[self.annotationView addSubview:_annotationController.view];
	}
	return _annotationController;
}
@end
