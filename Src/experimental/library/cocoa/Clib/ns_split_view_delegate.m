/*
indexing
	description: "C features of NS_SPLIT_VIEW_DELEGATE"
	date: "$Date$"
	revision: "$Revision$"
	copyright:	"Copyright (c) 2009, Daniel Furrer"
*/

#include <eif_eiffel.h>
#include <Cocoa/Cocoa.h>
#include "ns_split_view_delegate.h"

@implementation SplitViewDelegate 
	- (void)splitViewDidResizeSubviews:(NSNotification *)notification
	{
		splitViewDidResizeSubviews ( eif_access (callbackObject) );
	}

	- (EIF_REFERENCE)initWithCallbackObject:(EIF_REFERENCE) a_callbackObject
		andMethod:(splitViewDidResizeSubviewsTYPE) a_callbackMethod
	{
		callbackObject = eif_protect(a_callbackObject);
		splitViewDidResizeSubviews = a_callbackMethod;
		return (EIF_REFERENCE)self;
	}
@end
