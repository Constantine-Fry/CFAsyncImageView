//
//  AsyncCell.m
//  CFAsyncDemo
//
//  Created by Constantine Fry on 1/25/13.
//  Copyright (c) 2013 Constantine Fry. All rights reserved.
//

#import "AsyncCell.h"

@implementation AsyncCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
