//
//  GameScene.m
//  MagicalWars
//
//  Created by BulletHermit on 13-7-23.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "GameScene.h"
#import "GameUILayer.h"
#import "CCBReader.h"
#import "GameLayer.h"
#import "constant.h"
@implementation GameScene
+(id)scene
{
    CCScene* scene = [CCScene node];

    GameLayer* gameLayer = [GameLayer node];
    [scene addChild:gameLayer z:0 tag:kTagLayerGame];
    GameUILayer* uiLayer =(GameUILayer*) [CCBReader nodeGraphFromFile:@"GameUILayer.ccbi"  ];
    [scene addChild:uiLayer z:1 tag:kTagLayerUI];
    return scene;
}
-(id) init
{
    if (self = [super init]) {

    }
    return self;
}

@end
