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
	responderCallbackObject = eif_protect(callbackObject);
	responderCallbackMethod = callbackMethod;
}


void bridge_void_void (id self, SEL name)
{
	//callbackMethod ( eif_access (callbackObject) );
}

void bridge_void_ptr (id self, SEL name, void* arg1)
{
	//callbackMethod ( eif_access (callbackObject), arg1 );
}

//[dict setObject:... forKey:...];