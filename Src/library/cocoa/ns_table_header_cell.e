note
	description: "Summary description for {NS_TABLE_HEADER_CELL}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NS_TABLE_HEADER_CELL

inherit
	NS_TEXT_FIELD_CELL

create
	alloc,
	new

feature -- Creation

	alloc
		do
			cocoa_object := table_header_cell_alloc
		end

	new
		do
			cocoa_object := table_header_cell_new
		end

feature {NONE} -- Objective-C interface

	frozen table_header_cell_alloc: POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSTableHeaderCell alloc];"
		end

	frozen table_header_cell_new: POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSTableHeaderCell new];"
		end

end
