//
//  ViewController.m
//  JNPopoverViewControllerDemo
//
//  Created by Yigol on 16/5/21.
//  Copyright © 2016年 Injoinow. All rights reserved.
//

#import "ViewController.h"
#import "JNPopoverViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray *data;

@property (weak, nonatomic) IBOutlet UIButton *popButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.data = [NSArray arrayWithObjects:@"扫一扫",@"搜一搜",@"购物", nil];
}

- (IBAction)popAction:(id)sender {
    
    [self showPopWithSource:sender];
}

- (IBAction)leftbar:(id)sender {
    
    [self showPopWithSource:sender];
}

- (IBAction)rightBar:(id)sender {
    
    [self showPopWithSource:sender];
}

- (void)showPopWithSource:(id)source
{
    JNPopoverViewController *pop = [JNPopoverViewController popoverViewControllerWithSourceView:source dataSource:self.data popoverDidSelectBlock:^(NSInteger index) {
        
        NSLog(@"----- %ld",index);
        
        [self performSegueWithIdentifier:@"ddd" sender:nil];
    }];
    
//    pop.popoverArrowDirection = UIPopoverArrowDirectionLeft;
//    pop.cellHeight = 60;
    
    [self presentViewController:pop animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
