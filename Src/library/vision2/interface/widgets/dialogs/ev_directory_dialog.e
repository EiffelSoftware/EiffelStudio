indexing 
	description:
		"Eiffel Vision directory dialog."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_DIRECTORY_DIALOG

inherit
	EV_STANDARD_DIALOG
		redefine
			implementation
		end

create
	default_create

feature -- Access

	directory: STRING is
			-- Path of the currently selected directory.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.directory
		ensure
			bridge_ok: Result /= Void implies
				Result.is_equal (implementation.directory)
		end

	start_directory: STRING is
			-- Base directory where browsing will start.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.start_directory
		ensure
			bridge_ok: Result.is_equal (implementation.start_directory)
		end

feature -- Element change

	set_start_directory (a_path: STRING) is
			-- Make `a_path' the base directory.
		require
			not_destroyed: not is_destroyed
			a_path_not_void: a_path /= Void
			a_path_exists: (create {DIRECTORY}.make (a_path)).exists
		do
			implementation.set_start_directory (a_path)
		ensure
			assigned: start_directory.is_equal (a_path)
		end

feature {EV_ANY_I} -- Implementation

	implementation: EV_DIRECTORY_DIALOG_I
		-- Responsible for interaction with native graphics toolkit.
	
feature {NONE} -- Initialization

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_DIRECTORY_DIALOG_IMP} implementation.make (Current)
		end

end -- class EV_DIRECTORY_DIALOG

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------
