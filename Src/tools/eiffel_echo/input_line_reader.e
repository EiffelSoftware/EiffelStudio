indexing
	description: "[
		Input provider retrieving line wise input from a {IO_MEDIUM}.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	INPUT_LINE_READER

inherit
	INPUT_PROVIDER

create
	make

feature {NONE} -- Initialization

	make (a_medium: like medium)
			-- Initialize `Current'.
			--
			-- `a_medium': Medium from which input is read line wise.
		do
			medium := a_medium
		ensure
			medium_set: medium = a_medium
		end

feature -- Access

	next: STRING
			-- <Precursor>
		local
			l_last_line: like last_line
		do
			l_last_line := last_line
			check l_last_line /= Void end
			Result := l_last_line
		ensure then
			result_same_as_last_line: {l_last: like last_line} last_line and then Result.same_string (l_last)
		end

feature {NONE} -- Access

	medium: IO_MEDIUM
			-- Medium from which input is read line wise.

	last_line: ?like next
			-- Last line retrieved from `medium'.

feature -- Status report

	has_next: BOOLEAN
			-- <Precursor>
		do
			Result := last_line /= Void
		ensure then
			result_implies_last_line_attached: Result implies last_line /= Void
		end

feature -- Basic operations

	retrieve
			-- <Precursor>
			--
			-- Note: will set `last_line' to void if "quit" is received.
		local
			l_last: like last_line
		do
			medium.read_line
			l_last := medium.last_string
			check l_last /= Void end
			if l_last.same_string ("quit") then
				last_line := Void
			else
				last_line := l_last + "%N"
			end
		end

;indexing
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
