//
//  Helper.m
//  ChalkTest
//
//  Created by Bullet Hermit on 12-10-17.
//  Copyright 2012年 紫竹飞燕. All rights reserved.
//

#import "Helper.h"
#import "constant.h"

@implementation Helper

+(CGPoint) locationFromTouch:(UITouch *)touch
{
    CGPoint location = [touch locationInView:[touch view]];
    return [[CCDirector sharedDirector] convertToGL:location];
}
+(CGPoint) locationFromTouches:(NSSet *)touches
{
    return [self locationFromTouch:[touches anyObject]];
}
+(CGPoint) openGLPosFromTileMap:(CCTMXTiledMap *)tileMap tilePos:(CGPoint)tilePos
{
    int x = tilePos.x;
    int y = tileMap.mapSize.height-1-tilePos.y;
    return ccp(x*tileMap.tileSize.width, y*tileMap.tileSize.height);
}
+(CGPoint) screenCenter
{
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    CGPoint p = ccp(winSize.width*0.5,winSize.height*0.5);
    return p;
}
@end
