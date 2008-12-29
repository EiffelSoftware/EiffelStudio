note
	description: "Stone that represents a line in a class"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	LINE_STONE

inherit
	STONE
		redefine
			stone_cursor,
			x_stone_cursor
		end

feature -- Access

	line_number: INTEGER assign set_line_number
			-- Line number

	column_number: INTEGER assign set_column_number
			-- Optional column number

	stone_cursor: EV_POINTER_STYLE
			-- Cursor associated with Current stone during transport
			-- when widget at cursor position is compatible with Current stone
		once
			Result := Cursors.cur_metric_line
		end

	x_stone_cursor: EV_POINTER_STYLE
			-- Cursor associated with Current stone during transport
			-- when widget at cursor position is not compatible with Current stone
		once
			Result := Cursors.cur_x_metric_line
		end

	class_c: CLASS_C
			-- Compiled class associated with that line, if the associated class is compiled

	selection: TUPLE [pos_start, pos_end: INTEGER]
			-- If set, `should_line_be_selected' should be ignored.

feature -- Status report

	should_line_be_selected: BOOLEAN
			-- Should line be selected when scrolled to?

feature -- Status report

	set_should_line_be_selected (b: BOOLEAN)
			-- Set `should_line_be_selected' with `b'.
		do
			should_line_be_selected := b
		ensure
			should_line_be_selected_set: should_line_be_selected = b
		end

	set_class_c (a_class_c: like class_c)
			-- Set `class_c' with `a_class_c'.
		do
			class_c := a_class_c
		ensure
			class_c_set: class_c = a_class_c
		end

feature -- Setting

	set_line_number (a_line_number: INTEGER)
			-- Set `line_number' with `a_line_number'.
		require
			a_line_number_positive: a_line_number > 0
		do
			line_number := a_line_number
		ensure
			line_number_set: line_number = a_line_number
		end

	set_column_number (a_column: like column_number)
			-- Set `column_number' with `a_column'.
		require
			a_column_positive: a_column > 0
		do
			column_number := a_column
		ensure
			column_number_set: column_number = a_column
		end

	set_selection (a_selection: like selection)
			-- Set `selection' with `a_selection'.
		do
			selection := a_selection
		ensure
			selection_set: selection = a_selection
		end

invariant
	line_number_positive: line_number > 0
	column_number_non_negative: column_number >= 0

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
