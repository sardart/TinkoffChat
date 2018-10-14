//
//  ThemesViewController.m
//  TinkoffChat
//
//  Created by Artur on 14/10/2018.
//  Copyright © 2018 Artur Sardaryan. All rights reserved.
//

#import "ThemesViewController.h"

@interface ThemesViewController ()

@property (retain, nonatomic) IBOutlet UIButton *theme1;
@property (retain, nonatomic) IBOutlet UIButton *theme2;
@property (retain, nonatomic) IBOutlet UIButton *theme3;

@end

@implementation ThemesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)theme1Tapped:(UIButton *)sender {
    NSLog(@"theme 1 tapped");
}


- (IBAction)theme2Tapped:(UIButton *)sender {
}


- (IBAction)theme3Tapped:(UIButton *)sender {
}


- (IBAction)closeTapped:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated: YES completion: NULL];
}

- (void)dealloc {
    [_theme1 release];
    [_theme2 release];
    [_theme3 release];
    [super dealloc];
    NSLog(@"themeVC dealloced");

}
@end
