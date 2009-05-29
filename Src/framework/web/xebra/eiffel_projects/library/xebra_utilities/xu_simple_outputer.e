note
	description: "[
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XU_SIMPLE_STREAM

inherit
	STREAM
		redefine
			put_string,
			putstring,
			make
		end

create
	make

feature -- Initialization

		make
			do
				buf := ""
				Precursor
			end

feature -- Access

		buf: STRING
				-- Internal buffer. Might be better to replace it with something faster

feature -- Basic Functionality

		put_string (a_string: STRING)
				-- <Precursor>
				-- Appends a string to the content
			do
				buf.append (a_string)
			end

		putstring (a_string: STRING)
				-- <Precursor>
			do
				buf.append (a_string)
			end

		get_text: STRING
				-- Returns the accumulated content
			do
				Result := buf
			end
note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
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
