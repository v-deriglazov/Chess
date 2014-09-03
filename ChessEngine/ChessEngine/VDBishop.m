//
//  VDBishop.m
//  ChessEngine
//
//  Created by Vladimir Deriglazov on 8/29/14.
//  Copyright (c) 2014 PMMedia. All rights reserved.
//

#import "VDBishop.h"

@implementation VDBishop

- (NSSet *)possibleMoves
{
	return [NSSet setWithArray:DiagonalsFieldsWithField(self.field, NO)];
}

- (NSString *)letter
{
	return @"B";
}

- (CGFloat)price
{
	return 2;
}

@end
