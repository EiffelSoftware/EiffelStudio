indexing
	description: "Stone that represents a line in a class"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LINE_STONE

inherit
	CLASSI_STONE

create
	make_with_line

feature{NONE} -- Initialization

	make_with_line (a_class_i: like class_i; a_line_number: INTEGER; a_select: BOOLEAN) is
			-- Initialize `class_i' with `a_class_i' and `line_number' with `line_number'.
		require
			a_class_i_attached: a_class_i /= Void
			a_line_number_positive: a_line_number > 0
		do
			make (a_class_i)
			set_line_number (a_line_number)
		end

feature -- Access

	line_number: INTEGER
			-- Line number

feature -- Status report

	should_line_be_selected: BOOLEAN
			-- Should line be selected when scrolled to?

feature -- Status report

	set_should_line_be_selected (b: BOOLEAN) is
			-- Set `should_line_be_selected' with `b'.
		do
			should_line_be_selected := b
		ensure
			should_line_be_selected_set: should_line_be_selected = b
		end

feature -- Setting

	set_line_number (a_line_number: INTEGER) is
			-- Set `line_number' with `a_line_number'.
		require
			a_line_number_positive: a_line_number > 0
		do
			line_number := a_line_number
		ensure
			line_number_set: line_number = a_line_number
		end

indexing
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
