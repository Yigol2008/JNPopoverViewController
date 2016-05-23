//
//  JNPopoverViewController.m
//  JNPopoverViewControllerDemo
//
//  Created by Yigol on 16/5/21.
//  Copyright © 2016年 Injoinow. All rights reserved.
//

#import "JNPopoverViewController.h"

//cell ID
static NSString *const cellId = @"cellId";
//默认宽度
static CGFloat const kPreferredContentWidth = 100;

@interface JNPopoverViewController ()<UITableViewDelegate, UITableViewDataSource, UIPopoverPresentationControllerDelegate>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) NSArray *dataSource;
@property (nonatomic, weak) id tempSourceView;
@property (nonatomic, copy) JNPopoverDidSelectCallback block;

@end

@implementation JNPopoverViewController


#pragma mark - ************ Life cycle
+ (instancetype)popoverViewControllerWithSourceView:(id)sourceView
                                         dataSource:(NSArray *)dataSource
                              popoverDidSelectBlock:(JNPopoverDidSelectCallback)selectBlock
{
    return [[self alloc] initPopoverViewControllerWithSourceView:sourceView dataSource:dataSource popoverDidSelectBlock:selectBlock];
}

- (instancetype)initPopoverViewControllerWithSourceView:(id)sourceView
                                         dataSource:(NSArray *)dataSource
                              popoverDidSelectBlock:(JNPopoverDidSelectCallback)selectBlock
{
    if (self = [super init]) {
        self.dataSource = dataSource;
        self.block = selectBlock;
        self.tempSourceView = sourceView;
        
        self.modalPresentationStyle = UIModalPresentationPopover;
        self.popoverPresentationController.delegate = self;
        self.popoverPresentationController.backgroundColor = [UIColor whiteColor];
        self.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUp;
        
        if ([sourceView isKindOfClass:[UIBarButtonItem class]]) {
            self.popoverPresentationController.barButtonItem = sourceView;
        } else if ([sourceView isKindOfClass:[UIView class]]) {
            self.popoverPresentationController.sourceView = sourceView;
            self.popoverPresentationController.sourceRect = ((UIView *)sourceView).bounds;
        } else {
            NSLog(@"不能被使用的sourceView类型：%@",[sourceView class]);
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.popoverArrowDirection) {
        if ([self.tempSourceView isKindOfClass:[UIView class]]) {
            self.popoverPresentationController.permittedArrowDirections = self.popoverArrowDirection;
        }
    }
    
    UITableView *tab = [[UITableView alloc] init];
    tab.rowHeight = self.cellHeight ? self.cellHeight : 40;
    tab.delegate = self;
    tab.dataSource = self;
    tab.scrollEnabled = NO;
    tab.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:tab];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:tab
                                                          attribute:NSLayoutAttributeLeading
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeLeading
                                                         multiplier:1
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:tab attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:tab attribute:NSLayoutAttributeTrailing
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeTrailing
                                                         multiplier:1
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:tab attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1
                                                           constant:0]];
    self.tableView = tab;
}

#pragma mark - ************ property
- (CGSize)preferredContentSize
{
    return CGSizeMake(kPreferredContentWidth, self.dataSource.count * self.tableView.rowHeight);
}

#pragma mark - ************ UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    if (self.dataSource.count) {
        cell.textLabel.text = self.dataSource[indexPath.row];
    }
    
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}

#pragma mark - ************ UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
    if (self.block) {
        self.block(indexPath.row);
    }
}

#pragma mark - ************ UIAdaptivePresentationControllerDelegate
- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller
{
    return UIModalPresentationNone;
}

#pragma mark - ************ TableView分割线
-(void)viewDidLayoutSubviews
{
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

//#pragma mark - ************ setter && getter
//- (void)setCellHeight:(CGFloat)cellHeight
//{
//    _cellHeight = cellHeight;
//    
//    cHeight = cellHeight;
//}

@end
