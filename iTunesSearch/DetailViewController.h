//
//  DetailViewController.h
//  iTunesSearch
//
//  Created by Luciano Moreira Turrini on 3/15/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Entidades/Midia.h"

@interface DetailViewController : UIViewController

@property (nonatomic, strong) Midia *midia;

@property (weak, nonatomic) IBOutlet UIImageView *imageProdutoView;

@property (weak, nonatomic) IBOutlet UILabel *nomeLabel;

@property (weak, nonatomic) IBOutlet UILabel *artistaLabel;

@property (weak, nonatomic) IBOutlet UILabel *generoLabel;

@end
