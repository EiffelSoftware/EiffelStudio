indexing
	description: "Constants for special errors."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SPECIAL_CONST

feature -- Access: STRING

	string_case_1: STRING is "Class STRING must have an attribute `area' of type SPECIAL [CHARACTER]"

	string_case_2: STRING is "Class STRING must have exactly one attribute of reference type"

	string_case_3: STRING is "Class STRING must have at least one creation procedure having an integer argument"

	string_case_4: STRING is "Class STRING must have a procedure with an integer argument named `set_count'"

	string_case_5: STRING is "Class STRING must have an attribute of type integer named `internal_hash_code'"

feature -- Access: ARRAY

	array_case_1: STRING is "Class ARRAY must have exactly one formal generic parameter"

	array_case_2: STRING is "Class ARRAY must have an attribute `area' of type SPECIAL [T]"

	array_case_3: STRING is "Class ARRAY must have exactly one attribute of reference type"

	array_case_4: STRING is "Class ARRAY must have at least one creation procedure with two integer arguments"

feature -- Access: SPECIAL

	special_case_1: STRING is "Class SPECIAL must have exactly one formal generic parameter and be marked frozen"

	special_case_2: STRING is "Class SPECIAL must have a procedure `make (INTEGER)'"

	special_case_3: STRING is "Class SPECIAL must have a creation procedure `make (INTEGER)'"

	special_case_4: STRING is "Class SPECIAL must have a feature `item (INTEGER): G#1'"

	special_case_5: STRING is "Class SPECIAL must have a feature `put (G#1, INTEGER)'"

feature -- Access: Basic types

	basic_case_1: STRING is "Classes for basic types may not have generic parameters"

	basic_case_2: STRING is "Classes for basic types must have only one attribute with a good associated type"

	basic_case_3: STRING is "Classes for basic types must have one attribute of name `item'"

	basic_case_4: STRING is "Classes for basic types must have one procedure `set_item'"

	typed_pointer_case_1: STRING is "Class TYPED_POINTER must have one formal generic parameter"

	typed_pointer_case_2: STRING is "Class TYPED_POINTER must have one attribute of type POINTER"

	typed_pointer_case_3: STRING is "Class TYPED_POINTER must have one attribute of name `pointer_item'"

	typed_pointer_case_4: STRING is "Class TYPED_POINTER must have one procedure `set_item'"

feature -- Access: NATIVE_ARRAY

	native_array_case_1: STRING is "Class NATIVE_ARRAY must have one formal generic parameter"

	native_array_case_2: STRING is "Class NATIVE_ARRAY must have exactly one creation procedure `make'"

	native_array_case_3: STRING is "Class NATIVE_ARRAY must have a feature `item (INTEGER): G#1'"

	native_array_case_4: STRING is "Class NATIVE_ARRAY must have a feature `infix %"@%" (INTEGER): G#1'"

	native_array_case_5: STRING is "Class NATIVE_ARRAY must have a feature `put (INTEGER, G#1)'"

	native_array_case_6: STRING is "Class NATIVE_ARRAY must have a feature `count: INTEGER'"

feature -- Access: TYPE

	type_case_1: STRING is "Class TYPE must have one formal generic parameter";

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

end
