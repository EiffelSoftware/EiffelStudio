indexing
	description: "COM CUSTDATA structure"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_CUST_DATA

inherit
	ECOM_STRUCTURE
	
creation
	make,
	make_by_pointer

feature -- Access

	count_items: INTEGER is
			-- Number of CUSTDATAITEMs
		do
			Result := ccom_custdata_items (item)
		end

	cust_data_items: ARRAY [ECOM_CUST_DATA_ITEM] is
			-- Array of custom data items
		do
			Result := ccom_custdata_array (item)
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size of CUSTDATA structure
		do
			Result := c_size_of_cust_data 
		end

feature {NONE} -- Externals

	c_size_of_cust_data: INTEGER is
		external 
			"C [macro %"E_custdata.h%"]"
		alias
			"sizeof(CUSTDATA)"
		end

	ccom_custdata_items (a_ptr: POINTER): INTEGER is
		external
			"C [macro %"E_custdata.h%"](EIF_POINTER): EIF_INTEGER"
		end

	ccom_custdata_array (a_ptr: POINTER): ARRAY [ECOM_CUST_DATA_ITEM] is
		external
			"C (EIF_POINTER): EIF_REFERENCE | %"E_custdata.h%""
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
end -- class ECOM_CUST_DATA

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

