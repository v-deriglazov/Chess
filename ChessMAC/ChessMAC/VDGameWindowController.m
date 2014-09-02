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

@interface VDGameWindowController ()

@property (nonatomic, strong) VDGame *game;

@property (nonatomic, strong) VDBoardViewController *boardController;
@property (nonatomic, weak) IBOutlet NSView *boardView;

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

@end
