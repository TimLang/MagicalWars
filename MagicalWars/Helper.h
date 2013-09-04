//
//  Helper.h
//  ChalkTest
//
//  Created by Bullet Hermit on 12-10-17.
//  Copyright 2012年 紫竹飞燕. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Helper : NSObject {
    
}


+(CGPoint) locationFromTouch:(UITouch*) touch;
+(CGPoint) locationFromTouches:(NSSet*) touches;
+(CGPoint) openGLPosFromTileMap:(CCTMXTiledMap*)tileMap tilePos:(CGPoint)tilePos ;
+(CGPoint) screenCenter;
@end
