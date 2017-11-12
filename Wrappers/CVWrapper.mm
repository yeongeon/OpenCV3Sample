//
//  CVWrapper.m
//  OpenCV3Sample
//
//  Created by  yeongeon on 13/11/2017.
//  Copyright © 2017  yeongeon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <opencv2/opencv.hpp>
#import "CVWrapper.h"

@implementation OpenCVWrapper

-(NSString *) openCVVersionString
{
    return [NSString stringWithFormat:@"OpenCV Version %s", CV_VERSION];
}

@end
