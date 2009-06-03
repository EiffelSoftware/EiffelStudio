/*
indexing
	description: "C features for NS_VIEW"
	date: "$Date: 2009-05-02 15:51:07 +0200 (Sa, 02 Mai 2009) $"
	revision: "$Revision: 78491 $"
	copyright:	"Copyright (c) 2009, Daniel Furrer"
*/

#include <eif_eiffel.h>
#include <Cocoa/Cocoa.h>
#include "ns_button.h"

@implementation MyButton
	- (void)mouseDown:(NSEvent*)a_event {
		callback_mouse_down ( eif_access (callback_object),
			a_event );
		[super mouseDown: a_event];
	}

	- (EIF_REFERENCE)initWithCallbackObject:(EIF_REFERENCE)a_callback_object andMethod:(mouseDownTYPE)a_callbackMethod {
		//NSLog ("new button %x %x", self, a_callback_object);
		callback_object = eif_protect (a_callback_object);
		callback_mouse_down = a_callbackMethod;
		return (EIF_REFERENCE)[super init];
	}
@end