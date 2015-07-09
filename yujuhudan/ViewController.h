//
//  ViewController.h
//  yujuhudan
//
//  Created by miyamoto masaru on 2015/06/29.
//  Copyright (c) 2015年 com.miyamoto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tv;

@property NSMutableArray *cells;

- (IBAction)insertCell:(id)sender;
- (IBAction)deleteAll:(id)sender;

@end

