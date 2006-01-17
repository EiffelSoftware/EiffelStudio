indexing
	description: "Constants used in DUMP_VALUE and its clients to value the types"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	DUMP_VALUE_CONSTANTS

feature -- Type identifiant in context of DUMP_VALUE

	Type_unknown		: INTEGER is 0
	Type_boolean		: INTEGER is 1
	Type_character		: INTEGER is 2
	Type_integer_32		: INTEGER is 3
	Type_integer_64		: INTEGER is 4
	Type_natural_32		: INTEGER is 5
	Type_natural_64		: INTEGER is 6	
	Type_real_32		: INTEGER is 7
	Type_real_64		: INTEGER is 8
	Type_bits			: INTEGER is 9
	Type_pointer		: INTEGER is 10
	Type_object			: INTEGER is 11
	Type_string			: INTEGER is 12
	Type_string_dotnet	: INTEGER is 13
	Type_expanded_object: INTEGER is 14
	Type_exception		: INTEGER is 20;

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

end -- class DUMP_VALUE_CONSTANTS
