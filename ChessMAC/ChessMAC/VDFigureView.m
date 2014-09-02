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
	NSString *str = [NSString stringWithUTF8String:figure];
	[str drawInRect:self.bounds withAttributes:nil];
}

@end
