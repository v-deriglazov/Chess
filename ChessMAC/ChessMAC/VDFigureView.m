//
//  VDFigureView.m
//  ChessMAC
//
//  Created by Vladimir Deriglazov on 9/1/14.
//  Copyright (c) 2014 PMMedia. All rights reserved.
//

#import "VDFigureView.h"

#import "ChessEngine/ChessEngine.h"

@implementation VDFigureView

- (void)drawRect:(NSRect)dirtyRect
{
	char *figure = NULL;
	switch (self.figure.type)
	{
		case VDFigureTypePawn:
			figure = (self.figure.color == VDColorWhite) ? "\xe2\x99\x99" : "\xe2\x99\x9f";
			break;
		case VDFigureTypeKnight:
			figure = (self.figure.color == VDColorWhite) ? "\xe2\x99\x98" : "\xe2\x99\x9e";
			break;
		case VDFigureTypeBishop:
			figure = (self.figure.color == VDColorWhite) ? "\xe2\x99\x97" : "\xe2\x99\x9d";
			break;
		case VDFigureTypeRook:
			figure = (self.figure.color == VDColorWhite) ? "\xe2\x99\x96" : "\xe2\x99\x9c";
			break;
		case VDFigureTypeQueen:
			figure = (self.figure.color == VDColorWhite) ? "\xe2\x99\x95" : "\xe2\x99\x9b";
			break;
		case VDFigureTypeKing:
			figure = (self.figure.color == VDColorWhite) ? "\xe2\x99\x94" : "\xe2\x99\x9a";
			break;
		default:
			break;
	}
	
	//TODO: optimize!
	NSString *str = [NSString stringWithUTF8String:figure];
	NSDictionary *attr = @{NSFontAttributeName : [NSFont systemFontOfSize:30]};
	NSSize size = [str sizeWithAttributes:attr];

	NSSize boundsSize = self.bounds.size;
	NSRect drawRect = NSMakeRect((boundsSize.width - size.width) / 2, (boundsSize.height - size.height) / 2, size.width, size.height);
	drawRect = NSIntegralRect(drawRect);
	[str drawInRect:drawRect withAttributes:attr];
}

#pragma mark -

- (void)mouseDown:(NSEvent *)theEvent
{
	NSPoint point = [self convertPoint:[theEvent locationInWindow] fromView:nil];
	NSLog(@"mouseDown %@", NSStringFromPoint(point));
	[self.delegate figureViewDidSelect:self];
}

- (void)mouseUp:(NSEvent *)theEvent
{
	NSPoint point = [self convertPoint:[theEvent locationInWindow] fromView:nil];
	NSLog(@"mouseUp %@", NSStringFromPoint(point));
	[self.delegate figureView:self didLeftAtPoint:point];
}

//- (void)mouseMoved:(NSEvent *)theEvent
//{
//	NSPoint point = [self convertPoint:[theEvent locationInWindow] fromView:nil];
//	NSLog(@"mouseMoved %@", NSStringFromPoint(point));
//}
//
//- (void)mouseDragged:(NSEvent *)theEvent
//{
//	NSPoint point = [self convertPoint:[theEvent locationInWindow] fromView:nil];
//	NSLog(@"mouseDragged %@", NSStringFromPoint(point));
//}

@end
