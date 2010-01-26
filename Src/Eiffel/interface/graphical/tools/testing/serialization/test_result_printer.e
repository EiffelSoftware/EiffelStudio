note
	description: "Summary description for {TEST_RESULT_PRINTER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_RESULT_PRINTER

inherit
	OUTPUT_WINDOW

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		do
			create buffer.make (4096)
		end

feature -- Access

	text: IMMUTABLE_STRING_8
			-- Formatted text which was printed since last call to `wipe_out'.
		do
			create Result.make_from_string (buffer)
		end

feature {NONE} -- Access

	buffer: STRING
			-- Buffer in which formatted result is printed

feature -- Basic operations

	put_new_line
			-- <Precursor>
		do
			buffer.append_character ('%N')
		end

	put_string (s: STRING_GENERAL)
			-- <Precursor>
		do
			buffer.append_string_general (s)
		end

	wipe_out
			-- Wipe out `buffer'.
		do
			buffer.wipe_out
		end

note
	copyright: "Copyright (c) 1984-2010, Eiffel Software"
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
