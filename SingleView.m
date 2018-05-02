//
//  SingleView.m
//  movies
//
//  Created by IOS OS on 3/1/18.
//  Copyright © 2018 IOS OS. All rights reserved.
//

#import "SingleView.h"
#import "HCSStarRatingView.h"
#import "Movie.h"
@interface SingleView (){
	DataBase *db;
	NSMutableArray *tableData;
	NSMutableArray *trailerKey;
}

@end

@implementation SingleView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidLayoutSubviews{
	[self.view setNeedsLayout];
	[_tableView reloadData];
}
-(void)viewWillAppear:(BOOL)animated{
	[self getData];
	[_scrollView setScrollEnabled:YES];
	db=[DataBase sharedInstance];
	[_movietitle setNumberOfLines:0];
	[_movietitle setLineBreakMode:NSLineBreakByWordWrapping];
    [_movietitle setText:_singleMovie.title];
    [_publish setText:_singleMovie.release_date];
	UIImage *img=[UIImage imageNamed:@"unlike2.png"];
	[_favOutlet setImage:img forState:0];
    [_movie_overview setText:_singleMovie.overview];
    NSString* stringImageURL =[MovieAPI GET_MOVIE_IMAGE_PATH_With_Image:_singleMovie.poster_path];
    NSURL* imageURL = [[NSURL alloc] initWithString:stringImageURL];
    [_poster sd_setImageWithURL: imageURL];
	HCSStarRatingView *starRatingView = [[HCSStarRatingView alloc] initWithFrame:CGRectMake(50, 410, 200, 50)];
	starRatingView.maximumValue = 10;
	starRatingView.minimumValue = 0;
	starRatingView.allowsHalfStars = YES;
	starRatingView.value = [_singleMovie.vote_average floatValue];
	starRatingView.tintColor = [UIColor redColor];
	starRatingView.enabled=NO;
	[_scrollView addSubview:starRatingView];
	NSMutableArray *search=[db loadall];
	for (Movie *movie in search) {
		if([movie.title isEqualToString:_singleMovie.title]){
			UIImage *img=[UIImage imageNamed:@"liked2.png"];
			[_favOutlet setImage:img forState:0];
		}
	}
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [tableData count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *simpleTableIdentifier = @"singleViewCell";
 
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
 
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
	}
 
	UILabel *label=[cell viewWithTag:22];
	UIImageView *img=[cell viewWithTag:21];
	[label setText:[tableData objectAtIndex:indexPath.row]];
	img.image=[UIImage imageNamed:@"play.png"];
	return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	NSString *string=[MovieAPI GET_YOUTUBE_PATH_FOR_KEY:[trailerKey objectAtIndex:indexPath.row]];
	NSURL *url = [NSURL URLWithString:string];
	UIApplication *app = [UIApplication sharedApplication];
	[app openURL:url];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)favorite:(id)sender {
	//insertfav:(NSString*)ftitle:(NSString*)frelease_date:(NSString*)fposter_path:(NSString*)foverview:(NSString*)fvote_average:(NSString*)ftrailer{
	int result=[db insertfav:[_singleMovie id]:[_singleMovie title]:[_singleMovie release_date]:[_singleMovie poster_path]:[_singleMovie overview]:[_singleMovie vote_average]:@"ay haga" ];
	if(result == 1){
		UIImage *img=[UIImage imageNamed:@"liked2.png"];
		[_favOutlet setImage:img forState:0];
	}
}
-(void)getData{
	NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
	AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
	
	
	//get Your category popularmovie | Top rated
	// using MovieAPI class
	
	
	NSString* trailersURL = [MovieAPI GET_MOVIE_TRAILERS_PATH:_singleMovie.id];
	NSURL *URL = [NSURL URLWithString:trailersURL];
	NSURLRequest *request = [NSURLRequest requestWithURL:URL];
	NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
		if (error) {
			// Handel Error To Featch Data
			//including network is not avilable
			// and no data found
			NSLog(@"Error: %@", error);
		} else {
			
			//statr to parse your data
			
			// [self getMoviesArrayfromString:responseObject];
			tableData=[NSMutableArray new];
			trailerKey=[NSMutableArray new];
			 //NSLog(@"%@",responseObject);
			NSMutableArray *trailerList=[responseObject objectForKey:@"results"];
			for (NSMutableDictionary *trail in trailerList) {
				//NSLog(@"%@",[trail objectForKey:@"name"]);
				[tableData addObject:[trail objectForKey:@"name"]];
				[trailerKey addObject:[trail objectForKey:@"key"]];
			}
			[self.view setNeedsLayout];
			[_tableView reloadData];
		}
	}];
	[dataTask resume];
}
//-(void)getMoviesArrayfromString:(NSMutableDictionary*) data{
//	
//	
//	
//	NSMutableArray* moviesList = [data objectForKey:@"results"];
//	
//	//this code is for testing image
//	//------------------
//	
//	
//	//TODO for loop and convert movies objects to movie class
//	// and create your data source to be bined to the collection view
//	movieaArray=[NSMutableArray new];
//	for (NSMutableDictionary *m in moviesList) {
//		Movie *movie =
//		[[Movie alloc] initWithDictionary:m error:nil];
//		//NSLog([ss objectForKey:@"title"]);
//		// NSLog(@"%@",[movie title]);
//		movieaArray = [movieaArray arrayByAddingObject:movie];
//	}
//	[self.view setNeedsDisplay];
//	[self.collectionView reloadData];
//}
- (IBAction)reviews:(id)sender {
	reviews *r=[self.storyboard instantiateViewControllerWithIdentifier:@"REV"];
	[r setMovie_id:_singleMovie.id];
	[self.navigationController pushViewController:r animated:YES];
}
@end
