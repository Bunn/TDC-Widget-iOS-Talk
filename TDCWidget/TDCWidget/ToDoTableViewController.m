//
//  ToDoTableViewController.m
//  TDCWidget
//
//  Created by Fernando Bunn on 5/8/16.
//  Copyright © 2016 iDevzilla. All rights reserved.
//

#import "ToDoTableViewController.h"
#import "RandomItemGenerator.h"
#import "DataHandler.h"

@interface ToDoTableViewController ()

@property (nonatomic, strong) NSMutableArray *items;

@end

@implementation ToDoTableViewController


#pragma mark - Initialization Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Super Useful ToDo List";
    [self setupData];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([self class])];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewRandomItem)];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.backgroundColor = [UIColor colorWithRed:0.90 green:0.91 blue:0.93 alpha:1.0];
    self.tableView.rowHeight = 44;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didBecomeActiveNotificationHandler) name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - Data Handling Methods

- (void)didBecomeActiveNotificationHandler {
    [self setupData];
    [self.tableView reloadData];
}

- (void)setupData {
    self.items = [[NSMutableArray alloc] initWithArray:[DataHandler sharedData]];
}

- (void)addNewRandomItem {
    [self.items addObject:[RandomItemGenerator newItem]];
    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.items.count - 1 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    [DataHandler updateDataWithArray:self.items];
}

- (void)removeItemAtIndex:(NSIndexPath *)indexPath {
    [self.items removeObjectAtIndex:indexPath.row];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [DataHandler updateDataWithArray:self.items];
}


#pragma mark - UITableViewDataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class]) forIndexPath:indexPath];
    cell.textLabel.text = self.items[indexPath.row];
    return cell;
}


#pragma mark - UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self removeItemAtIndex:indexPath];
}


@end
