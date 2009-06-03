/*
indexing
	description: "C features for NS_WINDOW_DELEGATE"
	date: "$Date: 2009-04-26 22:46:55 +0200 (So, 26 Apr 2009) $"
	revision: "$Revision: 78382 $"
	copyright:	"Copyright (c) 2009, Daniel Furrer"
*/

#include <eif_eiffel.h>
#include <Cocoa/Cocoa.h>
#include "ns_responder_category.h"

EIF_OBJECT responderCallbackObject;
mouseDownTYPE responderCallbackMethod;

@implementation NSResponder (mouse)
	-(void)mouseDown:(NSEvent*)theEvent
	{
		NSPoint event_location = [theEvent locationInWindow];
		NSLog(@"Mouse Up at (%f, %f)!\n", event_location.x, event_location.y);
		//responderCallbackMethod ( eif_access (responderCallbackObject), self, theEvent );
	}
@end

EIF_REFERENCE setResponderCallback(EIF_REFERENCE callbackObject, mouseDownTYPE callbackMethod)
{
	responderCallbackObject = eif_protect (callbackObject);
	responderCallbackMethod = callbackMethod;
}

EIF_OBJECT callback_object;
boolCallbackTYPE callback_bool;
voidPtrCallbackTYPE callback_void_ptr;

void bridge_void (id self, SEL name)
{
	//callback_void ( eif_access (callback_object) );
}

void bridge_void_ptr (id self, SEL name, void* arg1)
{
	return callback_void_ptr ( eif_access (callback_object), self, name, arg1 );
}

BOOL bridge_bool (id self, SEL name)
{
	return callback_bool ( eif_access (callback_object), self, name );
}

void connect_callbacks (EIF_OBJECT a_callback_object, boolCallbackTYPE a_callback_bool, voidPtrCallbackTYPE a_callback_void_ptr) {
	callback_object = eif_adopt (a_callback_object);
	callback_bool   = a_callback_bool;
	callback_void_ptr = a_callback_void_ptr;
}