//
//  SkillMenu.m
//  MagicalWars
//
//  Created by BulletHermit on 13-8-12.
//  Copyright 2013年 Nothing. All rights reserved.
//

#import "SkillMenu.h"


@implementation SkillMenu
+(id) nodeWithLayer:(CCLayer *)_target
{
    return  [[[self alloc] initWithLayer:_target] autorelease];
}
-(id) initWithLayer:(CCLayer*)_target;
{
    if (self = [super init]) {
        target = _target;
        [self addChild:[self widget]];
        [self updateWidget];
        

    }
    return self;
}
-(void ) clear
{
    [menu removeAllChildrenWithCleanup:YES];
}
-(CCNode*)widget
{
    // Prepare Menu.
	menu = [CCMenuAdvanced menuWithItems: nil];
//    for (int i=0; i!=10; ++i) {
//        CCSprite* sprite1 = [CCSprite spriteWithSpriteFrameName:@"UI_Magic_Water.png"];
//        sprite1.anchorPoint = ccp(0.5,0.5);
//        CCSprite* sprite2 = [CCSprite spriteWithSpriteFrameName:@"UI_Magic_Water.png"];
//        sprite2.anchorPoint = ccp(0.5,0.5);
//        sprite2.scale = 1.2;
//        CCSprite* sprite3 = [CCSprite spriteWithSpriteFrameName:@"UI_Magic_Water.png"];
//        sprite3.anchorPoint = ccp(0.5,0.5);
//        sprite3.color = ccGRAY;
//        CCMenuItemSprite* item = [CCMenuItemSprite itemWithNormalSprite:sprite1 selectedSprite:sprite2 disabledSprite:sprite3 target:target selector:@selector(castSkill:)];
//        item.userData =(void*)i;
//        item.anchorPoint=ccp(0.5,0.5);
//        [menu addChild:item ];
//    }
	
	// Enable Debug Draw (available only when DEBUG is defined )
#ifdef DEBUG
	menu.debugDraw = NO;
#endif
	
	// Setup Menu Alignment.
	[menu alignItemsHorizontally]; //< also sets contentSize and keyBindings on Mac
	
	return menu;
}
-(void) addItemWithSkillName:(NSString *)name
{
    CCSprite* sprite1 = [CCSprite spriteWithSpriteFrameName:name];
    CCSprite* sprite2 = [CCSprite spriteWithSpriteFrameName:name];
    sprite2.scale = 1.2;
    CCSprite* sprite3 = [CCSprite spriteWithSpriteFrameName:name];
    sprite3.color = ccGRAY;
    CCMenuItemSprite* item = [CCMenuItemSprite itemWithNormalSprite:sprite1 selectedSprite:sprite2 disabledSprite:sprite3 target:target selector:@selector(castSkill:)];
    item.userData = (void*)100;
    [menu addChild:item ];
    [menu alignItemsHorizontally];
    [self updateWidget];
}
- (void) updateWidget
{
	
		
	// Initial position.
	menu.anchorPoint = ccp(0.5f, 0.5f);
	
	menu.boundaryRect = CGRectMake( 0,
								 0 ,
								   240,
								   [menu boundingBox].size.height );
	
	// Show first menuItem (scroll max to the left).
	//menu.position = ccp(menu.contentSize.width / 2.0f, 0.5f * winSize.height);
	
	[menu fixPosition];
}
- (void) beforeDraw{
    glEnable(GL_SCISSOR_TEST);
    const CGFloat s = [[CCDirector sharedDirector] contentScaleFactor];
    const int w = 250, h = 0;
    glScissor(self.position.x *s ,
              self.position.y * s ,
              w,
              self.contentSize.height*s - 2*h);
}

- (void) afterDraw{
    glDisable(GL_SCISSOR_TEST);
}

- (void) visit{
    // quick return if not visible
    if (!visible_)
        return;
    
    kmGLPushMatrix();
    
    if ( grid_ && grid_.active) {
        [grid_ beforeDraw];
        [self transformAncestors];
    }
    
    [self transform];
    
    [self beforeDraw];
    
    if(children_) {
        ccArray *arrayData = children_->data;
        NSUInteger i = 0;
        
        // draw children zOrder < 0
        for( ; i < arrayData->num; i++ ) {
            CCNode *child = arrayData->arr[i];
            if ( [child zOrder] < 0 )
                [child visit];
            else
                break;
        }
        
        // self draw
        [self draw];
        
        // draw children zOrder >= 0
        for( ; i < arrayData->num; i++ ) {
            CCNode *child =  arrayData->arr[i];
            [child visit];
        }
        
    } else
        [self draw];
    
    [self afterDraw];
    
    if ( grid_ && grid_.active)
        [grid_ afterDraw:self];
    
    kmGLPopMatrix();
}

-(void )dealloc
{

    [super dealloc];
}
@end
