indexing
	description: "SAFEARRAYBOUND structure"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_SAFE_ARRAY_BOUND

inherit
	ECOM_STRUCTURE

creation
	make,
	make_from_pointer

feature {NONE} -- Initialization

	make_from_pointer (a_pointer: POINTER) is
			-- Make from pointer.
		do
			make_by_pointer (a_pointer)
		end

feature -- Access

	element_count: INTEGER is
			-- Number of elements in dimension
		do
			Result := ccom_safearraybound_elements (item)
		end

	lower_bound: INTEGER is
			-- Lower bound of dimension
		do
			Result := ccom_safearraybound_low_bound (item)
		end

feature -- Element change

	set_count (a_count: INTEGER) is
			-- Set number of elements
		do
			ccom_safearraybound_set_elements (item, a_count)
		end

	set_lower_bound (a_bound: INTEGER) is
			-- Set lower bound
		do
			ccom_safearraybound_set_low_bound (item, a_bound)
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size of SAFEARRAYBOUND structure
		do
			Result := c_size_of_safe_array_bound
		end

feature {NONE} -- Externals

	c_size_of_safe_array_bound: INTEGER is
		external 
			"C [macro %"E_safearraybound.h%"]"
		alias
			"sizeof(SAFEARRAYBOUND)"
		end

	ccom_safearraybound_elements (a_ptr: POINTER): INTEGER is
		external
			"C [macro %"E_safearraybound.h%"](EIF_POINTER): EIF_INTEGER"
		end

	ccom_safearraybound_low_bound (a_ptr: POINTER): INTEGER is
		external
			"C [macro %"E_safearraybound.h%"](EIF_POINTER): EIF_INTEGER"
		end

	ccom_safearraybound_set_elements (a_ptr: POINTER; a_int: INTEGER) is
		external
			"C [macro %"E_safearraybound.h%"](EIF_POINTER, EIF_INTEGER)"
		end

	ccom_safearraybound_set_low_bound (a_ptr: POINTER; a_int: INTEGER) is
		external
			"C [macro %"E_safearraybound.h%"](EIF_POINTER, EIF_INTEGER)"
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
end -- class ECOM_SAFE_ARRAY_BOUND

--+----------------------------------------------------------------
--| EiffelCOM Wizard
--| Copyright (C) 1999-2005 Eiffel Software. All rights reserved.
--| Eiffel Software Confidential
--| Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+----------------------------------------------------------------

