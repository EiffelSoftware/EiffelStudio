note
	description: "Summary description for {NS_TABLE_COLUMN}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NS_TABLE_COLUMN

inherit
	NS_OBJECT

create
	new

feature

	new
		do
			cocoa_object := table_column_new
		end

	header_cells: POINTER
		do
			Result := table_header_cell (cocoa_object)
		end

	set_editable (a_flag: BOOLEAN)
		do
			table_set_editable (cocoa_object, a_flag)
		end

	set_width (a_width: REAL)
		do
			table_set_width (cocoa_object, a_width)
		end

feature {NONE} -- Objective-C Implementation

	frozen table_column_new: POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSTableColumn new];"
		end

	frozen table_header_cell (a_table_column: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSTableColumn*)$a_table_column headerCell];"
		end

	frozen table_set_editable (a_table_column: POINTER; a_flag: BOOLEAN)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSTableColumn*)$a_table_column setEditable: $a_flag];"
		end

	frozen table_set_width (a_table_column: POINTER; a_width: REAL)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSTableColumn*)$a_table_column setWidth: $a_width];"
		end
end
