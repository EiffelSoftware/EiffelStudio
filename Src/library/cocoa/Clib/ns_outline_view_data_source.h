/*
indexing
	description: "C features for NS_OUTLINE_VIEW_DATA_SOURCE"
	date: "$Date$"
	revision: "$Revision$"
	copyright:	"Copyright (c) 2009, Daniel Furrer"
*/

#ifndef _NS_OUTLINE_VIEW_DATA_SOURCE_H_INCLUDED_
#define _NS_OUTLINE_VIEW_DATA_SOURCE_H_INCLUDED_

#include <eif_eiffel.h>
#include <Cocoa/Cocoa.h>

// Found out after a lot of debugging that just returning a pointer to an eiffel object or even an integer does not work! (strange crashes)
// This class encapsulates an EIF_REFERENCE and also protects it from garbage collection
@interface DSItem : NSObject {
	EIF_OBJECT eifObj;
}
	- (void)setEiffelObject:(EIF_REFERENCE)ref;
	- (EIF_REFERENCE)eiffelObject;
@end

typedef EIF_INTEGER (*numberOfChildrenOfItemTYPE) (EIF_REFERENCE, EIF_REFERENCE);
typedef EIF_BOOLEAN (*isItemExpandableTYPE) (EIF_REFERENCE, EIF_REFERENCE);
typedef EIF_REFERENCE (*childOfItemTYPE) (EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE);
typedef EIF_REFERENCE (*objectValueForTableColumnByItemTYPE) (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE);

@interface OutlineViewDataSource : NSObject {
	EIF_OBJECT callbackObject;
	numberOfChildrenOfItemTYPE numberOfChildrenOfItem;
	isItemExpandableTYPE isItemExpandable;
	childOfItemTYPE childOfItem;
	objectValueForTableColumnByItemTYPE objectValueForTableColumnByItem;
}
	- (EIF_REFERENCE)initWithCallbackObject:(EIF_REFERENCE)a_callbackObject
			andMethod1:(numberOfChildrenOfItemTYPE) a_numberOfChildrenOfItem
			andMethod2:(isItemExpandableTYPE) a_isItemExpandable
			andMethod3:(childOfItemTYPE) a_childOfItem
			andMethod4:(objectValueForTableColumnByItemTYPE) a_objectValueForTableColumnByItem;
	// Required Methods:
	- (int)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(id)item;
	- (BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(id)item;
	- (id)outlineView:(NSOutlineView *)outlineView child:(int)index ofItem:(id)item;
	- (id)outlineView:(NSOutlineView *)outlineView objectValueForTableColumn:(NSTableColumn *)tableColumn byItem:(id)item;
@end

#endif
