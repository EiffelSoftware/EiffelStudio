note
	description: "Wrapper for NSCell."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_CELL

inherit
	NS_OBJECT

create {NS_OBJECT}
	make_from_pointer

feature -- Initialization

	init_text_cell (a_string: NS_STRING)
		do
			{NS_CELL_API}.init_text_cell (item, a_string.item)
		end

	init_image_cell (a_image: NS_IMAGE)
		do
			{NS_CELL_API}.init_image_cell (item, a_image.item)
		end

--	object_value: NS_OBJECT
--		do
--			Result := {NS_CELL_API}.object_value (cocoa_object)
--		end

--	set_object_value (a_obj: NS_COPYING)
--		do
--			{NS_CELL_API}.set_object_value (cocoa_object, a_obj)
--		end

	has_valid_object_value: BOOLEAN
		do
			Result := {NS_CELL_API}.has_valid_object_value (item)
		end

	string_value: NS_STRING
		do
			create Result.make_from_pointer ({NS_CELL_API}.string_value (item))
		end

	set_string_value (a_string: NS_STRING)
		do
			{NS_CELL_API}.set_string_value (item, a_string.item)
		end

--	compare (a_other_cell: NS_OBJECT): NS_COMPARISON_RESULT
--		do
--			Result := {NS_CELL_API}.compare (cocoa_object, a_other_cell)
--		end

	int_value: INTEGER
		do
			Result := {NS_CELL_API}.int_value (item)
		end

	set_int_value (a_an_int: INTEGER)
		do
			{NS_CELL_API}.set_int_value (item, a_an_int)
		end

	float_value: REAL
		do
			Result := {NS_CELL_API}.float_value (item)
		end

	set_float_value (a_float: REAL)
		do
			{NS_CELL_API}.set_float_value (item, a_float)
		end

	double_value: REAL_64
		do
			Result := {NS_CELL_API}.double_value (item)
		end

	set_double_value (a_double: REAL_64)
		do
			{NS_CELL_API}.set_double_value (item, a_double)
		end

	title: NS_STRING
		do
			create Result.make_from_pointer ({NS_CELL_API}.title (item))
		end

	set_title (a_string: NS_STRING)
		do
			{NS_CELL_API}.set_title (item, a_string.item)
		end

feature -- Contract Suppoer



feature -- Cell States (NSCellStateValue)

	frozen mixed_state: INTEGER
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSMixedState"
		end

	frozen off_state: INTEGER
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSOffState"
		end

	frozen on_state: INTEGER
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSOnState"
		end

end
