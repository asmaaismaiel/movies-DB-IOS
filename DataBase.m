//
//  DataBase.m
//  friends
//
//  Created by JETS on 2/11/18.
//  Copyright (c) 2018 JETS. All rights reserved.
//

#import "DataBase.h"

@implementation DataBase
- (id)init
{
    self = [super init];
    if (self) {
        NSString *docsDir;
        NSArray *dirPaths;
        
        // Get the documents directory
        dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        docsDir = dirPaths[0];
        // Build the path to the database file
        _databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent:@"favorite.db"]];
        const char *dbpath = [_databasePath UTF8String];
        if (sqlite3_open(dbpath, &_favoriteDB) == SQLITE_OK)
        {
            char *errMsg;
            const char *sql_stmt =
            "CREATE TABLE IF NOT EXISTS MYFAVORITES (ID INTEGER PRIMARY KEY AUTOINCREMENT, movie_id TEXT,TITLE TEXT, release_date TEXT, poster_path TEXT, overview TEXT,vote_average TEXT,trailer TEXT)";
            
            if (sqlite3_exec(_favoriteDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
            {
                _status = @"Failed to create table";
                printf("table not created\n");
            }else{
            
               // printf("table created\n");
            }
            sqlite3_close(_favoriteDB);
        } else {
            _status = @"Failed to open/create database";
            printf("database not created\n");
        }
    }
    return self;
}

-(int)insertfav:(NSString*)fid:(NSString*)ftitle:(NSString*)frelease_date:(NSString*)fposter_path:(NSString*)foverview:(NSString*)fvote_average:(NSString*)ftrailer{
    int found=0;
    int inserted=0;
    NSMutableArray *mylist=self.loadall;
    for (Movie *m in mylist) {
        if([[m title] isEqualToString:ftitle]){
            found=1;
            inserted=1;
            break;
        }
    }
    if(found==0){
        sqlite3_stmt *statement;
        const char *dbpath = [_databasePath UTF8String];
        if (sqlite3_open(dbpath, &_favoriteDB) == SQLITE_OK)
            {
                // NSString *insertSQL = @"INSERT INTO CONTACTS (name , age , phone) VALUES (\"adl\",\"123\",\"123\")";
        
                // NSString *insertSQL = @"INSERT INTO CONTACTS (name , age , phone) VALUES (\"adl\", \"122\",\"333\")";
                NSString *insertSQL = [NSString stringWithFormat:
                               @"INSERT INTO MYFAVORITES (movie_id,title, release_date, poster_path, overview ,vote_average ,trailer) VALUES (\"%@\",\"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\")",
                               fid,ftitle, frelease_date, fposter_path,foverview,fvote_average,ftrailer];
        
                //char *errMsg;
                const char *insert_stmt = [insertSQL UTF8String];
                if(sqlite3_prepare_v2(_favoriteDB, insert_stmt,
                           -1, &statement,NULL)!=SQLITE_OK)
                {
                    printf("%s" ,sqlite3_errmsg(_favoriteDB));
                    printf("sql string not ok\n");
                }
                if (sqlite3_step(statement) == SQLITE_DONE)
                {
                    _status = @"favorite added";
                    // printf("favorite added");
                    inserted=1;
                } else {
                    _status= @"Failed to add favorite";
                    printf("%s" ,sqlite3_errmsg(_favoriteDB));
                    printf("Failed to add favorite");
                    //printf(statement);
                }
        
                sqlite3_finalize(statement);
                sqlite3_close(_favoriteDB);
            }
    }
    return inserted;
}
-(NSMutableArray*)loadall{
    _myfavorites=[NSMutableArray new];
    const char *dbpath = [_databasePath UTF8String];
    sqlite3_stmt    *statement;
    
    if (sqlite3_open(dbpath, &_favoriteDB) == SQLITE_OK)
    {
        NSString *querySQL =@"SELECT movie_id,title , release_date , poster_path ,overview ,vote_average ,trailer FROM MYFAVORITES";
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(_favoriteDB,
                               query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            
            while(sqlite3_step(statement) == SQLITE_ROW)
            {
                Movie *m=[Movie new];
                NSString *idField = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                m.id=idField;
                NSString *titleField = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement,1)];
                //printf("%s",[nameField UTF8String]);
                m.title=titleField;
                NSString *release_dateField = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)];
                //printf("%d",[ageField intValue]);
                m.release_date=release_dateField;
                NSString *poster_pathField = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)];
                //printf("%s",[phoneField UTF8String]);
                m.poster_path=poster_pathField;
                 NSString *overviewField = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 4)];
                m.overview=overviewField;
                NSString *vote_averageField = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 5)];
                m.vote_average=vote_averageField;
                NSString *trailerField = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 6)];
                [_myfavorites addObject:m];
            } 
            sqlite3_finalize(statement);
        }
        sqlite3_close(_favoriteDB);
    }
    return _myfavorites;
}
-(void)removefavorite:(NSString*)fid{
    sqlite3_stmt *statement;
    const char *dbpath = [_databasePath UTF8String];
    if (sqlite3_open(dbpath, &_favoriteDB) == SQLITE_OK)
    {
        // NSString *insertSQL = @"INSERT INTO CONTACTS (name , age , phone) VALUES (\"adl\",\"123\",\"123\")";
        
        // NSString *insertSQL = @"INSERT INTO CONTACTS (name , age , phone) VALUES (\"adl\", \"122\",\"333\")";
        
        
        NSString *insertSQL = [NSString stringWithFormat:
                               @"DELETE FROM MYFAVORITES WHERE movie_id=\"%@\"",
                               fid];
        
        //char *errMsg;
        const char *insert_stmt = [insertSQL UTF8String];
        if(sqlite3_prepare_v2(_favoriteDB, insert_stmt,
                              -1, &statement,NULL)!=SQLITE_OK)
        {
            printf("%s" ,sqlite3_errmsg(_favoriteDB));
            printf("sql string not ok\n");
        }
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            _status = @"favorite deleted";
           // printf("favorite deleted");
        } else {
            _status= @"Failed to delete favorite";
            printf("Failed to delete favorite");
            //printf(statement);
        }
        sqlite3_finalize(statement);
        sqlite3_close(_favoriteDB);
    }
}
+(DataBase *)sharedInstance{
    static DataBase* sharedInstance=Nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate,^{sharedInstance=[DataBase new];});
    return sharedInstance;
}
@end
