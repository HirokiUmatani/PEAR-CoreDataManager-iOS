### PEAR-CoreDataManager-iOS [![GitHub license](https://img.shields.io/badge/LICENSE-MIT%20LICENSE-blue.svg)](https://github.com/HirokiUmatani/PEAR-CoreDataManager-iOS/LICENSE) [![CocoaPods](https://img.shields.io/badge/platform-ios-lightgrey.svg)](https://cocoapods.org/pods/PEAR-CoreDataManager-iOS) [![CocoaPods](https://img.shields.io/cocoapods/v/PEAR-CoreDataManager-iOS.svg)](https://cocoapods.org/pods/PEAR-CoreDataManager-iOS)  

====
### Overview
This ios library can be to create and manage the CoreData.

### Installation
<code>
pod 'PEAR-CoreDataManager-iOS'
</code>

### Usage
example:
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

□import header file
```
#import "CoreDataManager.h"
```

□initialize
```
[CoreDataManager initSettingWithCoreDataName:@"CoreDataManager"
                                  sqliteName:@"CoreDataSqlite"];
```

□insert
```
// create insert instance of CoreData
CDTestEntity *insertEntity = [CoreDataManager createInsertEntityWithClassName:@"CDTestEntity"];
    
// add value
insertEntity.num = @((uint)arc4random()%RAND_MAX);
insertEntity.name = @"test";
    
// save insert data
[CoreDataManager saveWithSuccess:^
{
    NSLog(@"success save");
}
                         failed:^(NSError *error)
{
    NSLog(@"%@",error);
}];
```

□update
```
I have created a method.
```

□fetch
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

□delete
```
I have created a method.
```
### Documents
[library document](http://cocoadocs.org/docsets/PEAR-CoreDataManager-iOS)

### Licence
[MIT](https://github.com/HirokiUmatani/PEAR-CoreDataManager-iOS/blob/master/LICENSE)

### Author
[Hiroki Umatani](https://github.com/HirokiUmatani)
