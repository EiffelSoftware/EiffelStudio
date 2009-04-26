/*
indexing
	description: "C features for NS_VIEW"
	date: "$Date$"
	revision: "$Revision$"
	copyright:	"Copyright (c) 2009, Daniel Furrer"
*/

#include <eif_eiffel.h>
#include <Cocoa/Cocoa.h>
#include "custom_view.h"

@implementation CustomView
	- (void)drawRect:(NSRect)dirtyRect {
		callbackMethod ( eif_access (callbackObject),
			dirtyRect.origin.x, dirtyRect.origin.y,
			dirtyRect.size.width, dirtyRect.size.height );
	}

	- (EIF_REFERENCE)initWithCallbackObject:(EIF_REFERENCE)a_callbackObject andMethod:(drawRectTYPE)a_callbackMethod {
		callbackObject = eif_protect(a_callbackObject);
		callbackMethod = a_callbackMethod;
		return (EIF_REFERENCE)self;
	}
@end