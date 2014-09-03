//
//  VDBoardView.h
//  ChessMAC
//
//  Created by Vladimir Deriglazov on 9/1/14.
//  Copyright (c) 2014 PMMedia. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "ChessEngine/VDField.h"

@class VDBoard, VDBoardView;

typedef enum : NSUInteger
{
    VDBoardOrientaionBottom,
    VDBoardOrientaionTop,
    VDBoardOrientaionLeft,
	VDBoardOrientaionRight,
} VDBoardOrientaion;

@protocol VDBoardViewDelegate <NSObject>

- (void)recalcFigureFramesOnBoard:(VDBoardView *)boardView;
- (void)clickOnField:(VDField)field board:(VDBoardView *)boardView;

@end


@interface VDBoardView : NSView

@property (nonatomic) VDBoardOrientaion orientation;
@property (nonatomic, strong) NSColor *whiteFieldColor;
@property (nonatomic, strong) NSColor *blackFieldColor;
@property (nonatomic, strong) NSColor *highlightFieldColor;

@property (nonatomic, weak) id<VDBoardViewDelegate> delegate;

- (NSSize)sizeForField;
- (NSRect)rectForField:(VDField)field;

@property (nonatomic, strong) NSSet *highlightedFields;

@end
