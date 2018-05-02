//
//  MovieAPI.m
//  lab2
//
//  Created by Sara Ashraf on 2/27/18.
//  Copyright © 2018 Sara Ashraf. All rights reserved.
//

#import "MovieAPI.h"

@implementation MovieAPI{

   
}
const NSString* API_KEY = @"13a6bbc7233618c21fc7fe6cff6411cb";
const NSString* MOVIE_API_BASE_UTL = @"https://api.themoviedb.org/3/movie/";
const NSString* QUERY = @"?";
const NSString* QUERY_KEY = @"api_key=";
const NSString* QUERY_LANG_AND_PAGES = @"&language=en-US&page=1";
const NSString* IMAGE_PATH = @"https://image.tmdb.org/t/p/w185/";




+(NSString*) GET_POPULAR_MOVIES_URL{
    NSString* popularDir = @"popular";
    popularDir = [MOVIE_API_BASE_UTL stringByAppendingString:popularDir];
    popularDir = [popularDir stringByAppendingString:QUERY];
    popularDir = [popularDir stringByAppendingString:QUERY_KEY];
    popularDir = [popularDir stringByAppendingString:API_KEY];
    popularDir = [popularDir stringByAppendingString:QUERY_LANG_AND_PAGES];
    return popularDir;
}

+(NSString*) GET_TOP_RATED_MOVIES_URL{
    NSString* popularDir = @"top_rated";
    popularDir = [MOVIE_API_BASE_UTL stringByAppendingString:popularDir];
    popularDir = [popularDir stringByAppendingString:QUERY];
    popularDir = [popularDir stringByAppendingString:QUERY_KEY];
    popularDir = [popularDir stringByAppendingString:API_KEY];
    popularDir = [popularDir stringByAppendingString:QUERY_LANG_AND_PAGES];
    return popularDir;
}

+(NSString*) GET_MOVIE_IMAGE_PATH_With_Image:(NSString*)image {
    return [IMAGE_PATH stringByAppendingString:image];
}





+(NSString*) GET_MOVIE_TRAILERS_PATH:(NSString*)movieId{
    
    NSString* trailersURL = @"";
    trailersURL = [MOVIE_API_BASE_UTL stringByAppendingString:movieId];
    trailersURL = [trailersURL stringByAppendingString:@"/videos"];
    trailersURL = [trailersURL stringByAppendingString:QUERY];
    trailersURL = [trailersURL stringByAppendingString:QUERY_KEY];
    trailersURL = [trailersURL stringByAppendingString:API_KEY];
    trailersURL = [trailersURL stringByAppendingString:@"&language=en-US"];
    
    
    
    return trailersURL;
}


+(NSString*) GET_YOUTUBE_PATH_FOR_KEY:(NSString*)key{
    
    
    NSString *string = [NSString stringWithFormat:@"http://www.youtube.com/watch?v=%@", key];
    
    
    // NSURL *url = [NSURL URLWithString:string];
    //  UIApplication *app = [UIApplication sharedApplication];
    // [app openURL:url];
    
    return string;
    
}

+(NSString*) GET_MOVIE_REVIEWS_PATH:(NSString*)movieId{
    NSString* reviewsURL=@"";
    reviewsURL=[MOVIE_API_BASE_UTL stringByAppendingString:movieId];
    reviewsURL=[reviewsURL stringByAppendingString:@"/reviews"];
    reviewsURL=[reviewsURL stringByAppendingString:QUERY];
    reviewsURL=[reviewsURL stringByAppendingString:QUERY_KEY];
    reviewsURL=[reviewsURL stringByAppendingString:API_KEY];
    reviewsURL=[reviewsURL stringByAppendingString:@"&language=en-US"];
    return reviewsURL;
}



@end
