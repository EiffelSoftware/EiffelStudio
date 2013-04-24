note
	description: "Summary description for {NS_TABLE_VIEW_API}."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_TABLE_VIEW_API

feature -- Column Management

	frozen add_table_column (a_table_view: POINTER; a_table_column: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSTableView*) $a_table_view addTableColumn: $a_table_column];"
		end

	frozen table_columns (a_table_view: POINTER): POINTER
			-- - (NSArray *)tableColumns
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSTableView*) $a_table_view tableColumns];"
		end


feature -- ...

	frozen selected_row (a_table_view: POINTER) : INTEGER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSTableView*) $a_table_view selectedRow];"
		end

	frozen set_header_view (a_table_view: POINTER; a_header_view: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSTableView*) $a_table_view setHeaderView: $a_header_view];"
		end
end
