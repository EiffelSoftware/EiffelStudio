note
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	UNCOMPILED_LINE_STONE
inherit
	LINE_STONE
		undefine
			is_valid,
			same_as,
			synchronized_stone
		end

	CLASSI_STONE
		undefine
			stone_cursor,
			x_stone_cursor,
			stone_name
		end

create
	make_with_line

feature{NONE} -- Initialization

	make_with_line (a_class_i: like class_i; a_line_number: INTEGER; a_select: BOOLEAN)
			-- Initialize `class_i' with `a_class_i' and `line_number' with `line_number'.
		require
			a_class_i_attached: a_class_i /= Void
			a_line_number_positive: a_line_number > 0
		do

			make (a_class_i)
			set_line_number (a_line_number)
		end
end
