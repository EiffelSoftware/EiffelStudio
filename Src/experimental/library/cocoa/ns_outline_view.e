note
	description: "Wrapper for NSOutlineView"
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_OUTLINE_VIEW

inherit
	NS_TABLE_VIEW
		redefine
			make
		end

create
	make

feature {NONE} -- Creation

	make
		do
			make_shared (outline_view_new)
		end

feature -- Access

	set_outline_table_column (a_table_column: NS_TABLE_COLUMN)
			-- Sets the table column in which hierarchical data is displayed
		do
			outline_view_set_outline_table_column (item, a_table_column.item)
		end

	set_data_source (a_data_source: NS_OUTLINE_VIEW_DATA_SOURCE[ANY])
		do
			outline_view_set_data_source (item, a_data_source.item)
		end

	set_delegate (a_delegate: NS_OUTLINE_VIEW_DELEGATE)
		do
			outline_view_set_delegate (item, a_delegate.item)
		end

	reload_item_reload_children (an_item: POINTER; a_flag: BOOLEAN)
		do
			outline_view_reload_item_reload_children (item, an_item, a_flag)
		end

	item_at_row (a_row: INTEGER): ANY
		do
			Result := {NS_OUTLINE_VIEW_DATA_SOURCE[ANY]}.outline_view_date_source_item_to_any (outline_view_item_at_row (item, a_row))
		end

	size_to_fit
		do
			outline_view_site_to_fit (item)
		end

feature {NONE} -- Objective-C implementation

	frozen outline_view_new: POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSOutlineView new];"
		end

	frozen outline_view_set_outline_table_column (an_outline_view: POINTER; a_table_column: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSOutlineView*) $an_outline_view setOutlineTableColumn: $a_table_column];"
		end

	frozen outline_view_set_data_source (an_outline_view: POINTER; a_data_source: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSOutlineView*) $an_outline_view setDataSource: $a_data_source];"
		end

	frozen outline_view_set_delegate (an_outline_view: POINTER; a_delegate: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSOutlineView*) $an_outline_view setDelegate: $a_delegate];"
		end

	frozen outline_view_reload_item_reload_children (an_outline_view: POINTER; an_item: POINTER; a_flag: BOOLEAN)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSOutlineView*) $an_outline_view reloadItem: $an_item reloadChildren: $a_flag];"
		end

	frozen outline_view_item_at_row (an_outline_view: POINTER; a_row: INTEGER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSOutlineView*) $an_outline_view itemAtRow: $a_row];"
		end

	frozen outline_view_site_to_fit (an_outline_view: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSOutlineView*) $an_outline_view sizeToFit];"
		end
end
