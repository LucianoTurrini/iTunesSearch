//
//  ViewController.h
//  iTunesSearch
//
//  Created by joaquim on 09/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "iTunesManager.h"
#import "TableViewCell.h"
#import "Entidades/Filme.h"
#import "DetailViewController.h"
#import "ImageOptimize.h"

@interface TableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
{
    UITextView *TextView;
    NSArray *sectionTitles;
}


@property (strong, nonatomic) IBOutlet UITableView *tableview;

@property iTunesManager *itunes;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;


@end

