//
//  DataBase.h
//  friends
//
//  Created by JETS on 2/11/18.
//  Copyright (c) 2018 JETS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "Movie.h"
@interface DataBase : NSObject
@property (strong , nonatomic) NSString *databasePath;
@property (nonatomic) sqlite3 *favoriteDB;
@property NSString *status;
@property NSMutableArray *myfavorites;
-(int)insertfav:(NSString*)fid:(NSString*)ftitle:(NSString*)frelease_date:(NSString*)fposter_path:(NSString*)foverview:(NSString*)fvote_average:(NSString*)ftrailer;
-(NSMutableArray*)loadall;
-(void)removefavorite:(NSString*)fid;
+(DataBase*) sharedInstance;
@end
