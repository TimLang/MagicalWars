//
//  AnimationComponent.h
//  MagicalWars
//
//  Created by BulletHermit on 13-8-29.
//  Copyright 2013年 Nothing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Unit.h"
@interface AnimationComponent : CCSprite {
    NSString* unitName;
    MoveState* moveState;
    NSMutableArray* movementPath;
}
+(id) animationWithAnimName:(NSString*)name;
-(void) moveByPath:(NSMutableArray *)path;
-(void) turnOver;
@end
