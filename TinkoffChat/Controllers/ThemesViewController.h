//
//  ThemesViewController.h
//  TinkoffChat
//
//  Created by Artur on 14/10/2018.
//  Copyright © 2018 Artur Sardaryan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Theme.h"




NS_ASSUME_NONNULL_BEGIN

@class ThemesViewController;
@protocol ThemesViewControllerDelegate <NSObject>
- (void)themesViewController: (ThemesViewController *)controller didSelectTheme:(UIColor *)selectedTheme;
@end


@interface ThemesViewController : UIViewController

@property (nonatomic, weak) id<ThemesViewControllerDelegate> delegate;
@property (nonatomic, retain, readwrite) Theme* model;
@property (retain, nonatomic) IBOutletCollection(UIButton) NSArray *buttons;

- (IBAction)themeTapped:(UIButton *)sender;
- (IBAction)closeTapped:(UIBarButtonItem *)sender;

- (void)changeTheme:(UIColor *)color;

@end




NS_ASSUME_NONNULL_END
