indexing 
	description:
		"EiffelVision file selection dialog."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_FILE_DIALOG

inherit
	EV_STANDARD_DIALOG
		redefine
			implementation
		end

feature -- Access

	file_name: STRING is
			-- Full name of currently selected file including path.
			-- `Void' if user did not click "OK".
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.file_name
		ensure
			bridge_ok: Result /= Void implies
				Result.is_equal (implementation.file_name)
		end

	filter: STRING is
			-- Filter currently applied to file list.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.filter
		ensure
			bridge_ok: Result.is_equal (implementation.filter)
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

feature -- Status report

	file_title: STRING is
			-- `file_name' without its path.
			-- `Void' if user did not click "OK".
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.file_title
		ensure
			bridge_ok: Result /= Void implies
				Result.is_equal (implementation.file_title)
		end

	file_path: STRING is
			-- Path of `file_name'.
			-- `Void' if user did not click "OK".
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.file_path
		ensure
			bridge_ok: Result /= Void implies
				Result.is_equal (implementation.file_path)
		end

feature -- Element change

	set_filter (a_filter: STRING) is
			-- Set `a_filter' as new filter.
		require
			not_destroyed: not is_destroyed
			a_filter_not_void: a_filter /= Void
		do
			implementation.set_filter (a_filter)
		ensure
			assigned: filter.is_equal (a_filter)
		end

	set_file_name (a_name: STRING) is
			-- Make `a_name' the selected file.
		require
			not_destroyed: not is_destroyed
			a_name_not_void: a_name /= Void
		do
			implementation.set_file_name (a_name)
		ensure
			assigned: file_name.is_equal (a_name)
		end

	set_start_directory (a_path: STRING) is
			-- Make `a_path' the base directory.
		require
			not_destroyed: not is_destroyed
			a_path_not_void: a_path /= Void
		do
			implementation.set_start_directory (a_path)
		ensure
			assigned: start_directory.is_equal (a_path)
		end

feature {EV_ANY_I} -- implementation

	implementation: EV_FILE_DIALOG_I
		-- Responsible for interaction with native graphics toolkit.

invariant
	filter_not_void: filter /= Void
	start_directory_not_void: start_directory /= Void
	file_name_not_void_implies_path_and_title_not_void: file_name /= Void
		implies (file_title /= Void and then file_path /= Void)

end -- class EV_FILE_DIALOG

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

