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


//セルの更新
- (void)updateCell:(UITableView *)cell atIndexPath:(NSIndexPath *)indexPath
{
    //Update Cells
    cell.backgroundColor = [UIColor colorWithRed:0.39 green:0.73 blue:0.3 alpha:1.0];
//    cell.backgroundColor = [UIColor colorWithRed:99 green:0 blue:76 alpha:1.0];
//    cell.backgroundColor = [UIColor redColor];
}

- (void)updateVisibleCells
{
    NSLog(@"visible update");
    for (UITableViewCell *cell in [self.tv visibleCells]){
        [self updateCell:cell atIndexPath:[self.tv indexPathForCell:cell]];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.cells count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cellfor");

    UITableViewCell *tvcell = [tableView dequeueReusableCellWithIdentifier:@"cid"];
    if (tvcell == nil) {
        tvcell   = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:@"cid"];
    }
    
    tvcell.textLabel.text = [self.cells objectAtIndex: indexPath.row];
    
    return tvcell;
}

//削除可能にする
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

//セルの背景色の変更
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"colorChange");
    if(indexPath.row % 2 == 0){
        cell.backgroundColor = [UIColor redColor];
        //        cell.backgroundColor = [UIColor colorWithRed:99 green:188 blue:76 alpha:1.0];
    }else{
                cell.backgroundColor = [UIColor whiteColor];
    }
    //    cell.backgroundColor = self.tv.backgroundColor;
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
//    NSLog(@"shouldenable");
    NSString *inputText = [[alertView textFieldAtIndex:0]text];
    if ([inputText length] >= 1) {
        return YES;
    }else{
        return NO;
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"clickedButton");
    if (buttonIndex == 1) {
        NSString *trip_title = [[alertView textFieldAtIndex:0]text];
//        [trip_title retain];
//        [self tripArea];
        [self.cells addObject: trip_title];
        [self.tv reloadData];
        [self updateVisibleCells];
    }
}



- (IBAction)btn:(id)sender {
    [self dicisionAlert];
}


@end
