//
//  ViewController.m
//  yujuhudan
//
//  Created by miyamoto masaru on 2015/06/29.
//  Copyright (c) 2015年 com.miyamoto. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cells = [NSMutableArray array];
    self.tv.dataSource = self;
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)insertCell:(id)sender
{
    [self setAlert];
    
}


- (IBAction)deleteAll:(id)sender
{
    self.cells = [NSMutableArray array];
    [self.tv reloadData];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.cells count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *tvcell = [tableView dequeueReusableCellWithIdentifier:@"cid"];
    if (tvcell == nil) {
        tvcell   = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:@"cid"];
    }
    
    tvcell.textLabel.text = [self.cells objectAtIndex: indexPath.row];
    return tvcell;
}

- (void)setAlert
{
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"入力してください" message:nil delegate:self cancelButtonTitle:@"CANCEL" otherButtonTitles:@"OK", nil];
    [message setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [message show];
}

- (void)dicisionAlert
{
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"この優柔普段\nやろうが！！" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
//    [message setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [message show];
}

- (BOOL)alertViewShouldEnableFirstOtherButton:(UIAlertView *)alertView
{
    NSString *inputText = [[alertView textFieldAtIndex:0]text];
    if ([inputText length] >= 1) {
        return YES;
    }else{
        return NO;
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        NSString *trip_title = [[alertView textFieldAtIndex:0]text];
//        [trip_title retain];
//        [self tripArea];
        
        [self.cells addObject: trip_title];
        [self.tv reloadData];
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        // 削除するコードを挿入します
        
        NSInteger row = [indexPath row];
        [self.cells removeObjectAtIndex: row];
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]  withRowAnimation:UITableViewRowAnimationFade];
        
    }
}

- (IBAction)btn:(id)sender {
    [self dicisionAlert];
}


@end
