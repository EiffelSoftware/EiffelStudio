indexing 
	description: "EiffelVision color selection dialog.%
		%Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_COLOR_DIALOG_IMP

inherit
	EV_COLOR_DIALOG_I
		redefine
			interface
		end

	EV_STANDARD_DIALOG_IMP
		redefine
			interface
		end

	WEL_CHOOSE_COLOR_DIALOG
		rename
			make as wel_make,
			set_parent as wel_set_parent
		redefine
			wel_make
		end

creation
	make

feature {NONE} -- Implementation

	make (an_interface: like interface) is
			-- Create `Current' with interface `an_interface'.
		do
			base_make (an_interface)
			wel_make
		end

	wel_make is
			-- WEL creation of the dialog
		do
			Precursor {WEL_CHOOSE_COLOR_DIALOG}
			add_flag (Cc_fullopen)
			add_flag (Cc_anycolor)
		end

	initialize is
			-- Initialize `Current'
			--| Currently no need to do anything here.
		do
			is_initialized := True
		end

feature -- Access

	color: EV_COLOR is
			-- `Result' is color selected in `Current'.
		local
			col: WEL_COLOR_REF
		do
			if selected then
				col := rgb_result
				create Result.make_with_8_bit_rgb (col.red, col.green, col.blue)
			else
				Result := stored_color
			end
		end

	title: STRING is "Color"
			-- Title of `Current'.

feature -- Element change

	set_title (new_title: STRING) is
			-- Assign `new_title' to `title'.
		do
			--| FIXME IS it possible in windows to change
			--| the title of this dialog?
		end

	set_color (a_color: EV_COLOR) is
			-- Select `a_color' in `Current'.
		local
			w: WEL_COLOR_REF
		do
			stored_color := a_color
			create w.make_rgb (a_color.red_8_bit, a_color.green_8_bit,
				a_color.blue_8_bit)
			set_rgb_result (w)
		end

	destroy is
			-- Destroy `Current'.
		do
			destroy_item
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

feature {NONE} -- Implementation

	stored_color: EV_COLOR
			-- Kept reference in case the user cancelled the color selection.

feature {EV_ANY_I}

	interface: EV_COLOR_DIALOG

end -- class EV_COLOR_DIALOG_IMP

--|----------------------------------------------------------------
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
--|----------------------------------------------------------------

--|----------------------------------------------------------------
--| CVS log
--|----------------------------------------------------------------
--|
--| $Log$
--| Revision 1.7  2001/07/14 12:16:30  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.6  2001/06/07 23:08:14  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.4.8.15  2001/01/31 19:49:25  rogers
--| Redefined interface.
--|
--| Revision 1.4.8.14  2000/09/13 22:12:46  rogers
--| Changed the style of Precursor.
--|
--| Revision 1.4.8.13  2000/09/05 16:48:21  rogers
--| Added deferred features from EV_POSTIONABLE and EV_POSITIONED. These
--| features need to be implemented.
--|
--| Revision 1.4.8.12  2000/08/14 17:52:31  rogers
--| Removed test code from initialize.
--|
--| Revision 1.4.8.11  2000/08/14 17:41:22  rogers
--| Removed fixme not for release.
--|
--| Revision 1.4.8.10  2000/08/14 17:22:44  rogers
--| Fixed title, so does not fail with full assertions. Improved remaining fixme.
--|
--| Revision 1.4.8.9  2000/07/25 22:33:17  brendel
--| Now stores color to avoid violating precondition of WEL when asked
--| for the color after user cancelled the dialog.
--|
--| Revision 1.4.8.8  2000/07/20 18:58:40  king
--| select_color->set_color
--|
--| Revision 1.4.8.7  2000/07/14 18:42:03  rogers
--| Added is_initialized := True to initialize.
--|
--| Revision 1.4.8.6  2000/06/22 19:43:25  rogers
--| Removed FIXM NOT_REVIEWED. Fomatting. Removed redundent FIXME.
--|
--| Revision 1.4.8.5  2000/06/22 17:22:55  rogers
--| Fixed result of color. Now returns correct color.
--|
--| Revision 1.4.8.4  2000/06/21 20:31:08  rogers
--| Removed unused local variable. Comments, formatting.
--|
--| Revision 1.4.8.3  2000/06/21 19:32:37  rogers
--| Implemented color.
--|
--| Revision 1.4.8.2  2000/06/21 19:10:54  rogers
--| Now inerits from EV_STANDAR_DIALOG_IMP instead of EV_SELECTION_DIALOG_IMP.
--| Adedd initialize, title, set_title, destroy. Removed old command
--| association.
--|
--| Revision 1.4.8.1  2000/05/03 19:09:21  oconnor
--| mergred from HEAD
--|
--| Revision 1.5  2000/02/14 11:40:42  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.4.10.2  2000/01/27 19:30:18  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.4.10.1  1999/11/24 17:30:24  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.4.6.3  1999/11/02 17:20:08  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
