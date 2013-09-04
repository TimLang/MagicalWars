//
//  GameUILayer.h
//  MagicalWars
//
//  Created by BulletHermit on 13-7-23.
//  Copyright 2013年 Nothing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SkillMenu.h"

@interface GameUILayer : CCLayer {
    CCMenuItemImage* head;
    SkillMenu* skillMenu;
    CCMenu* actionMenu;
}
+(GameUILayer*) shareGameUILayer;
-(void) displayActionMenu;
//game optration

-(void) turnOver:(id)sender;
-(void) turnBack:(id)sender;
-(void) detail:(id)sender;
-(void) castSkill:(id)sender;

//system optration
-(void) sysBack:(id)sender;
-(void) sysSetting:(id)sender;
-(void) sysHelper:(id)sender;

//menu optration
-(void) skillMenu:(id)sender;
-(void) stuntMenu:(id)sender;
-(void) magicMenu:(id)sender;
-(void) potionMenu:(id)sender;
-(void) stayMenu:(id)sender;


@end
