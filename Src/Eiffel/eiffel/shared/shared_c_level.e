note
	description: "[
			Internal levels used to encode C types.
			Those values have to match with run-time source file "update.h".
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class SHARED_C_LEVEL

feature

	C_void: INTEGER = 1
	C_char: INTEGER = 2
	c_boolean: INTEGER = 3
	c_uint8: INTEGER = 4
	C_int8: INTEGER = 5
	c_uint16: INTEGER = 6
	C_int16: INTEGER = 7
	C_wide_char: INTEGER = 8
	c_uint32: INTEGER = 9
	C_int32: INTEGER = 10
	C_real32: INTEGER = 11
	c_uint64: INTEGER = 12
	C_int64: INTEGER = 13
	C_real64: INTEGER = 14
	C_ref: INTEGER = 15
	C_pointer: INTEGER = 16
	C_nb_types: INTEGER = 17;
			-- Number of internal C types

note
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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

end
