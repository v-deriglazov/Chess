//
//  VDAnnotationViewController.m
//  ChessMAC
//
//  Created by Vladimir Deriglazov on 9/8/14.
//  Copyright (c) 2014 PMMedia. All rights reserved.
//

#import "VDAnnotationViewController.h"
#import "ChessEngine/VDHistory.h"
#import "ChessEngine/VDMove.h"

static NSString *const kMoveNumberColumnIdentifier = @"kMoveNumberColumnIdentifier";
static NSString *const kWhiteMoveColumnIdentifier = @"kWhiteMoveColumnIdentifier";
static NSString *const kBlackMoveColumnIdentifier = @"kBlackMoveColumnIdentifier";

@interface VDAnnotationViewController () <NSTableViewDataSource, NSTableViewDelegate>

@property (nonatomic, weak) NSTableView *tableView;

@end

@implementation VDAnnotationViewController

- (void)loadView
{
	NSView *view = [NSView new];
	[self setView:view];
}

- (NSTableView *)tableView
{
	if (_tableView == nil)
	{
		NSTableView *tableView = [NSTableView new];
		tableView.delegate = self;
		tableView.dataSource = self;
		tableView.frame = self.view.bounds;
		tableView.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
		
		NSTableColumn *numColumn = [[NSTableColumn alloc] initWithIdentifier:kMoveNumberColumnIdentifier];
		[numColumn setWidth:20];
		[tableView addTableColumn:numColumn];
		NSTableColumn *whiteMovesColumn = [[NSTableColumn alloc] initWithIdentifier:kWhiteMoveColumnIdentifier];
		[whiteMovesColumn setWidth:70];
		[tableView addTableColumn:whiteMovesColumn];
		NSTableColumn *blackMovesColumn = [[NSTableColumn alloc] initWithIdentifier:kBlackMoveColumnIdentifier];
		[blackMovesColumn setWidth:70];
		[tableView addTableColumn:blackMovesColumn];
		
		
		[self.view addSubview:tableView];
		_tableView = tableView;
	}
	return _tableView;
}

- (void)setHistory:(VDHistory *)history
{
	if (_history != history)
	{
		if (_history != nil)
		{
			[[NSNotificationCenter defaultCenter] removeObserver:self name:VDHistoryUpdateNotification object:_history];
		}
		_history = history;
		if (_history != nil)
		{
			[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(historyDidUpdate:) name:VDHistoryUpdateNotification object:_history];
		}
		[self.tableView reloadData];
	}
}

- (void)historyDidUpdate:(NSNotification *)notification
{
	[self.tableView reloadData];
}

#pragma mark - 

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
	return self.history.fullMoveCount;
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row;
{
	NSString *result = nil;
	NSString *identifier = tableColumn.identifier;
	if ([identifier isEqualToString:kMoveNumberColumnIdentifier])
	{
		result = [NSString stringWithFormat:@"%lu", row + 1];
	}
	else if ([identifier isEqualToString:kWhiteMoveColumnIdentifier])
	{
		result = [[self.history moveAtIndex:row * 2] fullDescription];
	}
	else if ([identifier isEqualToString:kBlackMoveColumnIdentifier])
	{
		result = [[self.history moveAtIndex:row * 2 + 1] fullDescription];
	}
	
	return result;
}

@end
