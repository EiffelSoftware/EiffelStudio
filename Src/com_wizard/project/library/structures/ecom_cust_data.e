indexing
	description: "COM CUSTDATA structure"
	status: "See notice at end of class"
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

