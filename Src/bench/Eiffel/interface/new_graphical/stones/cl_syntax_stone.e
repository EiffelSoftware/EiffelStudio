indexing
	description: 
		"Class syntax stone."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision $"

class
	CL_SYNTAX_STONE

inherit
	SYNTAX_STONE
		rename
			make as old_make
		undefine
			stone_cursor,
			x_stone_cursor,
			header,
			stone_signature,
			history_name,
			synchronized_stone,
			is_storable
		redefine
			same_as,
			is_valid
		end
		
	CLASSC_STONE
		rename
			make as cl_make,
			file_name as class_file_name
		undefine
			help_text
		redefine
			same_as,
			is_valid
		select
			class_file_name
		end

create
	make

feature {NONE} -- Initialization

	make (a_syntax_message: SYNTAX_MESSAGE; c: CLASS_C) is
		do
			syntax_message := a_syntax_message
			cl_make (c)
		end

feature -- Properties

	same_as (other: STONE): BOOLEAN is
			-- Is `Current' identical to `other'?
		do
			Result := Precursor {SYNTAX_STONE} (other) and then
				Precursor {CLASSC_STONE} (other)
		end
	
	is_valid: BOOLEAN is
			-- Is `Current' meaningful?
		do
			Result := Precursor {SYNTAX_STONE} and then Precursor {CLASSC_STONE}
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

end -- class CL_SYNTAX_STONE
