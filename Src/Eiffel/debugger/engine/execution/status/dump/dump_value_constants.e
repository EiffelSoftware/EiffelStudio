note
	description: "Constants used in DUMP_VALUE and its clients to value the types"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	DUMP_VALUE_CONSTANTS

feature -- Type identifiant in context of DUMP_VALUE

	Type_unknown		: INTEGER = 0
	Type_boolean		: INTEGER = 1
	Type_character_8	: INTEGER = 2
	Type_character_32 	: INTEGER = 3

	Type_integer_8		: INTEGER = 4
	Type_integer_16		: INTEGER = 5
	Type_integer_32		: INTEGER = 6
	Type_integer_64		: INTEGER = 7

	Type_natural_8		: INTEGER = 8
	Type_natural_16		: INTEGER = 9
	Type_natural_32		: INTEGER = 10
	Type_natural_64		: INTEGER = 11

	Type_real_32		: INTEGER = 12
	Type_real_64		: INTEGER = 13
	Type_bits			: INTEGER = 14
	Type_pointer		: INTEGER = 15

	Type_object			: INTEGER = 16
	Type_manifest_string: INTEGER = 17
	Type_string_dotnet	: INTEGER = 18
	Type_expanded_object: INTEGER = 19
	Type_exception		: INTEGER = 20
	Type_procedure_return: INTEGER = 21;

note
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

end -- class DUMP_VALUE_CONSTANTS
