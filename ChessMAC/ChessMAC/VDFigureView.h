//
//  VDFigureView.h
//  ChessMAC
//
//  Created by Vladimir Deriglazov on 9/1/14.
//  Copyright (c) 2014 PMMedia. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class VDFigure;

@interface VDFigureView : NSView
@property (nonatomic, weak) VDFigure *figure;
@end
