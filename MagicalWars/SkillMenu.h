//
//  SkillMenu.h
//  MagicalWars
//
//  Created by BulletHermit on 13-8-12.
//  Copyright 2013年 Nothing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CCMenuAdvanced.h"
@interface SkillMenu : CCLayer {
    CCMenuAdvanced* menu;
    CCLayer* target;
}
+(id) nodeWithLayer:(CCLayer*)target;

// Creates widget (can be anything you want, in Horizontal Test it is a Horizontal menu).
- (CCNode *) widget;


//add item with skill name
-(void) addItemWithSkillName:(NSString*) name;
-(void ) clear;
@end
