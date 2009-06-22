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
end
