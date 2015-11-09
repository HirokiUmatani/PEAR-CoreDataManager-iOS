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
@property (nonatomic,strong)CoreDataManager *coreDataManager;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // to create 1st call
    _coreDataManager =[CoreDataManager createSharedInstanceWithCoreDataName:@"CoreDataManager" sqliteName:@"CoreDataSqlite"];
    
    NSManagedObjectContext *managedObjectContext = [_coreDataManager managedObjectContext];
    NSLog(@"1 %@",_coreDataManager);
    
    for (int i =0; i< 1000000; i ++)
    {
        _coreDataManager = [CoreDataManager sharedInstance];
        
    }
    NSLog(@"2 %@",_coreDataManager);
   

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
