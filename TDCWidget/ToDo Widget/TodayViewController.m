//
//  TodayViewController.m
//  ToDo Widget
//
//  Created by Fernando Bunn on 5/8/16.
//  Copyright © 2016 iDevzilla. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import "DataHandler.h"

#define ROW_HEIGHT 44

@interface TodayViewController () <NCWidgetProviding>

@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, assign) UIEdgeInsets defaultMarginInsets;

@end

@implementation TodayViewController


#pragma mark - Initialization Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([self class])];
    self.tableView.scrollEnabled = NO;
    self.tableView.rowHeight = ROW_HEIGHT;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupData];
    [self.tableView reloadData];
    [self updatePreferredContentSize];
}


#pragma mark - Internal Methods

- (void)setupData {
    self.items = [[NSMutableArray alloc] initWithArray:[DataHandler sharedData]];
}

- (void)removeItemAtIndex:(NSIndexPath *)indexPath {
    [self.items removeObjectAtIndex:indexPath.row];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self updatePreferredContentSize];
    [DataHandler updateDataWithArray:self.items];
}

- (void)updatePreferredContentSize {
    [self setPreferredContentSize:CGSizeMake(self.view.frame.size.width, (self.items.count * ROW_HEIGHT))];
}

- (void)configureCellSelectionStyle:(UITableViewCell *)cell {
    UIVibrancyEffect *effect = [UIVibrancyEffect notificationCenterVibrancyEffect];
    
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    effectView.frame = cell.contentView.bounds;
    
    UIView *view = [[UIView alloc] initWithFrame:effectView.bounds];
    view.backgroundColor = self.tableView.separatorColor;
    view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [effectView.contentView addSubview:view];
    cell.selectedBackgroundView = effectView;
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
}


#pragma mark - UITableViewDataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class]) forIndexPath:indexPath];
    cell.textLabel.text = self.items[indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.separatorInset = UIEdgeInsetsMake(0, self.defaultMarginInsets.left, 0, self.defaultMarginInsets.right);
    
    [self configureCellSelectionStyle:cell];
    
    return cell;
}


#pragma mark - UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self removeItemAtIndex:indexPath];
}


#pragma mark - NCWidgetProviding Methods

- (UIEdgeInsets)widgetMarginInsetsForProposedMarginInsets:(UIEdgeInsets)defaultMarginInsets {
    _defaultMarginInsets = defaultMarginInsets;
    
    // Let's handle the margin on our tableView
    defaultMarginInsets.left = 0;
    return defaultMarginInsets;
}

/*
 Implement this if you want to fetch content and update your widget in the background
 In our case, since the content is always local, there's no need to implement this method since we load it on viewWillAppear.
- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData
    
    completionHandler(NCUpdateResultNoData);
}
*/

@end
