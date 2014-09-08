//
//  VDMove.h
//  ChessEngine
//
//  Created by Vladimir Deriglazov on 9/3/14.
//  Copyright (c) 2014 PMMedia. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "VDField.h"

@class VDBoard, VDFigure;

@interface VDMove : NSObject

+ (id)moveOnBoard:(VDBoard *)board figure:(VDFigure *)figure toField:(VDField)field;

@property (nonatomic, weak) VDBoard *board;
@property (nonatomic, weak) VDFigure *figure;
@property (nonatomic) VDField from;
@property (nonatomic) VDField to;
@property (nonatomic) BOOL figWasMoved;
@property (nonatomic, strong) VDFigure *killedFigure; // enemy figure or pawn on the 8/1 row

@property (nonatomic) BOOL castle;
@property (nonatomic) BOOL longCastle;

@property (nonatomic, weak) VDFigure *appearedFigure; // after move pawn on the 8/1 row

@property (nonatomic) BOOL check;
@property (nonatomic) BOOL checkMate;

@property (nonatomic, readonly) NSString *fullDescription;

@end
