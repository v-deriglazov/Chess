//
//  VDField.h
//  ChessEngine
//
//  Created by Vladimir Deriglazov on 8/29/14.
//  Copyright (c) 2014 PMMedia. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSUInteger const kVDBoardSize;


typedef enum : NSUInteger
{
    VDColorWhite,
    VDColorBlack,
} VDColor;

struct VDField
{
	NSUInteger row;
	NSUInteger column;
};
typedef struct VDField VDField;

VDField VDFieldMake(NSUInteger row, NSUInteger col);

extern VDField VDFieldZero;

extern NSString *NSStringFromField(VDField field);
extern VDField VDFieldFromString(NSString *str);

extern VDColor VDFieldColor(VDField field);
extern BOOL VDFieldsAreEqual(VDField field1, VDField field2);

extern NSArray *HorizontalFieldsWithField(VDField field);
extern NSArray *VerticalFieldsWithField(VDField field);
extern NSArray *DiagonalsFieldsWithField(VDField field);
extern NSArray *NearbyFieldsToField(VDField field);
