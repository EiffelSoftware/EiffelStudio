note
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	COMPILED_LINE_STONE
inherit
	LINE_STONE
		undefine
			is_valid,
			same_as,
			synchronized_stone
		end

	CLASSC_STONE
		undefine
			stone_cursor,
			x_stone_cursor,
			stone_name
		end

create
	make_with_line

feature{NONE} -- Initialization

	make_with_line (a_class_c: like e_class; a_line_number: INTEGER; a_select: BOOLEAN)
			-- Initialize `class_i' with `a_class_c' and `line_number' with `line_number'.
		require
			a_class_c_attached: a_class_c /= Void
			a_line_number_positive: a_line_number > 0
		do
			make (a_class_c)
			set_line_number (a_line_number)
		end
end
