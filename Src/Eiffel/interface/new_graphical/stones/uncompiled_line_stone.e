﻿note
	description: "Objects that represents a line of an uncompiled class."
	date: "$Date$"
	revision: "$Revision$"

class
	UNCOMPILED_LINE_STONE

inherit
	LINE_STONE
		undefine
			is_valid,
			same_as,
			synchronized_stone,
			is_compatible_with
		end

	CLASSI_STONE
		undefine
			stone_cursor,
			x_stone_cursor,
			stone_name
		end

create
	make_with_line,
	make_with_line_and_column

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

	make_with_line_and_column (c: like class_i; line, column: INTEGER)
			-- Initialize `class_i` with `c`, `line_number` with `line', `column_number` with `column`.
		require
			c_attached: attached c
			line_positive: line > 0
			column_positive: column > 0
		do
			make (c)
			set_line_number (line)
			set_column_number (column)
		end

note
	copyright: "Copyright (c) 1984-2017, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
