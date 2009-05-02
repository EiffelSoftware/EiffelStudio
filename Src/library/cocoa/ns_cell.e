note
	description: "Summary description for {NS_CELL}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NS_CELL

inherit
	NS_OBJECT

create
	make_shared

feature -- Initialization

	init_text_cell (a_string: NS_STRING)
		do
			cell_init_text_cell (cocoa_object, a_string.cocoa_object)
		end

	init_image_cell (a_image: NS_IMAGE)
		do
			cell_init_image_cell (cocoa_object, a_image.cocoa_object)
		end

--	object_value: NS_OBJECT
--		do
--			Result := cell_object_value (cocoa_object)
--		end

--	set_object_value (a_obj: NS_COPYING)
--		do
--			cell_set_object_value (cocoa_object, a_obj)
--		end

	has_valid_object_value: BOOLEAN
		do
			Result := cell_has_valid_object_value (cocoa_object)
		end

	string_value: NS_STRING
		do
			create Result.make_shared (cell_string_value (cocoa_object))
		end

	set_string_value (a_string: NS_STRING)
		do
			cell_set_string_value (cocoa_object, a_string.cocoa_object)
		end

--	compare (a_other_cell: NS_OBJECT): NS_COMPARISON_RESULT
--		do
--			Result := cell_compare (cocoa_object, a_other_cell)
--		end

	int_value: INTEGER
		do
			Result := cell_int_value (cocoa_object)
		end

	set_int_value (a_an_int: INTEGER)
		do
			cell_set_int_value (cocoa_object, a_an_int)
		end

	float_value: REAL
		do
			Result := cell_float_value (cocoa_object)
		end

	set_float_value (a_float: REAL)
		do
			cell_set_float_value (cocoa_object, a_float)
		end

	double_value: REAL_64
		do
			Result := cell_double_value (cocoa_object)
		end

	set_double_value (a_double: REAL_64)
		do
			cell_set_double_value (cocoa_object, a_double)
		end

	title: NS_STRING
		do
			create Result.make_shared (cell_title (cocoa_object))
		end

	set_title (a_string: NS_STRING)
		do
			cell_set_title (cocoa_object, a_string.cocoa_object)
		end

feature {NONE} -- Objective-C implementation

	frozen cell_init_text_cell (a_cell: POINTER; a_string: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSCell*)$a_cell initTextCell: $a_string];"
		end

	frozen cell_init_image_cell (a_cell: POINTER; a_image: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSCell*)$a_cell initImageCell: $a_image];"
		end

--	frozen cell_object_value (a_cell: POINTER): POINTER
--		external
--			"C inline use <Cocoa/Cocoa.h>"
--		alias
--			"return [(NSCell*)$a_cell objectValue];"
--		end

--	frozen cell_set_object_value (a_cell: POINTER; a_obj: POINTER)
--		external
--			"C inline use <Cocoa/Cocoa.h>"
--		alias
--			"[(NSCell*)$a_cell setObjectValue: $a_obj];"
--		end

	frozen cell_has_valid_object_value (a_cell: POINTER): BOOLEAN
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSCell*)$a_cell hasValidObjectValue];"
		end

	frozen cell_string_value (a_cell: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSCell*)$a_cell stringValue];"
		end

	frozen cell_set_string_value (a_cell: POINTER; a_string: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSCell*)$a_cell setStringValue: $a_string];"
		end

--	frozen cell_compare (a_cell: POINTER; a_other_cell: POINTER): POINTER
--		external
--			"C inline use <Cocoa/Cocoa.h>"
--		alias
--			"return [(NSCell*)$a_cell compare: $a_other_cell];"
--		end

	frozen cell_int_value (a_cell: POINTER): INTEGER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSCell*)$a_cell intValue];"
		end

	frozen cell_set_int_value (a_cell: POINTER; a_an_int: INTEGER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSCell*)$a_cell setIntValue: $a_an_int];"
		end

	frozen cell_float_value (a_cell: POINTER): REAL
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSCell*)$a_cell floatValue];"
		end

	frozen cell_set_float_value (a_cell: POINTER; a_float: REAL)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSCell*)$a_cell setFloatValue: $a_float];"
		end

	frozen cell_double_value (a_cell: POINTER): REAL_64
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSCell*)$a_cell doubleValue];"
		end

	frozen cell_set_double_value (a_cell: POINTER; a_double: REAL_64)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSCell*)$a_cell setDoubleValue: $a_double];"
		end

	frozen cell_title (a_cell: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSCell*)$a_cell title];"
		end

	frozen cell_set_title (a_cell: POINTER; a_string: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSCell*)$a_cell setTitle: $a_string];"
		end
end
