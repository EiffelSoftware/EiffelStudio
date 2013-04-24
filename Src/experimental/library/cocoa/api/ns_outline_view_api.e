note
	description: "Summary description for {NS_OUTLINE_VIEW_API}."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_OUTLINE_VIEW_API

feature -- Access

	frozen new: POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSOutlineView new];"
		end

	frozen set_outline_table_column (an_outline_view: POINTER; a_table_column: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSOutlineView*) $an_outline_view setOutlineTableColumn: $a_table_column];"
		end

	frozen set_data_source (an_outline_view: POINTER; a_data_source: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSOutlineView*) $an_outline_view setDataSource: $a_data_source];"
		end

	frozen set_delegate (an_outline_view: POINTER; a_delegate: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSOutlineView*) $an_outline_view setDelegate: $a_delegate];"
		end

	frozen reload_item_reload_children (an_outline_view: POINTER; an_item: POINTER; a_flag: BOOLEAN)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSOutlineView*) $an_outline_view reloadItem: $an_item reloadChildren: $a_flag];"
		end

	frozen item_at_row (an_outline_view: POINTER; a_row: INTEGER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSOutlineView*) $an_outline_view itemAtRow: $a_row];"
		end

	frozen site_to_fit (an_outline_view: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSOutlineView*) $an_outline_view sizeToFit];"
		end

feature -- Expanding and Collapsing the Outline

--	frozen outline_view_should_expand_item (a_ns_outline_view: POINTER; a_outline_view: POINTER; a_item: POINTER): BOOLEAN
--			-- - (BOOL)outlineView: (NSOutlineView *) outlineView shouldExpandItem: (NSOutlineView *) item
--		external
--			"C inline use <Cocoa/Cocoa.h>"
--		alias
--			"return [(NSOutlineView*)$a_ns_outline_view outlineView: $a_outline_view shouldExpandItem: *(id*)$a_item];"
--		end

	frozen outline_view_item_will_expand (a_ns_outline_view: POINTER; a_notification: POINTER)
			-- - (void)outlineViewItemWillExpand: (NSNotification *) notification
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSOutlineView*)$a_ns_outline_view outlineViewItemWillExpand: $a_notification];"
		end

	frozen expand_item (a_ns_outline_view: POINTER; a_item: POINTER)
			-- - (void)expandItem: (id) item
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSOutlineView*)$a_ns_outline_view expandItem: *(id*)$a_item];"
		end

	frozen expand_item_expand_children (a_ns_outline_view: POINTER; a_item: POINTER; a_expand_children: BOOLEAN)
			-- - (void)expandItem: (id) item expandChildren: (id) expandChildren
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSOutlineView*)$a_ns_outline_view expandItem: *(id*)$a_item expandChildren: $a_expand_children];"
		end

	frozen outline_view_item_did_expand (a_ns_outline_view: POINTER; a_notification: POINTER)
			-- - (void)outlineViewItemDidExpand: (NSNotification *) notification
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSOutlineView*)$a_ns_outline_view outlineViewItemDidExpand: $a_notification];"
		end

--	frozen outline_view_should_collapse_item (a_ns_outline_view: POINTER; a_outline_view: POINTER; a_item: POINTER): BOOLEAN
--			-- - (BOOL)outlineView: (NSOutlineView *) outlineView shouldCollapseItem: (NSOutlineView *) item
--		external
--			"C inline use <Cocoa/Cocoa.h>"
--		alias
--			"return [(NSOutlineView*)$a_ns_outline_view outlineView: $a_outline_view shouldCollapseItem: *(id*)$a_item];"
--		end

	frozen outline_view_item_will_collapse (a_ns_outline_view: POINTER; a_notification: POINTER)
			-- - (void)outlineViewItemWillCollapse: (NSNotification *) notification
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSOutlineView*)$a_ns_outline_view outlineViewItemWillCollapse: $a_notification];"
		end

	frozen collapse_item (a_ns_outline_view: POINTER; a_item: POINTER)
			-- - (void)collapseItem: (id) item
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSOutlineView*)$a_ns_outline_view collapseItem: *(id*)$a_item];"
		end

	frozen collapse_item_collapse_children (a_ns_outline_view: POINTER; a_item: POINTER; a_collapse_children: BOOLEAN)
			-- - (void)collapseItem: (id) item collapseChildren: (id) collapseChildren
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSOutlineView*)$a_ns_outline_view collapseItem: *(id*)$a_item collapseChildren: $a_collapse_children];"
		end

	frozen outline_view_item_did_collapse (a_ns_outline_view: POINTER; a_notification: POINTER)
			-- - (void)outlineViewItemDidCollapse: (NSNotification *) notification
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSOutlineView*)$a_ns_outline_view outlineViewItemDidCollapse: $a_notification];"
		end
end
