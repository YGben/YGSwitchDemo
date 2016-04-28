//
//  YGLabel.m
//  text
//
//  Created by BEN on 16/4/12.
//  Copyright © 2016年 Ben. All rights reserved.
//

#import "YGLabel.h"

@implementation YGLabel
//#define   BACK_COLOR  [UIColor colorWithRed:206.0/225 green:10.0/225 blue:134.0/225 alpha:01]
- (instancetype)initWithFrame:(CGRect)frame
{
    if ( self=[super initWithFrame:frame] ) {
        self.textAlignment = NSTextAlignmentCenter;
        self.font = [UIFont systemFontOfSize:18];
        self.showColor = NO;
    }
    return self;
}
- (void)setShowColor:(BOOL)showColor{
    if (showColor) {
        self.textColor = BACK_COLOR;

    }else{
        self.textColor = [UIColor grayColor];
    }
}
@end
