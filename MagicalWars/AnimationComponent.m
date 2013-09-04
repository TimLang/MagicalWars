//
//  AnimationComponent.m
//  MagicalWars
//
//  Created by BulletHermit on 13-8-29.
//  Copyright 2013年 Nothing. All rights reserved.
//

#import "AnimationComponent.h"
#import "TileData.h"

@implementation AnimationComponent
+(id) animationWithAnimName:(NSString*)name
{
    
    return [[[self alloc] initWithAnimName:name] autorelease];
}
-(id)initWithAnimName:(NSString*)name
{
    if (self = [super init]) {
        unitName=name;
        [self loadAttackAnimationWith:name];
        [self loadDefendAnimationWith:name];
        [self loadWalkAnimationWith:name];
        [self setAnimation:[NSString stringWithFormat:@"%@WalkDown",name]];
        
    }
    return self;
}
-(void) setAnimation:(NSString*)animName
{
    CCAnimation* anim = [[CCAnimationCache sharedAnimationCache] animationByName:animName ];
    CCAnimate* animate = [CCAnimate actionWithAnimation:anim ];
    CCRepeatForever* repeat = [CCRepeatForever actionWithAction:animate ];
    [self runAction:repeat ];
    if ([animName hasSuffix:@"Right"]) {
        self.flipX = YES;
    }
    else
    {
        self.flipX=NO;
    }

}
-(void) loadWalkAnimationWith:(NSString*)name
{
    NSMutableArray* array = [NSMutableArray arrayWithCapacity:4];
    CCAnimation* anim;
    NSString* animName;
    //walk down
    animName = [NSString stringWithFormat:@"%@WalkDown",name];
    for (int i=1; i<=2; ++i) {
        NSString * frameName = [NSString  stringWithFormat:@"%@Walk%d.png",name,i];
        CCSpriteFrame* frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:frameName];
        [array addObject:frame];
    }
    anim = [CCAnimation animationWithSpriteFrames:array delay:0.5];
    [[CCAnimationCache sharedAnimationCache] addAnimation:anim name:animName];
    [array removeAllObjects];
    //walk up
    animName = [NSString stringWithFormat:@"%@WalkUp",name];
    for (int i=3; i<=4; ++i) {
        NSString * frameName = [NSString  stringWithFormat:@"%@Walk%d.png",name,i];
        CCSpriteFrame* frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:frameName];
        [array addObject:frame];
    }
    anim = [CCAnimation animationWithSpriteFrames:array delay:0.5];
    [[CCAnimationCache sharedAnimationCache] addAnimation:anim name:animName];
    [array removeAllObjects];
    
    //walk left
    animName = [NSString stringWithFormat:@"%@WalkLeft",name];
    for (int i=5; i<=6; ++i) {
        NSString * frameName = [NSString  stringWithFormat:@"%@Walk%d.png",name,i];
        CCSpriteFrame* frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:frameName];
        
        [array addObject:frame];
    }
    anim = [CCAnimation animationWithSpriteFrames:array delay:0.5];
    [[CCAnimationCache sharedAnimationCache] addAnimation:anim name:animName];
    [array removeAllObjects];
    
    //walk right
    animName = [NSString stringWithFormat:@"%@WalkRight",name];
    for (int i=5; i<=6; ++i) {
        NSString * frameName = [NSString  stringWithFormat:@"%@Walk%d.png",name,i];
        CCSpriteFrame* frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:frameName];
        
        [array addObject:frame];
    }
    anim = [CCAnimation animationWithSpriteFrames:array delay:0.5];
    
    [[CCAnimationCache sharedAnimationCache] addAnimation:anim name:animName];
    [array removeAllObjects];
    //Stand Down
    animName = [NSString stringWithFormat:@"%@StandDown",name];
    for (int i=7; i<=7; ++i) {
        NSString * frameName = [NSString  stringWithFormat:@"%@Walk%d.png",name,i];
        CCSpriteFrame* frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:frameName];
        
        [array addObject:frame];
    }
    
    
    anim = [CCAnimation animationWithSpriteFrames:array delay:0.5];
    
    [[CCAnimationCache sharedAnimationCache] addAnimation:anim name:animName];
    [array removeAllObjects];
    //Stand Up
    animName = [NSString stringWithFormat:@"%@StandUp",name];
    for (int i=8; i<=8; ++i) {
        NSString * frameName = [NSString  stringWithFormat:@"%@Walk%d.png",name,i];
        CCSpriteFrame* frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:frameName];
        
        [array addObject:frame];
    }
    anim = [CCAnimation animationWithSpriteFrames:array delay:0.5];
    [[CCAnimationCache sharedAnimationCache] addAnimation:anim name:animName];
    [array removeAllObjects];
    //Stand Left
    animName = [NSString stringWithFormat:@"%@StandLeft",name];
    for (int i=9; i<=9; ++i) {
        NSString * frameName = [NSString  stringWithFormat:@"%@Walk%d.png",name,i];
        CCSpriteFrame* frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:frameName];
        
        [array addObject:frame];
    }
    anim = [CCAnimation animationWithSpriteFrames:array delay:0.5];
    [[CCAnimationCache sharedAnimationCache] addAnimation:anim name:animName];
    [array removeAllObjects];
    //Stand Right
    animName = [NSString stringWithFormat:@"%@StandRight",name];
    for (int i=9; i<=9; ++i) {
        NSString * frameName = [NSString  stringWithFormat:@"%@Walk%d.png",name,i];
        CCSpriteFrame* frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:frameName];
        
        [array addObject:frame];
    }
    anim = [CCAnimation animationWithSpriteFrames:array delay:0.5];
    [[CCAnimationCache sharedAnimationCache] addAnimation:anim name:animName];
    [array removeAllObjects];
    //Stand Weak
    animName = [NSString stringWithFormat:@"%@StandWeak",name];
    for (int i=10; i<=11; ++i) {
        NSString * frameName = [NSString  stringWithFormat:@"%@Walk%d.png",name,i];
        CCSpriteFrame* frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:frameName];
        
        [array addObject:frame];
    }
    anim = [CCAnimation animationWithSpriteFrames:array delay:0.5];
    [[CCAnimationCache sharedAnimationCache] addAnimation:anim name:animName];
    [array removeAllObjects];
    
    
}
-(void) loadAttackAnimationWith:(NSString*)name
{
    NSMutableArray* array = [NSMutableArray arrayWithCapacity:4];
    CCAnimation* anim;
    NSString* animName;
    //Attack down
    animName = [NSString stringWithFormat:@"%@AttackDown",name];
    for (int i=1; i<=4; ++i) {
        NSString * frameName = [NSString  stringWithFormat:@"%@Attack%d.png",name,i];
        CCSpriteFrame* frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:frameName];
        [array addObject:frame];
    }
    anim = [CCAnimation animationWithSpriteFrames:array delay:0.5];
    [[CCAnimationCache sharedAnimationCache] addAnimation:anim name:animName];
    [array removeAllObjects];
    //Attack up
    animName = [NSString stringWithFormat:@"%@AttackUp",name];
    for (int i=5; i<=8; ++i) {
        NSString * frameName = [NSString  stringWithFormat:@"%@Attack%d.png",name,i];
        CCSpriteFrame* frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:frameName];
        [array addObject:frame];
    }
    anim = [CCAnimation animationWithSpriteFrames:array delay:0.5];
    [[CCAnimationCache sharedAnimationCache] addAnimation:anim name:animName];
    [array removeAllObjects];
    //Attack left
    animName = [NSString stringWithFormat:@"%@AttackLeft",name];
    for (int i=9; i<=12; ++i) {
        NSString * frameName = [NSString  stringWithFormat:@"%@Attack%d.png",name,i];
        CCSpriteFrame* frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:frameName];
        [array addObject:frame];
    }
    anim = [CCAnimation animationWithSpriteFrames:array delay:0.5];
    [[CCAnimationCache sharedAnimationCache] addAnimation:anim name:animName];
    [array removeAllObjects];
    //Attack Right
    animName = [NSString stringWithFormat:@"%@AttackRight",name];
    for (int i=9; i<=12; ++i) {
        NSString * frameName = [NSString  stringWithFormat:@"%@Attack%d.png",name,i];
        CCSpriteFrame* frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:frameName];
        [array addObject:frame];
    }
    anim = [CCAnimation animationWithSpriteFrames:array delay:0.5];
    [[CCAnimationCache sharedAnimationCache] addAnimation:anim name:animName];
    [array removeAllObjects];
}
-(void) loadDefendAnimationWith:(NSString*)name
{
    NSMutableArray* array = [NSMutableArray arrayWithCapacity:4];
    CCAnimation* anim;
    NSString* animName;
    //Defend down
    animName = [NSString stringWithFormat:@"%@DefendDown",name];
    for (int i=1; i<=1; ++i) {
        NSString * frameName = [NSString  stringWithFormat:@"%@Defend%d.png",name,i];
        CCSpriteFrame* frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:frameName];
        [array addObject:frame];
    }
    anim = [CCAnimation animationWithSpriteFrames:array delay:0.5];
    [[CCAnimationCache sharedAnimationCache] addAnimation:anim name:animName];
    [array removeAllObjects];
    //Defend up
    animName = [NSString stringWithFormat:@"%@DefendUp",name];
    for (int i=2; i<=2; ++i) {
        NSString * frameName = [NSString  stringWithFormat:@"%@Defend%d.png",name,i];
        CCSpriteFrame* frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:frameName];
        [array addObject:frame];
    }
    anim = [CCAnimation animationWithSpriteFrames:array delay:0.5];
    [[CCAnimationCache sharedAnimationCache] addAnimation:anim name:animName];
    [array removeAllObjects];
    //Defend Left
    animName = [NSString stringWithFormat:@"%@DefendLeft",name];
    for (int i=3; i<=3; ++i) {
        NSString * frameName = [NSString  stringWithFormat:@"%@Defend%d.png",name,i];
        CCSpriteFrame* frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:frameName];
        [array addObject:frame];
    }
    anim = [CCAnimation animationWithSpriteFrames:array delay:0.5];
    [[CCAnimationCache sharedAnimationCache] addAnimation:anim name:animName];
    [array removeAllObjects];
    //Defend Right
    animName = [NSString stringWithFormat:@"%@DefendRight",name];
    for (int i=3; i<=3; ++i) {
        NSString * frameName = [NSString  stringWithFormat:@"%@Defend%d.png",name,i];
        CCSpriteFrame* frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:frameName];
        [array addObject:frame];
    }
    anim = [CCAnimation animationWithSpriteFrames:array delay:0.5];
    [[CCAnimationCache sharedAnimationCache] addAnimation:anim name:animName];
    [array removeAllObjects];
    //Defend Failed
    animName = [NSString stringWithFormat:@"%@DefendFailed",name];
    for (int i=4; i<=4; ++i) {
        NSString * frameName = [NSString  stringWithFormat:@"%@Defend%d.png",name,i];
        CCSpriteFrame* frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:frameName];
        [array addObject:frame];
    }
    anim = [CCAnimation animationWithSpriteFrames:array delay:0.5];
    [[CCAnimationCache sharedAnimationCache] addAnimation:anim name:animName];
    [array removeAllObjects];
    //Defend Liveup
    animName = [NSString stringWithFormat:@"%@DefendLiveup",name];
    for (int i=5; i<=5; ++i) {
        NSString * frameName = [NSString  stringWithFormat:@"%@Defend%d.png",name,i];
        CCSpriteFrame* frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:frameName];
        [array addObject:frame];
    }
    anim = [CCAnimation animationWithSpriteFrames:array delay:0.5];
    [[CCAnimationCache sharedAnimationCache] addAnimation:anim name:animName];
    [array removeAllObjects];
    
    
}
-(void) moveByPath:(NSMutableArray *)path;
{
    movementPath = path;
    [self startAnimation];
}
-(void) startAnimation
{
        if ([movementPath count]==0) {
            Unit* parentUnit = (Unit*)self.parent;
            [parentUnit toAction];
            
            return;
        }
    Unit* parentUnit = (Unit*)self.parent;
    GameLayer* theGame = parentUnit.gameLayer;
        TileData* s  = [movementPath objectAtIndex:0];
        CCMoveTo* move = [CCMoveTo actionWithDuration:0.4 position:[theGame positionForTileCoord:s.position]];
        CCCallFunc* moveCallback = [CCCallFunc actionWithTarget:self selector:@selector(startAnimation)];
       [movementPath removeObjectAtIndex:0];
        [self runAction:[CCSequence actions:move,moveCallback, nil]];
}
-(void) turnOver
{
        [self stopAllActions];
            [self setAnimation:[NSString stringWithFormat:@"%@StandDown",unitName]];

    [self setColor:ccGRAY];
}
@end
