indexing
	description: "Description or specification of an entry point for a function in a DLL"
	status: "See notice at end of class"
	author: "Marina Nudelman";
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

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1988-1999 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support http://support.eiffel.com
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

