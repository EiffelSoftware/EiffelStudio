indexing 
	description: "EiffelVision font selection dialog, mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FONT_DIALOG_IMP

inherit
	EV_FONT_DIALOG_I
		redefine
			interface
		end

	EV_STANDARD_DIALOG_IMP
		redefine
			interface
		end

	WEL_CHOOSE_FONT_DIALOG
		rename
			make as wel_make,
			set_parent as wel_set_parent
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

	initialize is
			-- Initialize `Current'.
		do
				-- We must set the style of `Current'.
				-- Modifying the flags changes the appearence.
			set_flags (Cf_screenfonts + Cf_inittologfontstruct + Cf_noscriptsel)
			is_initialized := True
		end

feature -- Access
	
	font: EV_FONT is
			-- Font currently selected in `Current'.
		local
			wel_font: WEL_FONT
			ev_font: EV_FONT
			font_imp: EV_FONT_IMP
		do
			create wel_font.make_indirect (log_font)
			create ev_font
			font_imp ?= ev_font.implementation
			font_imp.set_by_wel_font (wel_font)
			Result := ev_font
		end

	title: STRING is "Font"
			-- Title of `Current'.

feature -- Element change

	set_title (new_title: STRING) is
			-- Assign `new_title' to `title'.
		do
			--|FIXME
		end

	set_font (a_font: EV_FONT) is
			-- Set the initial font to `a_font'
		local
			font_imp: EV_FONT_IMP
			wel_font: WEL_LOG_FONT
			f_name: STRING
		do
			font_imp ?= a_font.implementation
			wel_font := font_imp.wel_log_font
			f_name := wel_font.face_name
			if f_name.is_empty and then not font_imp.preferred_faces.is_empty  then
				wel_font.set_face_name (font_imp.preferred_faces @ 1)
			end
			set_log_font (wel_font)
		end

feature -- Element change

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

	destroy is
			-- Destroy `Current'.
		do
			destroy_item
		end

feature {EV_ANY_I}

	interface: EV_FONT_DIALOG

end -- class EV_FONT_DIALOG_IMP

--|-----------------------------------------------------------------------------
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
--|-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.9  2001/06/07 23:08:14  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.7.4.9  2001/05/20 10:31:27  pichery
--| In `set_font', when the given font has no face name, use the first choice
--| in `preferred_faces'.
--|
--| Revision 1.7.4.8  2001/02/01 18:22:34  rogers
--| Removed fixme not for release and not reviewed. title is now a constant.
--| Comments.
--|
--| Revision 1.7.4.7  2001/01/31 20:05:27  rogers
--| Exported interface to EV_ANY_I.
--|
--| Revision 1.7.4.6  2001/01/31 19:54:31  rogers
--| Redefined interface. Initial implementation of font.
--|
--| Revision 1.7.4.4  2000/11/02 03:18:44  manus
--| Removed non-used local variables
--|
--| Revision 1.7.4.3  2000/09/06 02:29:20  manus
--| Added missing stuff from new EV_POSITIONNED_I.
--|
--| Revision 1.7.4.2  2000/08/08 02:20:15  manus
--| On a dialog messages should be left aligned.
--|
--| Revision 1.7.4.1  2000/05/03 19:09:22  oconnor
--| mergred from HEAD
--|
--| Revision 1.8  2000/02/14 11:40:42  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.7.6.2  2000/01/27 19:30:18  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.7.6.1  1999/11/24 17:30:25  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.7.2.3  1999/11/02 17:20:08  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
