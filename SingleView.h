//
//  SingleView.h
//  movies
//
//  Created by IOS OS on 3/1/18.
//  Copyright © 2018 IOS OS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"
#import "MovieAPI.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "DataBase.h"
#import "reviews.h"
@interface SingleView : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *favOutlet;
@property (weak, nonatomic) IBOutlet UILabel *movietitle;
@property (weak, nonatomic) IBOutlet UILabel *publish;
@property (weak, nonatomic) IBOutlet UIImageView *poster;
- (IBAction)favorite:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *movie_overview;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
- (IBAction)reviews:(id)sender;
@property Movie *singleMovie;
@end
