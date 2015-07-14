//
//  ViewController.m
//  yujuhudan
//
//  Created by miyamoto masaru on 2015/06/29.
//  Copyright (c) 2015年 com.miyamoto. All rights reserved.
//

#import "ViewController.h"


//RGB 256変換
#define RGB(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0];


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
- (void)updateCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    //Update Cells
    if(indexPath.row % 2 == 0){
        cell.backgroundColor = RGB(99, 220, 76);
    }else{
        cell.backgroundColor = RGB(152, 206, 0);
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
}

//表示されているセルの更新メソッド
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
        [self updateVisibleCells];
    }
}

//セルの背景色の変更
//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSLog(@"colorChange");
//    if(indexPath.row % 2 == 0){
//        cell.backgroundColor = [UIColor redColor];
//        //        cell.backgroundColor = [UIColor colorWithRed:99 green:188 blue:76 alpha:1.0];
//    }else{
//                cell.backgroundColor = [UIColor whiteColor];
//    }
//    //    cell.backgroundColor = self.tv.backgroundColor;
//}

- (void)setAlert
{
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"入力してください" message:nil delegate:self cancelButtonTitle:@"CANCEL" otherButtonTitles:@"OK", nil];
    [message setAlertViewStyle:UIAlertViewStylePlainTextInput];
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
    
    [self selectAlert:(int)[self.cells count]];
    
}

//結果の表示
- (void)selectAlert:(int)x
{
    UIAlertView *message;
    if(x == 0){

        message = [[UIAlertView alloc] initWithTitle:@"何かいれろや！！！" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        
    }else if(x == 1){
        //ランダム値の決定
        int random = arc4random() % x;
        
        NSString *str = [self.cells objectAtIndex:random];
        message = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@\nしかねーじゃねーか！！！",str] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    }else{
        //ランダム値の決定
        int random = arc4random() % x;
        
        NSString *str = [self.cells objectAtIndex:random];
        message = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"お前が欲しいのは\n%@ だ！！！",str] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    }
    //    [message setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [message show];
}

@end
