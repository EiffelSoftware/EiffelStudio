--| FIXME Not for release
indexing 
	description: "Eiffel Vision directory dialog."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_DIRECTORY_DIALOG_IMP

inherit
	EV_DIRECTORY_DIALOG_I

	EV_STANDARD_DIALOG_IMP

	WEL_CHOOSE_FOLDER_DIALOG
		rename
			make as wel_make,
			dispose as destroy
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Initialize.
		do
			base_make (an_interface)
			wel_make
		end

	initialize is
		do
			is_initialized := True
		end

feature -- Access

	directory: STRING is
			-- Path of the current selected file
		do
			Result := folder_name
		end

	start_directory: STRING is
			-- Base directory where browsing will start.
		do
			check
				to_be_implemented: False
			end
		end

feature -- Element change

	set_start_directory (a_path: STRING) is
			-- Make `a_path' the base directory.
		do
			check
				to_be_implemented: False
			end
		end

end -- class EV_DIRECTORY_DIALOG_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.5  2000/02/14 11:40:42  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.4.10.3  2000/01/28 01:34:49  brendel
--| Implemented complying with new interface.
--|
--| Revision 1.4.10.2  2000/01/27 19:30:18  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.4.10.1  1999/11/24 17:30:24  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.4.6.2  1999/11/02 17:20:08  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
