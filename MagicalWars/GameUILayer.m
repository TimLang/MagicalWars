//
//  GameUILayer.m
//  MagicalWars
//
//  Created by BulletHermit on 13-7-23.
//  Copyright 2013年 Nothing. All rights reserved.
//

#import "GameUILayer.h"
#import "constant.h"
#import "GameLayer.h"
#import "Unit.h"

@implementation GameUILayer
static GameUILayer* instanceOfGameUILayer;
+(GameUILayer*) shareGameUILayer
{
    NSAssert(instanceOfGameUILayer != nil,@"instaceofGameUI not yet initialized!");
    return instanceOfGameUILayer;
}
-(id) init
{
    if (self = [super init]) {
  
        skillMenu = [SkillMenu nodeWithLayer:self];
        [self addChild:skillMenu z:10];
        skillMenu.position=ccp(110,0);
        instanceOfGameUILayer = self;
    }
    return self;
}
-(void) displayActionMenu
{
    actionMenu.visible = YES;
   GameLayer* gameLayer = (GameLayer*) [self.parent getChildByTag:kTagLayerGame];
    actionMenu.position= [gameLayer positionInScreenFor: gameLayer.selectedUnit.myPosition];
    
}
//game optration

-(void) turnOver:(id)sender
{
    CCLOG(@"Turn Over:");

}
-(void) turnBack:(id)sender
{
    CCLOG(@"Turn Back:");
}
-(void) detail:(id)sender
{

    [head setNormalSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"Icon_Head1.png"]];
    //actionMenu.visible =YES;
    CCLOG(@"Detail");
}
-(void) castSkill:(id)sender
{
    CCMenuItemImage* s = (CCMenuItemImage*)sender;
    
    CCLOG(@"Skill:%d",(int*)s.userData);
}
//system optration
-(void) sysBack:(id)sender
{
    CCLOG(@"Back");
}
-(void) sysSetting:(id)sender
{
    CCLOG(@"Setting");
}
-(void) sysHelper:(id)sender
{
    CCLOG(@"Helper");
}
//menu optration
-(void) skillMenu:(id)sender
{
     CCLOG(@"Skill Menu");
    actionMenu.visible = NO;
    [skillMenu clear];
    for (int i=0; i!=10; i++) {
        [skillMenu addItemWithSkillName:@"UI_Magic_Fire.png"];
    }
}
-(void) stuntMenu:(id)sender
{
    actionMenu.visible = NO;
         CCLOG(@"Stunt Menu");
        [skillMenu clear];
    for (int i=0; i!=10; i++) {
        [skillMenu addItemWithSkillName:@"UI_Magic_Water.png"];
    }
}
-(void) magicMenu:(id)sender
{
    actionMenu.visible = NO;
         CCLOG(@"Magic Menu");
    [skillMenu clear];
        for (int i=0; i!=10; i++) {
            [skillMenu addItemWithSkillName:@"UI_Magic_Strike.png"];
        }
}
-(void) potionMenu:(id)sender
{
    actionMenu.visible = NO;
         CCLOG(@"Potion Menu");
    [skillMenu clear];
    for (int i=0; i!=10; i++) {
        [skillMenu addItemWithSkillName:@"UI_PotionButton.png"];
    }
}
-(void) stayMenu:(id)sender
{
    actionMenu.visible = NO;
    [skillMenu clear];
    GameLayer* gameLayer = (GameLayer*) [self.parent getChildByTag:kTagLayerGame];
    Unit* unit = gameLayer.selectedUnit;
    [unit toEnd];
         CCLOG(@"Stay ");
}
@end
