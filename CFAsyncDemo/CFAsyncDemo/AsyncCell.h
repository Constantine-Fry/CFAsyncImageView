//
//  AsyncCell.h
//  CFAsyncDemo
//
//  Created by Constantine Fry on 1/25/13.
//  Copyright (c) 2013 Constantine Fry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CFAsyncImageView.h"

@interface AsyncCell : UITableViewCell

@property (strong, nonatomic) IBOutlet CFAsyncImageView *asyncImage;
@property (strong, nonatomic) IBOutlet UILabel *text;

@end
