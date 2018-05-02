//
//  HomeCollection.m
//  movies
//
//  Created by IOS OS on 3/1/18.
//  Copyright © 2018 IOS OS. All rights reserved.
//

#import "HomeCollection.h"
#import "MovieAPI.h"
#import "Movie.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"
#import "LMDropdownView.h"
@interface HomeCollection (){
    NSMutableArray* movieaArray;
}

@end

@implementation HomeCollection

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getPopular];
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    //[self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    return [movieaArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    UIImageView *moviePoster=[cell viewWithTag:1];
    Movie *m=[movieaArray objectAtIndex:indexPath.row];
    //NSMutableDictionary* ss = [moviesList objectAtIndex:1];
    NSString* stringImageURL =[MovieAPI GET_MOVIE_IMAGE_PATH_With_Image:m.poster_path];
    NSURL* imageURL = [[NSURL alloc] initWithString:stringImageURL];
    //NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]];
   // [imageArray arrayByAddingObject:[UIImage imageWithData:imageData]];
    [moviePoster sd_setImageWithURL: imageURL];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    SingleView *sv=[self.storyboard instantiateViewControllerWithIdentifier:@"SV"];
    [sv setSingleMovie:[movieaArray objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:sv animated:YES];
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/
-(void)getPopular{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    
    //get Your category popularmovie | Top rated
    // using MovieAPI class
    NSString* category =[MovieAPI GET_POPULAR_MOVIES_URL];
    NSURL *URL = [NSURL URLWithString:category];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            // Handel Error To Featch Data
            //including network is not avilable
            // and no data found
            NSLog(@"Error: %@", error);
        } else {
            
            //statr to parse your data
            [self getMoviesArrayfromString:responseObject];
        }
    }];
    [dataTask resume];
    
}
-(void)getTopRated{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    
    //get Your category popularmovie | Top rated
    // using MovieAPI class
    NSString* category =[MovieAPI GET_TOP_RATED_MOVIES_URL];
    NSURL *URL = [NSURL URLWithString:category];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            // Handel Error To Featch Data
            //including network is not avilable
            // and no data found
            NSLog(@"Error: %@", error);
        } else {
            
            //statr to parse your data
            [self getMoviesArrayfromString:responseObject];
        }
    }];
    [dataTask resume];
}
-(void)getMoviesArrayfromString:(NSMutableDictionary*) data{
    
    
    
    NSMutableArray* moviesList = [data objectForKey:@"results"];
    
    //this code is for testing image
        //------------------
    
    
    //TODO for loop and convert movies objects to movie class
    // and create your data source to be bined to the collection view
    movieaArray=[NSMutableArray new];
    for (NSMutableDictionary *m in moviesList) {
        Movie *movie =
        [[Movie alloc] initWithDictionary:m error:nil];
        //NSLog([ss objectForKey:@"title"]);
       // NSLog(@"%@",[movie title]);
        movieaArray = [movieaArray arrayByAddingObject:movie];
    }
    [self.view setNeedsDisplay];
    [self.collectionView reloadData];
}

- (IBAction)sort:(id)sender {
    switch ([sender selectedSegmentIndex]) {
            case 0:
            [self getPopular];
            break;
            case 1:
            [self getTopRated];
            break;
    }
    }
@end
