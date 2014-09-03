//
//  VDBoardView.m
//  ChessMAC
//
//  Created by Vladimir Deriglazov on 9/1/14.
//  Copyright (c) 2014 PMMedia. All rights reserved.
//

#import "VDBoardView.h"

static CGFloat const kVDBoardViewTitleSpace = 20;


@implementation VDBoardView

@synthesize whiteFieldColor = _whiteFieldColor;
@synthesize blackFieldColor = _blackFieldColor;

- (void)setFrame:(NSRect)frameRect
{
	if (!NSEqualRects(self.frame, frameRect))
	{
		[super setFrame:frameRect];
		[self setNeedsDisplay:YES];
		[self.delegate recalcFigureFramesOnBoard:self];
	}
}

#pragma mark -

- (void)setOrientation:(VDBoardOrientaion)orientation
{
	if (_orientation != orientation)
	{
		_orientation = orientation;
		[self setNeedsDisplay:YES];
		[self.delegate recalcFigureFramesOnBoard:self];
	}
}

- (void)setWhiteFieldColor:(NSColor *)whiteFieldColor
{
	if (![_whiteFieldColor isEqualTo:whiteFieldColor])
	{
		_whiteFieldColor = whiteFieldColor;
		[self setNeedsDisplay:YES];
	}
}

- (void)setBlackFieldColor:(NSColor *)blackFieldColor
{
	if (![_blackFieldColor isEqualTo:blackFieldColor])
	{
		_blackFieldColor = blackFieldColor;
		[self setNeedsDisplay:YES];
	}
}

- (NSColor *)whiteFieldColor
{
	if (_whiteFieldColor == nil)
	{
		_whiteFieldColor = [NSColor yellowColor];
	}
	return _whiteFieldColor;
}

- (NSColor *)blackFieldColor
{
	if (_blackFieldColor == nil)
	{
		_blackFieldColor = [NSColor brownColor];
	}
	return _blackFieldColor;
}

- (NSColor *)highlightFieldColor
{
	if (_highlightFieldColor == nil)
	{
		_highlightFieldColor = [NSColor greenColor];
	}
	return _highlightFieldColor;
}

- (void)setHighlightedFields:(NSSet *)highlightedFields
{
	if (![_highlightedFields isEqualToSet:highlightedFields])
	{
		_highlightedFields = highlightedFields;
		[self setNeedsDisplay:YES];
	}
}

#pragma mark -

- (NSSize)sizeForField
{
	NSSize size = self.frame.size;
	size.width -= kVDBoardViewTitleSpace;
	size.height -= kVDBoardViewTitleSpace;
	size.width = floorf(size.width / kVDBoardSize);
	size.height = floorf(size.height / kVDBoardSize);
	return size;
}

- (NSRect)rectForField:(VDField)field
{
	//TODO: Implement orientation!
	NSSize size = [self sizeForField];
	NSRect result = NSMakeRect(kVDBoardViewTitleSpace + field.column * size.width, kVDBoardViewTitleSpace + field.row * size.height, size.width, size.height);
	return result;
}

#pragma mark -

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
    
    NSRectClip(dirtyRect);
	//TODO: Implement orientation!
	
	NSRect bounds = self.bounds;
	[self.blackFieldColor setFill];
	NSRectFill(bounds);

	//TODO: optimize!
	
	for (NSUInteger row = 0; row < kVDBoardSize; row++)
	{
		for (NSUInteger col = 0; col < kVDBoardSize; col++)
		{
			VDField field = VDFieldMake(row, col);
			NSRect fieldRect = [self rectForField:field];
			
			if (VDFieldColor(field) == VDColorWhite)
			{
				[self.whiteFieldColor setFill];
				NSRectFill(fieldRect);
			}
			
			if ([self.highlightedFields containsObject:NSStringFromField(field)])
			{
				NSRect highlightRect = NSInsetRect(fieldRect, fieldRect.size.width / 4, fieldRect.size.height / 4);
				highlightRect = NSIntegralRect(highlightRect);
				[self.highlightFieldColor setFill];
				NSRectFill(highlightRect);
			}
		}
	}
}

#pragma mark -

- (void)mouseDown:(NSEvent *)theEvent
{
	NSPoint point = [self convertPoint:[theEvent locationInWindow] fromView:nil];
	point.x -= kVDBoardViewTitleSpace;
	point.y -= kVDBoardViewTitleSpace;
	
	NSSize fieldSize = [self sizeForField];
	
	VDField field = VDFieldMake( ceilf(point.y / fieldSize.height) - 1, ceilf(point.x / fieldSize.width) - 1);
	[self.delegate clickOnField:field board:self];
}

@end
