note
	description: "[
		Used to write plain text to a file. Indendation is automatically handled.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XU_INDENDATION_STREAM

create
	make

feature -- Access

	indendation: NATURAL
			-- By how many times strings should be indendanted with `ind_character'

	ind_character: CHARACTER
			-- Indendantion character

	stream: IO_MEDIUM
			-- Stream on which we want to write

feature -- Initialization

	make (a_stream: IO_MEDIUM)
			-- `a_stream' the stream on which it should write
		require
			a_stream_attached: a_stream /= Void
		do
			stream := a_stream
			ind_character := '%T'
		end

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
			-- String is automatically indendated and a new line added.
		require
			a_string_attached: a_string /= Void
		do
			indendate
			stream.put_string (a_string)
			stream.put_new_line
		end

	put_new_line
		do
			stream.put_new_line
		end

	append_string (a_string: STRING)
			-- Appends a string without indendation
		require
			a_string_attached: a_string /= Void
		do
			stream.putstring (a_string)
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

feature {XU_INDENDATION_STREAM} -- Implementation

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
				stream.put_character (ind_character)
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
