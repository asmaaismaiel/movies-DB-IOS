//
//  Movie.h
//  lab2
//
//  Created by IOS OS on 3/1/18.
//  Copyright © 2018 IOS OS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
@interface Movie : JSONModel


@property (nonatomic) NSString* poster_path;
@property (nonatomic) NSString* overview;
@property (nonatomic) NSString* release_date;
@property (nonatomic) NSString* id;
@property (nonatomic) NSString* title;
@property (nonatomic) NSString* vote_average;

@end
