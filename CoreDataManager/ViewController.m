//
//  ViewController.m
//  CoreDataManager
//
//  Created by hirokiumatani on 2015/11/09.
//  Copyright © 2015年 hirokiumatani. All rights reserved.
//

#import "ViewController.h"
#import "CoreDataManager.h"
#import "CDtestEntity.h"



@interface ViewController ()
@property CoreDataManager *coreDataManager;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // initial
    [CoreDataManager initSettingWithCoreDataName:@"CoreDataManager"
                                      sqliteName:@"CoreDataSqlite"];
    
    // insert
    CDtestEntity *insertTestEntity = [CoreDataManager createInsertEntityWithClassName:@"CDtestEntity"];
    insertTestEntity.num = @(5);
    [CoreDataManager saveWithSuccess:^
    {
        
    }
                   failed:^(NSError *error)
    {
        
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
