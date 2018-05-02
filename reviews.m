//
//  reviews.m
//  movies
//
//  Created by IOS OS on 3/3/18.
//  Copyright © 2018 IOS OS. All rights reserved.
//

#import "reviews.h"

@interface reviews (){
    NSMutableArray *title;
    NSMutableArray *content;
}

@end

@implementation reviews

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)viewWillAppear:(BOOL)animated{
    [self getData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return [title count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReviewCell" forIndexPath:indexPath];
    
    // Configure the cell...
    UILabel *auther=[cell viewWithTag:31];
    UITextView *contentView=[cell viewWithTag:32];
    [auther setText:[title objectAtIndex:indexPath.row]];
    [contentView setText:[content objectAtIndex:indexPath.row]];
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)getData{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    
    //get Your category popularmovie | Top rated
    // using MovieAPI class
    
    
    NSString* trailersURL = [MovieAPI GET_MOVIE_REVIEWS_PATH:_movie_id];
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
            //NSLog(@"%@",responseObject);
            title=[NSMutableArray new];
            content=[NSMutableArray new];
            NSMutableArray *trailerList=[responseObject objectForKey:@"results"];
            for (NSMutableDictionary *trail in trailerList) {
               // NSLog(@"%@",[trail objectForKey:@"author"]);
                [title addObject:[trail objectForKey:@"author"]];
                [content addObject:[trail objectForKey:@"content"]];
            }
            [self.view setNeedsLayout];
            [self.tableView reloadData];
        }
    }];
    [dataTask resume];
}
@end
