indexing
	description: "COM CUSTDATAITEM structure"
	status: "See notice at end of class"
	author: "Marina Nudelman"
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_CUST_DATA_ITEM

inherit
	ECOM_STRUCTURE

creation
	make,
	make_by_pointer

feature -- Access

	guid: ECOM_GUID is
			-- GUID
		do
			!!Result.make_by_pointer (ccom_custdataitem_guid (item))
		ensure
			Result /= Void
		end

	variant_structure: ECOM_VARIANT is
			-- VARIANT structure
		do
			!!Result.make_by_pointer (ccom_custdataitem_variant (item))
		ensure
			Result /= Void
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size of CUSTDATAITEM structure
		do
			Result := c_size_of_cust_data_item
		end

feature {NONE} -- Externals

	c_size_of_cust_data_item: INTEGER is
		external 
			"C [macro %"E_custdataitem.h%"]"
		alias
			"sizeof(CUSTDATAITEM)"
		end

	ccom_custdataitem_guid (a_ptr: POINTER): POINTER is
		external
			"C [macro %"E_custdataitem.h%"](EIF_POINTER): EIF_POINTER"
		end

	ccom_custdataitem_variant (a_ptr: POINTER): POINTER is
		external
			"C [macro %"E_custdataitem.h%"](EIF_POINTER): EIF_POINTER"
		end

end -- class ECOM_CUST_DATA_ITEM
