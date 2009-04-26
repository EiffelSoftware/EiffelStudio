note
	description: "Summary description for {NS_TAB_VIEW}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NS_TAB_VIEW

inherit
	NS_VIEW
		redefine
			new
		end
create
	new

feature

	new
		do
			cocoa_object := tab_view_new
		end

	add_tab_view_item (a_item: NS_TAB_VIEW_ITEM)
		do
			tab_view_add_tab_view_item (cocoa_object, a_item.cocoa_object)
		end

	insert_tab_view_item (a_item: NS_TAB_VIEW_ITEM; a_index: INTEGER)
		do
			tab_view_insert_tab_view_item (cocoa_object, a_item.cocoa_object, a_index)
		end

	remove_tab_view_item (a_item: NS_TAB_VIEW_ITEM)
		do
			tab_view_remove_tab_view_item (cocoa_object, a_item.cocoa_object)
		end

feature {NONE} -- Objective-C implementation

	frozen tab_view_new: POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSTabView new];"
		end

--	/* Select */

--- (void)selectTabViewItem:(NSTabViewItem *)tabViewItem;
--- (void)selectTabViewItemAtIndex:(NSInteger)index;				// May raise an NSRangeException
--- (void)selectTabViewItemWithIdentifier:(id)identifier;			// May raise an NSRangeException if identifier not found
--- (void)takeSelectedTabViewItemFromSender:(id)sender;			// May raise an NSRangeException

--	/* Navigation */

--- (void)selectFirstTabViewItem:(id)sender;
--- (void)selectLastTabViewItem:(id)sender;
--- (void)selectNextTabViewItem:(id)sender;
--- (void)selectPreviousTabViewItem:(id)sender;

--	/* Getters */

--- (NSTabViewItem *)selectedTabViewItem;					// return nil if none are selected
--- (NSFont *)font;							// returns font used for all tab labels.
--- (NSTabViewType)tabViewType;
--- (NSArray *)tabViewItems;
--- (BOOL)allowsTruncatedLabels;
--- (NSSize)minimumSize;							// returns the minimum size of the tab view
--- (BOOL)drawsBackground;  						// only relevant for borderless tab view type
--- (NSControlTint)controlTint;
--- (NSControlSize)controlSize;

--	/* Setters */

--- (void)setFont:(NSFont *)font;
--- (void)setTabViewType:(NSTabViewType)tabViewType;
--- (void)setAllowsTruncatedLabels:(BOOL)allowTruncatedLabels;
--- (void)setDrawsBackground:(BOOL)flag;  					// only relevant for borderless tab view type
--- (void)setControlTint:(NSControlTint)controlTint;
--- (void)setControlSize:(NSControlSize)controlSize;

--	/* Add/Remove tabs */

	frozen tab_view_add_tab_view_item (a_tab_view: POINTER; a_item: POINTER)
			--- (void)addTabViewItem:(NSTabViewItem *)tabViewItem;				// Add tab at the end.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSTabView*) $a_tab_view addTabViewItem: $a_item];"
		end

	frozen tab_view_insert_tab_view_item (a_tab_view: POINTER; a_item: POINTER; a_index: INTEGER)
			--- (void)insertTabViewItem:(NSTabViewItem *)tabViewItem atIndex:(NSInteger)index;	// May raise an NSRangeException
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSTabView*) $a_tab_view insertTabViewItem: $a_item atIndex: $a_index];"
		end

	frozen tab_view_remove_tab_view_item (a_tab_view: POINTER; a_item: POINTER)
			--- (void)removeTabViewItem:(NSTabViewItem *)tabViewItem;				// tabViewItem must be an existing tabViewItem
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSTabView*) $a_tab_view removeTabViewItem: $a_item];"
		end

--	/* Delegate */

--- (void)setDelegate:(id)anObject;
--- (id)delegate;

--	/* Hit testing */

--- (NSTabViewItem *)tabViewItemAtPoint:(NSPoint)point;			// point in local coordinates. returns nil if none.

--	/* Geometry */

--- (NSRect)contentRect;							// Return the rect available for a "page".

--	/* Query */

--- (NSInteger)numberOfTabViewItems;
--- (NSInteger)indexOfTabViewItem:(NSTabViewItem *)tabViewItem;			// NSNotFound if not found
--- (NSTabViewItem *)tabViewItemAtIndex:(NSInteger)index;			// May raise an NSRangeException	
--- (NSInteger)indexOfTabViewItemWithIdentifier:(id)identifier;			// NSNotFound if not found

--//================================================================================
--//	NSTabViewDelegate protocol
--//================================================================================

--@interface NSObject(NSTabViewDelegate)
--- (BOOL)tabView:(NSTabView *)tabView shouldSelectTabViewItem:(NSTabViewItem *)tabViewItem;
--- (void)tabView:(NSTabView *)tabView willSelectTabViewItem:(NSTabViewItem *)tabViewItem;
--- (void)tabView:(NSTabView *)tabView didSelectTabViewItem:(NSTabViewItem *)tabViewItem;
--- (void)tabViewDidChangeNumberOfTabViewItems:(NSTabView *)TabView;
--@end


end
