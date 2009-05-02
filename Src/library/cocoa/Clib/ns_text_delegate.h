/*
indexing
	description: "C features for NS_TEXT_DELEGATE"
	date: "$Date$"
	revision: "$Revision$"
	copyright:	"Copyright (c) 2009, Daniel Furrer"
*/

#ifndef _NS_TEXT_DELEGATE_H_INCLUDED_
#define _NS_TEXT_DELEGATE_H_INCLUDED_

#include <eif_eiffel.h>
#include <Cocoa/Cocoa.h>

typedef EIF_REFERENCE (*windowDidResizeTYPE) (EIF_REFERENCE);

@interface TextDelegate : NSObject {
	EIF_OBJECT callbackObject;
	windowDidResizeTYPE callbackMethod;
}
	- (void)textDidBeginEditing:(NSNotification *)aNotification;
	- (void)textDidChange:(NSNotification *)aNotification;
	- (void)textDidEndEditing:(NSNotification *)aNotification;
	- (void)textShouldBeginEditing:(NSText *)aTextObject;
	- (void)textShouldEndEditing:(NSText *)aTextObject;
	- (EIF_REFERENCE)initWithCallbackObject:(EIF_REFERENCE)callbackObject andMethod:(windowDidResizeTYPE)callbackMethod;
@end

#endif
