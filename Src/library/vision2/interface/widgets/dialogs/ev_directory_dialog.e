indexing 
	description: "EiffelVision file selection dialog."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_DIRECTORY_DIALOG

inherit
	EV_SELECTION_DIALOG
		redefine
			implementation
		end

create
	make,
	make_with_text

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create a directory selection dialog with `par' as
			-- parent.
		do
			!EV_DIRECTORY_DIALOG_IMP! implementation.make (par)
		end

	make_with_text (par: EV_CONTAINER; txt: STRING) is
			-- Create a directory selection dialog with `par' as
			-- parent and `txt' as title.
		do
			!EV_DIRECTORY_DIALOG_IMP! implementation.make_with_text (par, txt)
		end

feature -- Access

	title: STRING is
			-- Title of the current dialog
		require
			exists: not destroyed
		do
			Result := implementation.title
		end

feature -- Status report

	directory: STRING is
			-- Path of the current selected file
		require
			exists: not destroyed
		do
			Result := implementation.directory
		end

feature -- Element change

	set_title (a_title: STRING) is
			-- Make `a_title' the new title of the current dialog.
		require
			exists: not destroyed
			valid_title: a_title /= Void
		do
			implementation.set_title (a_title)
		end

	set_base_directory (path: STRING) is
			-- Make `path' the base directory in determining files
			-- to be displayed.
		require
			exists: not destroyed
			valid_path: path /= Void
		do
			implementation.set_base_directory (path)
		end

feature -- Implementation

	implementation: EV_DIRECTORY_DIALOG_I

end -- class EV_DIRECTORY_DIALOG

--!----------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
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
--!----------------------------------------------------------------
