//
//  Theme.h
//  TinkoffChat
//
//  Created by Artur on 14/10/2018.
//  Copyright © 2018 Artur Sardaryan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface Theme: NSObject

@property (strong,nonatomic) UIColor* defaultTheme;
@property (strong,nonatomic) UIColor* redTheme;
@property (strong,nonatomic) UIColor* blueTheme;
@property (strong,nonatomic) UIColor* darkTheme;

@end

NS_ASSUME_NONNULL_END
