//
//  VDFigureView.h
//  ChessMAC
//
//  Created by Vladimir Deriglazov on 9/1/14.
//  Copyright (c) 2014 PMMedia. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class VDFigure, VDFigureView;

@protocol VDFigureViewDelegate <NSObject>

- (void)figureViewDidSelect:(VDFigureView *)figureView;
- (void)figureView:(VDFigureView *)figureView didLeftAtPoint:(NSPoint)point;

@end


@interface VDFigureView : NSView

@property (nonatomic, weak) VDFigure *figure;
@property (nonatomic, weak) id<VDFigureViewDelegate> delegate;

@end
