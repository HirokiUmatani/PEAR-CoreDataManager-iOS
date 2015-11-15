//
//  ViewController.m
//  CoreDataManager
//
//  Created by hirokiumatani on 2015/11/09.
//  Copyright © 2015年 hirokiumatani. All rights reserved.
//

/******************
      import
 ******************/
#import "ViewController.h"
#import "CoreDataManager.h"
#import "CDTestEntity.h"

@interface ViewController ()
#define TEST_ENTITY @"CDTestEntity"
/******************
      property
 ******************/

// CoreData managed class
@property (nonatomic,strong) CoreDataManager *coreDataManager;
// view data
@property (nonatomic,strong) NSString *logString;
// IBOutlet
@property (weak, nonatomic) IBOutlet UITextView *textLabel;

/******************
      Method
 ******************/
// Sample method
- (void)initialSmaple;
- (void)insertSmaple;
- (void)fetchSample;

// IBAction
- (IBAction)tapInsertButton:(UIButton *)sender;
- (IBAction)tapAllDeleteButton:(UIButton *)sender;
@end

@implementation ViewController
#pragma mark - Life cycle
- (void)viewDidLoad
{
    
    [super viewDidLoad];
    [self initialSmaple];
    [self fetchSample];
}

#pragma mark - UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    return NO;
}

#pragma mark - private
- (void)initialSmaple
{
    // initialize CoreData
    [CoreDataManager initSettingWithCoreDataName:@"CoreDataManager"
                                      sqliteName:@"CoreDataSqlite"];
    _coreDataManager = [CoreDataManager sharedInstance];
}
- (void)insertSmaple
{
    // create insert instance of CoreData
    CDTestEntity *insertEntity = [_coreDataManager createInsertEntityWithClassName:TEST_ENTITY];
    
    // set auto increment id
    [_coreDataManager autoIncrementIDWithEntityClass:TEST_ENTITY
                                            success:^(NSInteger new_create_id)
     {
         insertEntity.id = @(new_create_id);
     }
                                                  failed:^(NSError *error)
     {
         
     }];
    
    // add etcetera value
    insertEntity.num = @((uint)arc4random()%RAND_MAX);
    insertEntity.name = @"test";
    
    // save insert data
    [_coreDataManager save];
}

- (void)fetchSample
{
    // fetch all data
    [_coreDataManager fetchWithEntity:TEST_ENTITY
                           Predicate:nil
                             success:^(NSArray *fetchLists)
     {
         // display the data
         _logString = @" id | num | name ";
         for (CDTestEntity *fetchEntity in fetchLists)
         {
             _logString = [NSString stringWithFormat:@" %@ | %@ | %@ \n%@",fetchEntity.id,fetchEntity.num,fetchEntity.name,_logString];
         }
        
     }
                              failed:^(NSError *error)
     {
         
     }];
    _textLabel.text =[NSString stringWithFormat:@"%@\n\n%@",@" id | num | name", _logString];
}

- (void)deleteSample
{
    // fetch all data
    [_coreDataManager fetchWithEntity:TEST_ENTITY
                            Predicate:nil
                              success:^(NSArray *fetchLists)
    {
        // delete entity
        for (CDTestEntity *deleteEntity in fetchLists)
        {
            [_coreDataManager deleteWithEntity:deleteEntity];
        }
        
    }
                               failed:^(NSError *error)
    {
        
    }];
}
- (IBAction)tapInsertButton:(UIButton *)sender
{
    [self insertSmaple];
    [self fetchSample];
    
}

- (IBAction)tapAllDeleteButton:(UIButton *)sender
{
    [self deleteSample];
    [self fetchSample];
}

@end
