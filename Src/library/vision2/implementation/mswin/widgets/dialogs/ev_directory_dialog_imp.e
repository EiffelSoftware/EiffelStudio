indexing 
	description: "Eiffel Vision directory dialog."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_DIRECTORY_DIALOG_IMP

inherit
	EV_DIRECTORY_DIALOG_I
		redefine
			interface
		end

	EV_STANDARD_DIALOG_IMP
		redefine
			interface
		end

	WEL_CHOOSE_FOLDER_DIALOG
		rename
			make as wel_make,
			dispose as destroy
		end

	WEL_WINDOWS_VERSION

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
			-- Set new UI style for dialog if supported.
		do
			if shell32_version >= version_500 then
				-- See header comment of {WEL_BIF_CONSTANTS}.Bif_usenewui
				add_flag (Bif_usenewui)
			end
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
			Result := starting_folder
		end

feature -- Element change

	set_start_directory (a_path: STRING) is
			-- Make `a_path' the base directory.
		do
			set_starting_folder (a_path)
		end

feature {EV_ANY_I}

	--| FIXME These features are all required by EV_POSITIONED and
	--| EV_POSITIONABLE. Is there a way to implement these?

	set_x_position (a: INTEGER) is
		do
			check
				to_be_implemented: FALSE
			end
		end

	set_y_position (a: INTEGER) is
		do
			check
				to_be_implemented: FALSE
			end
		end

	set_height (a: INTEGER) is
		do
			check
				to_be_implemented: FALSE
			end
		end

	set_width (a: INTEGER) is
		do
			check
				to_be_implemented: FALSE
			end
		end

	set_size (a, b: INTEGER) is
		do
			check
				to_be_implemented: FALSE
			end
		end

	x_position: INTEGER is
		do
			check
				to_be_implemented: FALSE
			end
		end

	y_position: INTEGER is
		do
			check
				to_be_implemented: FALSE
			end
		end

	screen_x: INTEGER is
		do
			check
				to_be_implemented: FALSE
			end
		end

	screen_y: INTEGER is
		do
			check
				to_be_implemented: FALSE
			end
		end

	width: INTEGER is
		do
			check
				to_be_implemented: FALSE
			end
		end

	set_position (a, b: INTEGER) is
		do
			check
				to_be_implemented: FALSE
			end
		end

	height: INTEGER is
		do
			check
				to_be_implemented: FALSE
			end
		end

	minimum_width: INTEGER is
		do
			check
				to_be_implemented: FALSE
			end
		end

	minimum_height: INTEGER is
		do
			check
				to_be_implemented: FALSE
			end
		end

feature {EV_ANY_I}

	interface: EV_DIRECTORY_DIALOG

end -- class EV_DIRECTORY_DIALOG_IMP

--|-----------------------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2000 Interactive Software Engineering Inc.
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
--|-----------------------------------------------------------------------------

--|----------------------------------------------------------------
--| CVS log
--|----------------------------------------------------------------
--|
--| $Log$
--| Revision 1.11  2001/07/14 12:46:25  manus
--| Replace --! by --|
--|
--| Revision 1.10  2001/07/14 12:16:30  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.9  2001/06/07 23:08:14  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.4.8.5  2001/01/31 19:48:43  rogers
--| Redefined interface.
--|
--| Revision 1.4.8.4  2000/12/06 15:53:10  pichery
--| Implemented `set_starting_directory' and `starting_directory'.
--|
--| Revision 1.4.8.3  2000/09/05 17:44:21  rogers
--| Implemented deferred features from EV_POSITIONABLE_I AND EV_POSITIONED_I.
--| All these features need to be implemented.
--|
--| Revision 1.4.8.2  2000/08/11 18:58:26  rogers
--| Fixed copyright clauses. Now use ! instead of |.
--|
--| Revision 1.4.8.1  2000/05/03 19:09:21  oconnor
--| mergred from HEAD
--|
--| Revision 1.8  2000/03/15 16:55:25  brendel
--| Changed magic number 64 with BIF_USENEWUI.
--|
--| Revision 1.7  2000/03/14 23:51:43  brendel
--| Added step to initialization that takes advantage of new choose folder
--| dialogs in version 5.00 of shell32.dll, if present.
--|
--| Revision 1.6  2000/03/07 01:53:25  brendel
--| Released
--|
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
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
