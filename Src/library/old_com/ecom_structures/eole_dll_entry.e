indexing

	description: "Description or specification of an entry point for a function in a DLL"
	note: "The attributes in the 'Implementation' part may seem to%
			%be useless but are needed for implementation reasons";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	EOLE_DLL_ENTRY
		
feature -- Access

	name: EOLE_BSTR
			-- Dll name
		
	entry_point: EOLE_BSTR
			-- Entry point name (if function
			-- not defined by ordinal)
		
	ordinal: POINTER
			-- Ordinal that defines function
			-- (if function defined by ordinal)
		
feature -- Element change

	set_name (n: EOLE_BSTR) is
			-- set `dll_name' with `n'
		do
			name := n
		end

	set_entry_point (n: EOLE_BSTR) is
			-- set `entry_point_name' with `n'
		do
			entry_point := n
		end

	set_ordinal (ord: POINTER) is
			-- set `function_ordinal' with `ord'
		do
			ordinal := ord
		end
		
end -- class EOLE_DLL_ENTRY

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--| Based on WINE library, copyright (C) Object Tools, 1996-1998.
--| Modifications and extensions: copyright (C) ISE, 1998.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

