indexing
	description: "Features to access last browsed directory."
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_BROWSE_DIRECTORY

inherit
	WIZARD_EXECUTION_ENVIRONMENT

feature -- Access

	Eiffelcom_browse_directory: STRING is "EIFFELCOM_PATH"
			-- Environment variable for browsing.

	browse_directory: STRING is
			-- Browse directory.
		do
			if browse_directory_cell.item /= Void then
				Result := browse_directory_cell.item

			elseif (execution_environment.get (Eiffelcom_browse_directory) /= Void) then
				Result := execution_environment.get (Eiffelcom_browse_directory)
				set_browse_directory (Result)

			else
				Result := "c:\"
				set_browse_directory (Result)
			end
		end

feature -- Basic operations

	set_browse_directory (a_directory: STRING) is
			-- Set browse directory.
		require
			non_void_directory: a_directory /= Void
			valid_directory: not a_directory.is_empty
		do
			browse_directory_cell.put (a_directory)
			execution_environment.put (a_directory, Eiffelcom_browse_directory)
		end

	safe_browse_directory_from_dialog (a_file_dialog: WEL_FILE_DIALOG) is
			-- Safe last open directory.
		local
			a_name, a_title: STRING	
		do
			if a_file_dialog.selected then
				a_name := clone (a_file_dialog.file_name)
				a_title := a_file_dialog.file_title
				a_name.head (a_name.count - a_title.count)
				set_browse_directory (a_name)
			end
		end

feature {NONE} -- Implementation

	browse_directory_cell: CELL [STRING] is
			-- Browse directory shell
		once
			create Result.put (Void)
		end

end -- class WIZARD_BROWSE_DIRECTORY

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1988-2000 Interactive Software Engineering Inc.
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

