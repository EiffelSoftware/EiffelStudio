indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class
	XML_TYPE

creation
	make
	
feature -- Initialization

	make is
			-- initialization
		do
			create name.make_empty
		ensure
			non_void_name: name /= Void
		end

feature -- Access

	name: STRING 
			-- Representation of a type in xml.

	pos_in_file: INTEGER		
			-- Position of the type in the xml file.

	number_of_char: INTEGER
			-- Number of char of the type in the xml file.

feature -- Status Setting

	set_name (a_name: like name) is
			-- Set `name' with `a_name'.
		require
			non_void_a_name: a_name /= Void
			not_empty_a_name: not a_name.is_empty
		do
			name := a_name
		ensure
			name_set: name = a_name
		end

	set_pos_in_file (a_pos_in_file: like pos_in_file) is
			-- Set `pos_in_file' with `a_pos_in_file'.
		require
			positive_a_pos_in_file: a_pos_in_file > 0
		do
			pos_in_file := a_pos_in_file
		ensure
			pos_in_file_set: pos_in_file = a_pos_in_file
		end

	set_number_of_char (a_number_of_char: like number_of_char) is
			-- Set `number_of_char' with `a_number_of_char'.
		require
			positive_a_number_of_char: a_number_of_char >= 0
		do
			number_of_char := a_number_of_char
		ensure
			number_of_char_set: number_of_char = a_number_of_char
		end

feature -- Basic Operations

	

invariant
	non_void_name: name /= Void

indexing
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


end -- class XML_TYPE
