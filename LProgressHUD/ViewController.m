//
//  ViewController.m
//  LProgressHUD
//
//  Created by Lester on 16/8/12.
//  Copyright © 2016年 Lester. All rights reserved.
//

#import "ViewController.h"
#import "LActivityTool.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) LActivityTool *tool;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tool = [[LActivityTool alloc]initWithView:self.view];
    [self.view addSubview:self.tableView];
}

#pragma mark - 懒加载
- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}
- (NSArray *)data{
    return @[@"ShowPullIndicatorView",@"Success",@"Fail",@"Loding"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *Identifier = @"leizi_lz@163.com";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:Identifier];
    }
    cell.textLabel.text = self.data[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==0){
        [self.tool showPullIndicatorView];
        [self performSelector:@selector(kao) withObject:nil afterDelay:3];
    }
    else if (indexPath.row==1){
        [self.tool showSuccessWithMessage:@"加载成功" duration:2.0];
    }
    else if(indexPath.row==2){
        [self.tool showErrorWithMessage:@"加载失败" duration:2.0];
    }
    else if (indexPath.row==3){
        [self.tool showIndeterminateWithMessage:@"上传中..." duration:2.0];
    }
}
- (void)kao{
    [self.tool hide];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
