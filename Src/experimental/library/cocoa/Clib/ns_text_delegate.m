/*
indexing
	description: "C features for NS_WINDOW_DELEGATE"
	date: "$Date$"
	revision: "$Revision$"
	copyright:	"Copyright (c) 2009, Daniel Furrer"
*/

#include <eif_eiffel.h>
#include <Cocoa/Cocoa.h>
#include "ns_window_delegate.h"

@implementation WindowDelegate
	- (void)windowDidResize:(NSNotification *)notification {
		callbackMethod ( eif_access (callbackObject) );
	}

	- (EIF_REFERENCE)initWithCallbackObject:(EIF_REFERENCE)a_callbackObject andMethod:(windowDidResizeTYPE)a_callbackMethod {
		callbackObject = eif_protect(a_callbackObject);
		callbackMethod = a_callbackMethod;
		return (EIF_REFERENCE)self;
	}
@end