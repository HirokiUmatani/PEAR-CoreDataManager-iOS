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
}
- (void)insertSmaple
{
    // create insert instance of CoreData
    CDTestEntity *insertEntity = [CoreDataManager createInsertEntityWithClassName:@"CDTestEntity"];
    
    // set auto increment id
    [CoreDataManager autoIncrementIDWithEntityClass:@"CDTestEntity"
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
    [CoreDataManager saveWithSuccess:^
     {
         NSLog(@"success save");
     }
                              failed:^(NSError *error)
     {
         
     }];
}

- (void)fetchSample
{
    // fetch all data
    [CoreDataManager fetchWithEntity:@"CDTestEntity"
                           Predicate:nil
                             success:^(NSArray *fetchLists)
     {
         // display the data
         _logString = @"id | num | name";
         for (CDTestEntity *fetchEntity in fetchLists)
         {
             _logString = [NSString stringWithFormat:@"%@\n%@ | %@ | %@",_logString,fetchEntity.id,fetchEntity.num,fetchEntity.name];
         }
        
     }
                              failed:^(NSError *error)
     {
         
     }];
    _textLabel.text = _logString;
}

- (IBAction)tapInsertButton:(UIButton *)sender
{
    [self insertSmaple];
    [self fetchSample];
    
}

@end
