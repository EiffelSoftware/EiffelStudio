note
	description: "Summary description for {NS_TABLE_VIEW}."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_TABLE_VIEW

inherit
	NS_VIEW
		redefine
			make
		end

create
	make
create {NS_OBJECT}
	make_from_pointer,
	share_from_pointer

feature {NONE} -- Creation

	make
		do
			check
				not_implemented: False
			end
		end

feature -- Access

	add_table_column (a_table_column: NS_TABLE_COLUMN)
		do
			table_view_add_table_column (item, a_table_column.item)
		end

	selected_row: INTEGER
		do
			Result := table_view_selected_row (item)
		end

	set_header_view (a_view: POINTER)
			--
		do
			table_view_set_header_view (item, a_view)
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
