/*
indexing
	description: "C features for Action/Target messages"
	date: "$Date$"
	revision: "$Revision$"
	copyright:	"Copyright (c) 2009, Daniel Furrer"
*/

#include <eif_eiffel.h>
#include <Cocoa/Cocoa.h>
#include "actions.h"

@implementation SelectorWrapper
	- (IBAction)handle_action_event:(id)sender;
	{
		callbackMethod (eif_access (callbackObject));
	}

	- (EIF_REFERENCE)initWithCallbackObject:(EIF_REFERENCE)a_callbackObject andMethod:(void (*) (EIF_REFERENCE))a_callbackMethod {
		callbackObject = eif_protect(a_callbackObject);
		callbackMethod = a_callbackMethod;
		return (EIF_REFERENCE)self;
	}
@end
