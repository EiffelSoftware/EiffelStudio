/*
indexing
	description: "C features for NS_SPLIT_VIEW_DELEGATE"
	date: "$Date$"
	revision: "$Revision$"
	copyright:	"Copyright (c) 2009, Daniel Furrer"
*/

#ifndef _NS_SPLIT_VIEW_DELEGATE_H_INCLUDED_
#define _NS_SPLIT_VIEW_DELEGATE_H_INCLUDED_

#include <eif_eiffel.h>
#include <Cocoa/Cocoa.h>

typedef EIF_REFERENCE (*splitViewDidResizeSubviewsTYPE) (EIF_REFERENCE);

@interface SplitViewDelegate : NSObject {
	EIF_OBJECT callbackObject;
	splitViewDidResizeSubviewsTYPE splitViewDidResizeSubviews;
}
	- (EIF_REFERENCE)initWithCallbackObject:(EIF_REFERENCE)a_callbackObject
		andMethod:(splitViewDidResizeSubviewsTYPE) a_splitViewDidResizeSubviews;

	- (void)splitViewDidResizeSubviews:(NSNotification *)notification;
@end

#endif
