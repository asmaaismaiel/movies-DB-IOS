//
//  MovieAPI.h
//  lab2
//
//  Created by IOS OS on 3/1/18.
//  Copyright © 2018 IOS OS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieAPI : NSObject
+(NSString*) GET_TOP_RATED_MOVIES_URL;
+(NSString*) GET_POPULAR_MOVIES_URL;
+(NSString*) GET_MOVIE_IMAGE_PATH_With_Image:(NSString*)image;
+(NSString*) GET_YOUTUBE_PATH_FOR_KEY:(NSString*)key;
+(NSString*) GET_MOVIE_TRAILERS_PATH:(NSString*)movieId;
+(NSString*) GET_MOVIE_REVIEWS_PATH:(NSString*)movieId;
@end
