//
//  comHistoryTableViewController.m
//  BMI Calculator
//
//  Created by Jan Damek on 26.12.13.
//  Copyright (c) 2013 Jan Damek. All rights reserved.
//

#import "comHistoryTableViewController.h"
#import "comHistoryCell.h"
#import "comAppDelegate.h"
#import "Entrys.h"

@interface comHistoryTableViewController ()

@property (nonatomic, strong, getter = getD) comAppDelegate *d;

@end

@implementation comHistoryTableViewController

@synthesize d = _d;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.clearsSelectionOnViewWillAppear = NO;
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.canDisplayBannerAds = true;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.navigationController setToolbarHidden:NO];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setToolbarHidden:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.d.data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"historyCell";
    comHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    Entrys *e = (self.d.data)[indexPath.row];
    
    cell.lblDate.text =   [NSString stringWithFormat:@"%@", [e dateString] ];
    cell.lblHeight.text = [NSString stringWithFormat:@"%d", e.height];
    cell.lblWeight.text = [NSString stringWithFormat:@"%.01f", e.wheith];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.d.data removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

-(comAppDelegate *)getD{
    if (!_d) {
        _d = (comAppDelegate*)[[UIApplication sharedApplication] delegate];
    }
    return _d;
}

@end
