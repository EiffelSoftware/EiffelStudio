indexing
	description: "Description or specification of an entry point for a function in a DLL"
	status: "See notice at end of class"
	date: "$Date$";
	revision: "$Revision$"

class
	ECOM_DLL_ENTRY
		
feature -- Access

	dll_name: STRING
			-- Dll name
		
	entry_point: STRING
			-- Entry point name (if function
			-- not defined by ordinal)
		
	ordinal: INTEGER
			-- Ordinal that defines function
			-- (if function defined by ordinal)
		
feature -- Element change

	set_dll_name (n: STRING) is
			-- set `dll_name' with `n'
		do
			dll_name := n
		end

	set_entry_point (n: STRING) is
			-- set `entry_point_name' with `n'
		do
			entry_point := n
		end

	set_ordinal (ord: INTEGER) is
			-- set `function_ordinal' with `ord'
		do
			ordinal := ord
		end
		
end -- class ECOM_DLL_ENTRY

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

