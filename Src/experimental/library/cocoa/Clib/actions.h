/*
indexing
	description: "C features for Action/Target messages"
	copyright:	"Copyright (c) 2009, Daniel Furrer"
*/

#ifndef _ACTIONS_H_INCLUDED_
#define _ACTIONS_H_INCLUDED_

#include <eif_eiffel.h>
#include <Cocoa/Cocoa.h>

@interface SelectorWrapper : NSObject {
	EIF_OBJECT callbackObject;
	void (*callbackMethod) (EIF_REFERENCE);
}
	- (IBAction)handle_action_event: (id)sender;
	- (EIF_REFERENCE)initWithCallbackObject: (EIF_REFERENCE)a_object andMethod: (void (*) (EIF_REFERENCE))a_method;
@end

#endif
