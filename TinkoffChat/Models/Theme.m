//
//  Theme.m
//  TinkoffChat
//
//  Created by Artur on 14/10/2018.
//  Copyright © 2018 Artur Sardaryan. All rights reserved.
//

#import "Theme.h"

@implementation Theme: NSObject
- (UIColor *)defaultTheme {
    return [UIColor whiteColor];
}

- (UIColor *)redTheme {
    return [UIColor redColor];
}

- (UIColor *)blueTheme {
    return [UIColor blueColor];
}

- (UIColor *)darkTheme {
    return [UIColor blackColor];
}

@end
