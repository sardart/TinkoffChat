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

@property (strong, nonatomic, readonly) UIColor* defaultTheme;
@property (strong, nonatomic, readonly) UIColor* redTheme;
@property (strong, nonatomic, readonly) UIColor* blueTheme;
@property (strong, nonatomic, readonly) UIColor* darkTheme;

@end

NS_ASSUME_NONNULL_END
