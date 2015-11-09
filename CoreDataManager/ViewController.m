//
//  ViewController.m
//  CoreDataManager
//
//  Created by hirokiumatani on 2015/11/09.
//  Copyright © 2015年 hirokiumatani. All rights reserved.
//

#import "ViewController.h"
#import "CoreDataManager.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CoreDataManager *coreDataManager =[CoreDataManager sharedInstanceWithCoreDataName:@"CoreDataManager" sqliteName:@"CoreDataSqlite"];
    [coreDataManager managedObjectContext];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
