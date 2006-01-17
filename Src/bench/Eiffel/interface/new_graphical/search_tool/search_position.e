indexing
	description: "Objects that designate the position of a searched word or expression in a file"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"

class
	SEARCH_POSITION

create
	make

feature {NONE} -- Initialization

	make (char_cnt: INTEGER; lgth: INTEGER) is
			-- creates an object with `line_nb' as `line_number' and
			-- `character_cnt' as `character_count'
		require
			valid_character_cnt: char_cnt > 0
			valid_length: lgth > 0 	
		do
			character_count := char_cnt
			length := lgth			
		end

feature -- Access

	character_count : INTEGER
		-- position of the word or expression in the file

	length : INTEGER
		-- length of the word or expression

feature -- Element change

	add_offset (an_offset: INTEGER) is
			-- add `an_offset' to character_count
		do
			character_count := character_count + an_offset
		end
	
	set_character_count (n: INTEGER) is
			-- set `character_count' to 'n'
		require
			valid_character_cnt: n > 0
		do
			character_count := n
		ensure
			character_count = n
		end

	set_length (n: INTEGER) is
			-- set `line_number' to 'n'
		require
			valid_length: n > 0
		do
			length := n
		ensure
			length = n
		end

invariant
		valid_character_cnt: character_count > 0		
		valid_length: length > 0 	

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

end -- class SEARCH_POSITION
