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

    // to create 1st call
    CoreDataManager *coreDataManager =[CoreDataManager createSharedInstanceWithCoreDataName:@"CoreDataManager" sqliteName:@"CoreDataSqlite"];
    
    NSManagedObjectContext *managedObjectContext = [coreDataManager managedObjectContext];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
