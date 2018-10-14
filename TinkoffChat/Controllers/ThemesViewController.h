//
//  ThemesViewController.h
//  TinkoffChat
//
//  Created by Artur on 14/10/2018.
//  Copyright © 2018 Artur Sardaryan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSObject+Theme.h"




NS_ASSUME_NONNULL_BEGIN


@interface ThemesViewController : UIViewController

@property (nonatomic, assign) id delegate;
@property (nonatomic, assign) Theme* test;

@end


@protocol ThemesViewControllerDelegate <NSObject>
- (void)themesViewController: (ThemesViewController *)controller didSelectTheme:(UIColor *)selectedTheme;

@end

NS_ASSUME_NONNULL_END
