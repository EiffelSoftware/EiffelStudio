indexing
	description: "COM API functions"
	note: "Do not call or inherite from this class, use ECOM_ROUTINES instead."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_COM

inherit
	
	MEMORY
		redefine
			dispose
		end	

feature -- Basic operations

	co_initialize is
			-- initializes the Component Object Model(COM) library
		do
			ccom_co_initialize (default_pointer)
			initialize_counter := initialize_counter + 1
		end

	co_uninitialize is
			-- Closes the OLE Component Object Model (COM) library
		require
			positive_counter: initialize_counter > 0
		do
			ccom_co_uninitialize
			initialize_counter := initialize_counter - 1
		end

feature -- Access

	initialize_counter: INTEGER
			-- Number of times `co_initialize' is called
			-- and was not matched by `co_unonitialize'

feature {NONE} -- Implementation

	dispose is
		do
			from
			variant
				initialize_counter
			until
				initialize_counter = 0
			loop
				co_uninitialize
			end
		end

feature {NONE} -- Externals

	ccom_co_initialize (p: POINTER) is
		external
			"C | <windows.h>"
		alias
			"CoInitialize"
		end

	ccom_co_uninitialize is
		external
			"C | <windows.h>"
		alias
			"CoUninitialize"
		end

invariant
	positive_counter: initialize_counter > 0

end -- class ECOM_COM

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

