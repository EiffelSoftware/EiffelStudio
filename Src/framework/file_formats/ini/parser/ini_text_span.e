note
	description: "A logical span of text in a given text buffer."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"
class
	INI_TEXT_SPAN

create
	make

feature {NONE} -- Intitialization

	make (a_start_line: like start_line; a_start_index: like start_index; a_end_line: like end_line a_end_index: like end_index)
			-- Initialize text span
		require
			a_start_line_positive: a_start_line > 0
			a_start_index_non_negative: a_start_index >= 0
			a_end_line_positive: a_end_line > 0
			a_end_index_non_negative: a_end_index >= 0
			a_end_line_big_enough: a_end_line >= a_start_line
			a_end_index_big_enough: a_end_line = a_start_line implies a_end_index >= a_start_index
		do
			start_line := a_start_line
			start_index := a_start_index
			end_line := a_end_line
			end_index := a_end_index
		ensure
			start_line_set: start_line = a_start_line
			start_index_set: start_index = a_start_index
			end_line_set: end_line = a_end_line
			end_index_set: end_index = a_end_index
		end

feature -- Access

	start_line: INTEGER
			-- Start line

	start_index: INTEGER
			-- Start column index

	end_line: INTEGER
			-- End line

	end_index: INTEGER
			-- End column index

invariant
	start_line_positive: start_line > 0
	start_index_non_negative: start_index >= 0
	end_line_positive: end_line > 0
	end_index_non_negative: end_index >= 0
	end_line_big_enough: end_line >= start_line
	end_index_big_enough: end_line = start_line implies end_index >= start_index

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class {INI_TEXT_SPAN}
