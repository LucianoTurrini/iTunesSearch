//
//  DetailViewController.m
//  iTunesSearch
//
//  Created by Luciano Moreira Turrini on 3/15/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

@synthesize midia;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.navigationController.navigationBar setHidden:NO];
    
    [_imageProdutoView setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:midia.imageUrl]]]];
    self.nomeLabel.text = [midia nome];
    self.artistaLabel.text = [midia artista];
    self.generoLabel.text = [midia genero];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
