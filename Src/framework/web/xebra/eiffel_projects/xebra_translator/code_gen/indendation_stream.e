note
	description: "[
		Used to write plain text to a file. Indendation is automatically handled.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	INDENDATION_STREAM

inherit
	PLAIN_TEXT_FILE
		redefine
			put_string
		end

create

	make, make_open_read, make_open_write, make_open_append,
	make_open_read_write, make_create_read_write,
	make_open_read_append

feature -- Access

	indendation: NATURAL
			-- By how many times strings should be indendanted with `ind_character'

	ind_character: CHARACTER
			-- Indendantion character

feature

	set_indendation (an_indendation: NATURAL)
			-- Sets the indendantion.
		require
			indent_geq_0: an_indendation >= 0
		do
			indendation := an_indendation
		end

	set_ind_character (an_indendation_character: CHARACTER)
			-- Sets the indendation character.
		do
			ind_character := an_indendation_character
		end

	put_string (a_string: STRING)
			-- <Precursor>
			-- String is automatically indendated and a new line added.
		do
			indendate
			Precursor (a_string)
			put_new_line
		end

	append_string (a_string: STRING)
			-- Appends a string without indendation
		do
			put_string (a_string)
		end

	indent
			-- Indents by one character
		do
			indendation := indendation + 1
		end

	unindent
			-- Unindents by one character
		require
			indendation > 0
		do
			indendation := indendation - 1
		ensure
			indendation >= 0
		end

feature {INDENDATION_STREAM} -- Implementation

	indendate
			-- Appends the indendantion to the stream
		local
			i: NATURAL
		do
			from
				i := 1
			until
				i > indendation
			loop
				put_character (ind_character)
				i := i + 1
			end
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
