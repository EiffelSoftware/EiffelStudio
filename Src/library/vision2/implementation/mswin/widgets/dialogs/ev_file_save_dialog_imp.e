indexing 
	description:
		"Eiffel Vision file open dialog. Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FILE_SAVE_DIALOG_IMP

inherit
	EV_FILE_SAVE_DIALOG_I

	EV_FILE_DIALOG_IMP

	WEL_SAVE_FILE_DIALOG
		rename
			make as wel_make,
			file_name as wel_file_name,
			set_file_name as wel_set_file_name,
			set_filter as wel_set_filter,
			set_filter_index as wel_set_filter_index,
			set_initial_directory as wel_set_initial_directory,
			file_title as wel_file_title,			
			dispose as destroy
		end

create
	make

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

end -- class EV_SAVE_OPEN_DIALOG_IMP

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
--| Revision 1.6  2001/06/07 23:08:14  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.3.8.2  2000/09/05 16:48:06  rogers
--| Added deferred features from EV_POSTIONABLE and EV_POSITIONED. These
--| features need to be implemented.
--|
--| Revision 1.3.8.1  2000/05/03 19:09:22  oconnor
--| mergred from HEAD
--|
--| Revision 1.5  2000/03/07 01:53:25  brendel
--| Released
--|
--| Revision 1.4  2000/02/14 11:40:42  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.3.10.4  2000/01/27 23:51:50  brendel
--| Removed default_extension.
--| Now uses own implementation of file_title.
--|
--| Revision 1.3.10.3  2000/01/27 19:30:18  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.3.10.2  2000/01/27 18:09:21  brendel
--| Implemented in compliance with new interface.
--|
--| Revision 1.3.10.1  1999/11/24 17:30:25  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.3.6.2  1999/11/02 17:20:08  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
