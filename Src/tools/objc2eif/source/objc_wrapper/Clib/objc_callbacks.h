/*
 *  objc_callbacks.h
 *  
 *
 *  Created by Matteo Cortonesi on 9/27/10.
 *  Copyright 2010 __MyCompanyName__. All rights reserved.
 *
 */

#import <Cocoa/Cocoa.h>
#import <objc/runtime.h>
#import <eif_eiffel.h>

void * pointer_callbacks_hijacker (id self, SEL _cmd, ...);
id retain_imp(id self, SEL _cmd);
void release_imp(id self, SEL _cmd);