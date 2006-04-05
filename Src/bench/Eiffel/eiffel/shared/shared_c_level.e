indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
-- Internal levels used to encode C types
-- Those values have to match with run-time source file "update.h"

class SHARED_C_LEVEL 
	
feature 

	C_void: INTEGER is 0
			-- Internal code for void

	C_char: INTEGER is 1
			-- Internal code for char

	c_uint8: INTEGER is 2
			-- Internal code for 8 bits natural

	C_int8: INTEGER is 3
			-- Internal code for 8 bits integer
			
	c_uint16: INTEGER is 4
			-- Internal code for 16 bits natural

	C_int16: INTEGER is 5
			-- Internal code for 16 bits integer

	C_wide_char: INTEGER is 6
			-- Internal code for unicode char

	c_uint32: INTEGER is 7
			-- Internal code for 32 bits natural

	C_int32: INTEGER is 8
			-- Internal code for long, same as `C_long'
	
	C_real32: INTEGER is 9
			-- Internal code for REAL_32

	c_uint64: INTEGER is 10
			-- Internal code for 64 bits natural

	C_int64: INTEGER is 11
			-- Internal code for 64 bits integer
	
	C_real64: INTEGER is 12
			-- Internal code for double
	
	C_ref: INTEGER is 13
			-- Internal code for reference

	C_pointer: INTEGER is 14
			-- Internal code for pointer type
	
	C_nb_types: INTEGER is 15;
			-- Number of internal C types

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

end
