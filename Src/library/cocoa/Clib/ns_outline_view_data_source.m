/*
indexing
	description: "C features of NS_OUTLINE_VIEW_DATA_SOURCE"
	date: "$Date$"
	revision: "$Revision$"
	copyright:	"Copyright (c) 2009, Daniel Furrer"
*/

#include <eif_eiffel.h>
#include <Cocoa/Cocoa.h>
#include "ns_outline_view_data_source.h"

@implementation DSItem 
	- (void)setEiffelObject:(EIF_REFERENCE)ref
	{
		eifObj = (ref == nil) ? nil : eif_protect(ref);
	}
	- (EIF_REFERENCE)eiffelObject
	{
		return (eifObj == nil) ? nil : eif_access(eifObj);
	}
@end

@implementation OutlineViewDataSource 
	- (int)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(id)item
	{
		void* eiffelItem = [(DSItem*)item eiffelObject];
		int result = numberOfChildrenOfItem (
					eif_access (callbackObject),
					(EIF_REFERENCE) eiffelItem
					);
		return result;
	}
 
	- (BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(id)item
	{
		void* eiffelItem = [(DSItem*)item eiffelObject];
    	bool result = isItemExpandable (
				eif_access (callbackObject),
				(EIF_REFERENCE) eiffelItem
			);
		return result;
	}
 
	- (id)outlineView:(NSOutlineView *)outlineView  child:(int)index  ofItem:(id)item
	{
		void* eiffelItem = [(DSItem*)item eiffelObject];
    	void* result = childOfItem (
						eif_access (callbackObject),
						(EIF_INTEGER) index,
						(EIF_REFERENCE) eiffelItem
			);
		id res = [DSItem new];
		[res setEiffelObject: result];
		return res;
	}
 
	- (id)outlineView:(NSOutlineView *)outlineView  objectValueForTableColumn:(NSTableColumn *)tableColumn  byItem:(id)item
	{
		void* eiffelItem = [(DSItem*)item eiffelObject];
    	id result = (id) objectValueForTableColumnByItem (
				eif_access (callbackObject),
				(EIF_REFERENCE) tableColumn,
				(EIF_REFERENCE) eiffelItem
				);
		return result;
	}

	- (EIF_REFERENCE)initWithCallbackObject:(EIF_REFERENCE) a_callbackObject
		andMethod1:(numberOfChildrenOfItemTYPE) a_numberOfChildrenOfItem
		andMethod2:(isItemExpandableTYPE)a_isItemExpandable
		andMethod3:(childOfItemTYPE)a_childOfItem
		andMethod4:(objectValueForTableColumnByItemTYPE)a_objectValueForTableColumnByItem
	{
		callbackObject = eif_protect(a_callbackObject);
		numberOfChildrenOfItem = a_numberOfChildrenOfItem;
		isItemExpandable = a_isItemExpandable;
		childOfItem = a_childOfItem;
		objectValueForTableColumnByItem = a_objectValueForTableColumnByItem;
		return (EIF_REFERENCE)self;
	}
@end