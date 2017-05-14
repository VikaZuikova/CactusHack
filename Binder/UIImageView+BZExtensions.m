//
//  UIImageView+BZExtensions.m
//  ismc
//
//  Created by Boris Zinkovich on 26.07.16.
//  Copyright © 2016 itvsystems. All rights reserved.
//

#import "UIImageView+BZExtensions.h"

@implementation UIImageView (BZExtensions)

- (void)methodSetImage:(UIImage * _Nonnull)theImage withCornerRadius:(double)theCornerRadius;
{
    // Begin a new image that will be the new image with the rounded corners
    // (here with the size of an UIImageView)
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 1.0);
    
    // Add a clip before drawing anything, in the shape of an rounded rect
    [[UIBezierPath bezierPathWithRoundedRect:self.bounds
                                cornerRadius:theCornerRadius] addClip];
    // Draw your image
    [theImage drawInRect:self.bounds];
    
    // Get the image, here setting the UIImageView image
    self.image = UIGraphicsGetImageFromCurrentImageContext();
    
    // Lets forget about that we were drawing
    UIGraphicsEndImageContext();
}

@end






























