//
//  ThemesViewController.m
//  TinkoffChat
//
//  Created by Artur on 14/10/2018.
//  Copyright © 2018 Artur Sardaryan. All rights reserved.
//

#import "ThemesViewController.h"
#import <Foundation/Foundation.h>




@interface ThemesViewController ()

@property (retain, nonatomic) IBOutlet UIButton *theme1;
@property (retain, nonatomic) IBOutlet UIButton *theme2;
@property (retain, nonatomic) IBOutlet UIButton *theme3;


@end

@implementation ThemesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    for (UIButton* button in [self buttons]) {
        button.layer.cornerRadius = 8;
        button.backgroundColor = UIColor.grayColor;
    }
    
}

- (IBAction)themeTapped:(UIButton *)sender {
    UIColor* themeColor = [[Theme alloc] defaultTheme];
    
    switch (sender.tag) {
        case 1:
            themeColor = [[Theme alloc] redTheme];
            break;
        case 2:
            themeColor = [[Theme alloc] blueTheme];
            break;
        case 3:
            themeColor = [[Theme alloc] darkTheme];
            break;
        default:
            break;
    }
    
    [self changeTheme:themeColor];
}

- (void)changeTheme:(UIColor *)color {
    self.view.backgroundColor = color;
    self.navigationController.navigationBar.backgroundColor = color;
    [_delegate themesViewController:self didSelectTheme:color];
}

- (IBAction)closeTapped:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)dealloc {
    [_theme1 release];
    [_theme2 release];
    [_theme3 release];
    [_buttons release];
    [super dealloc];
    NSLog(@"themeVC dealloced");

}
@end
