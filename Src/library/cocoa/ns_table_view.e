note
	description: "Summary description for {NS_TABLE_VIEW}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NS_TABLE_VIEW

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
			check
				not_implemented: False
			end
		end

	add_table_column (a_table_column: NS_TABLE_COLUMN)
		do
			table_view_add_table_column (cocoa_object, a_table_column.cocoa_object)
		end

	selected_row: INTEGER
		do
			Result := table_view_selected_row (cocoa_object)
		end

	set_header_view (a_view: POINTER)
			--
		do
			table_view_set_header_view (cocoa_object, a_view)
		end

feature {NONE} -- Objective-C Implementation

	frozen table_view_add_table_column (a_table_view: POINTER; a_table_column: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSTableView*) $a_table_view addTableColumn: $a_table_column];"
		end

	frozen table_view_selected_row (a_table_view: POINTER) : INTEGER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSTableView*) $a_table_view selectedRow];"
		end

	frozen table_view_set_header_view (a_table_view: POINTER; a_header_view: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSTableView*) $a_table_view setHeaderView: $a_header_view];"
		end
end
