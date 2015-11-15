### PEAR-CoreDataManager-iOS [![GitHub license](https://img.shields.io/badge/LICENSE-MIT%20LICENSE-blue.svg)](https://github.com/HirokiUmatani/PEAR-CoreDataManager-iOS/LICENSE) [![CocoaPods](https://img.shields.io/badge/platform-ios-lightgrey.svg)](https://cocoapods.org/pods/PEAR-CoreDataManager-iOS) [![CocoaPods](https://img.shields.io/cocoapods/v/PEAR-CoreDataManager-iOS.svg)](https://cocoapods.org/pods/PEAR-CoreDataManager-iOS)  

====
### Overview
This ios library can be to create and manage the CoreData.
### Demo
![autolayout_demo](http://pear.chat/image/coredata-demo-o.gif)

### Installation
<code>
pod 'PEAR-CoreDataManager-iOS'
</code>

### Usage
[example]    
Data model : CoreDataManager.xcdatamodeld  
Entity model : CDTestEntity  
attribute : type of Entity    
id   : integer64   
num  : integer64  
name : String   

1. Create data model <.xcdatamodeld>
2. Create entity model in data model
3. Create attribute & type in entity model
4. Create entity class <.h.m>

#### □ import header file
```
#import "CoreDataManager.h"
```

#### □ initialize
```
[CoreDataManager initSettingWithCoreDataName:@"CoreDataManager"
                                  sqliteName:@"CoreDataSqlite"];
```

#### □ insert
```
// create insert instance of CoreData
CDTestEntity *insertEntity = [CoreDataManager createInsertEntityWithClassName:@"CDTestEntity"];
    
// add value
insertEntity.num = @((uint)arc4random()%RAND_MAX);
insertEntity.name = @"test";
    
// save insert data
[CoreDataManager save];
```

#### □ update
```
// search condition
    NSPredicate *pred = [_coreDataManager setPredicateOverWithSearchKey:@"id" searchValue:@(0)];
    // fetch data
    [_coreDataManager fetchWithEntity:TEST_ENTITY
                            Predicate:pred
                              success:^(NSArray *fetchLists)
    {
        // update
        for (CDTestEntity *updateEntity in fetchLists)
        {
            updateEntity.name = @"update_test";
            [_coreDataManager save];
        }
    }
                               failed:^(NSError *error)
    {
        
    }];
```

#### □ fetch
```
// fetch all data
[CoreDataManager fetchWithEntity:@"CDTestEntity"
                       Predicate:nil
                         success:^(NSArray *fetchLists)
{
    // parse
    for (CDTestEntity *fetchEntity in fetchLists)
    {
         // access property of fetchEnity    
    }
}
                          failed:^(NSError *error)
{
}];
```

#### □ delete
```
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
```

### Documents
[library document](http://cocoadocs.org/docsets/PEAR-CoreDataManager-iOS)

### Licence
[MIT](https://github.com/HirokiUmatani/PEAR-CoreDataManager-iOS/blob/master/LICENSE)

### Author
[Hiroki Umatani](https://github.com/HirokiUmatani)
