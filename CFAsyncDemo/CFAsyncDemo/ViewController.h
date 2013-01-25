//
//  ViewController.h
//  CFAsyncDemo
//
//  Created by Constantine Fry on 1/25/13.
//  Copyright (c) 2013 Constantine Fry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{
    NSArray *_imageURLs;
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
