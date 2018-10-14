//
//  ThemesViewController.m
//  TinkoffChat
//
//  Created by Artur on 14/10/2018.
//  Copyright © 2018 Artur Sardaryan. All rights reserved.
//

#import "ThemesViewController.h"
#import <Foundation/Foundation.h>


@implementation ThemesViewController

- (Theme *)model {
    Theme *themeModel = [[Theme alloc] init];
    return [themeModel autorelease];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UINavigationBar.appearance.backgroundColor;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self animatedButtonsAppearance];
}

- (void)animatedButtonsAppearance {
    for (UIButton* button in [self buttons]) {
        button.transform = CGAffineTransformScale(button.transform, 0.1, 0.1);
    }
    
    [UIView animateWithDuration:1 animations:^{
        for (UIButton* button in [self buttons]) {
            button.transform = CGAffineTransformScale(button.transform, 10, 10);
        }
    }];
}

- (void)changeTheme:(UIColor *)color {
    self.view.backgroundColor = color;
    self.navigationController.navigationBar.backgroundColor = color;
    [_delegate themesViewController:self didSelectTheme:color];
}

- (IBAction)themeTapped:(UIButton *)sender {
    UIColor* theme = [[Theme alloc] defaultTheme];
    
    switch (sender.tag) {
        case 1:
            theme = self.model.redTheme;
            break;
        case 2:
            theme = self.model.blueTheme;
            break;
        case 3:
            theme = self.model.darkTheme;
            break;
        default:
            break;
    }
    [self changeTheme:theme];
    
    [theme release];
}

- (IBAction)closeTapped:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)dealloc {
    [_buttons release];
    [_model release];
    [super dealloc];
}

@end
