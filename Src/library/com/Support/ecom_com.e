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
			-- Initialize Component Object Model(COM) runtime.
		do
			ccom_co_initialize (default_pointer)
			initialize_counter := initialize_counter + 1
		ensure
			initialize_counter_incremented: initialize_counter = old initialize_counter + 1
		end

	co_uninitialize is
			-- Uninitialize Component Object Model (COM) runtime.
		require
			positive_counter: initialize_counter > 0
		do
			ccom_co_uninitialize
			initialize_counter := initialize_counter - 1
		end

feature -- Access

	initialize_counter: INTEGER
			-- Number of calls to `co_initialize' not matched by 
			-- a call to `co_unonitialize'

feature {NONE} -- Implementation

	dispose is
			-- Call `co_uninitialize' needed number of times.
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

