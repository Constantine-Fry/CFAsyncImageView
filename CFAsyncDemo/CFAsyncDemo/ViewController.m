//
//  ViewController.m
//  CFAsyncDemo
//
//  Created by Constantine Fry on 1/25/13.
//  Copyright (c) 2013 Constantine Fry. All rights reserved.
//

#import "ViewController.h"
#import "AsyncCell.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _imageURLs = @[@"https://dl.dropbox.com/u/1378133/CFAsyncImages/1.png",
                   @"https://dl.dropbox.com/u/1378133/CFAsyncImages/2.png",
                   @"https://dl.dropbox.com/u/1378133/CFAsyncImages/3.png",
                   @"https://dl.dropbox.com/u/1378133/CFAsyncImages/4.png",
                   @"https://dl.dropbox.com/u/1378133/CFAsyncImages/5.png",
                   @"https://dl.dropbox.com/u/1378133/CFAsyncImages/6.png",
                   @"https://dl.dropbox.com/u/1378133/CFAsyncImages/7.png"];
    UINib *nib = [UINib nibWithNibName:@"AsyncCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"AsyncCell"];
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* key = @"AsyncCell";
    AsyncCell *cell = [tableView dequeueReusableCellWithIdentifier:key];
    cell.text.text = [NSString stringWithFormat:@"%d",indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [cell.asyncImage loadImageFromURL:_imageURLs[indexPath.row]
                      withPlaceholder:[UIImage imageNamed:@"placeholder.png"]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"http://instagram.com/appledeveloper/"]];
}


@end
