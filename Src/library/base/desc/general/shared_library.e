indexing

	description:
		"Platform independent abstraction of a shared library";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class SHARED_LIBRARY

inherit
	SHARED_LIBRARY_CONSTANTS

feature {NONE} -- Initialization

	make (lib_name: STRING) is
			-- Load shared library `lib_name'
		require
			non_Void: lib_name /= Void
			non_empty: not lib_name.empty
		deferred
		ensure
			consistent: lib_name.is_equal (library_name)
		end

feature -- Access

	library_name: STRING is
			-- Name of shared library
		deferred
		end

feature -- Status report

	error_code: INTEGER is
			-- Current status of the library
		deferred
		end

	meaningful: BOOLEAN is
			-- Is the library currently loaded?
		do
			Result := error_code = No_error
		end

invariant

	meaningful_definition: meaningful = (error_code = No_error)

end -- class SHARED_LIBRARY

--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

