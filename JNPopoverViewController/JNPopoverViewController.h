//
//  JNPopoverViewController.h
//  JNPopoverViewControllerDemo
//
//  Created by Yigol on 16/5/21.
//  Copyright © 2016年 Injoinow. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  @brief pop中点击cell的回调
 *
 *  @param index cell 的 index
 */
typedef void(^JNPopoverDidSelectCallback)(NSInteger index);

@interface JNPopoverViewController : UIViewController

/**
 *  @brief cell的高度，默认 40；
 */
@property (nonatomic, assign) CGFloat cellHeight;

/**
 *  @brief 气泡的箭头方向 默认 UIPopoverArrowDirectionUp 箭头向上
 */
@property (nonatomic, assign) UIPopoverArrowDirection popoverArrowDirection;

/**
 *  @brief 创建气泡视图
 *
 *  @param sourceView  点击的对象 UIBarButtonItem 或者 UIView
 *  @param dataSource  气泡的数据源
 *  @param selectBlock 点击气泡cell的回调
 *
 *  @return JNPopoverViewController
 */
+ (instancetype)popoverViewControllerWithSourceView:(id)sourceView
                                         dataSource:(NSArray *)dataSource
                              popoverDidSelectBlock:(JNPopoverDidSelectCallback)selectBlock;


@end
