indexing
	description:
		"Item for use with EV_STATUS_BAR."
	status: "See notice at end of class."
	keywords: "status, bar, report, message"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_STATUS_BAR_ITEM

obsolete
	"Use any widget as status bar item."

inherit
	EV_FRAME
		redefine
			initialize,
			set_text,
			remove_text,
			align_text_center,
			align_text_left,
			align_text_right,
			text
		end

	EV_FRAME_CONSTANTS
		undefine
			default_create
		end

create
	default_create,
	make_with_text

feature {NONE} -- Initialization

	initialize is
			-- Set up container.
		local
			vb: EV_HORIZONTAL_BOX
		do
			Precursor
			set_style (Ev_frame_lowered)
			create vb
			extend (vb)
			create pixmap_cell
			vb.extend (pixmap_cell)
			create label
			vb.extend (label)
		end

feature -- Access

	text: STRING is
			-- Text displayed in textable.
		do
			Result:= implementation.text
		end 

	pixmap: EV_PIXMAP is
			-- Image displayed on `Current'.
		do
			Result ?= pixmap_cell.item
		end

feature -- Status setting

	align_text_center is
			-- Display `text' centered.
		do
			label.align_text_center
		end

	align_text_right is
			-- Display `text' right aligned.
		do
			label.align_text_right
		end
        
	align_text_left is
			-- Display `text' left aligned.
		do
			label.align_text_left
		end

feature -- Element change

	set_text (a_text: STRING) is
			-- Assign `a_text' to `text'.
		do
			label.set_text (a_text)
		end

	remove_text is
			-- Make `text' `Void'.
		do
			label.remove_text
		end
	
feature -- Obsolete

	set_width (a_width: INTEGER) is
			-- Assign `a_width' to `width'.
		obsolete
			"Manipulate the width from the container it is in."
		do
		end

feature {NONE} -- Implementation

	pixmap_cell: EV_CELL
			-- Container of `pixmap;.

	label: EV_LABEL
			-- Container of `text'.

end -- class EV_STATUS_BAR_ITEM

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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.20  2000/04/28 21:47:06  brendel
--| Made platform independent.
--|
--| Revision 1.19  2000/04/26 21:19:01  brendel
--| Revised.
--|
--| Revision 1.18  2000/04/07 22:15:40  brendel
--| Removed EV_SIMPLE_ITEM from inheritance hierarchy.
--|
--| Revision 1.17  2000/03/24 03:10:22  oconnor
--| formatting and comments
--|
--| Revision 1.16  2000/03/13 22:11:44  king
--| Defined creation procedures
--|
--| Revision 1.15  2000/03/01 20:28:52  king
--| Corrected export clauses for implementation and create_imp/act_seq
--|
--| Revision 1.14  2000/02/29 18:09:08  oconnor
--| reformatted indexing cluase
--|
--| Revision 1.13  2000/02/22 18:39:47  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.12  2000/02/14 11:40:47  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.11.4.6  2000/02/07 20:17:12  king
--| Removed invalid creation procedure declarations
--|
--| Revision 1.11.4.5  2000/02/05 02:47:46  oconnor
--| released
--|
--| Revision 1.11.4.4  2000/02/04 21:15:45  king
--| Added has_parent precond to set-width
--|
--| Revision 1.11.4.3  2000/01/27 19:30:37  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.11.4.2  1999/12/17 21:12:19  rogers
--| Advanced make procedures hav been removed, ready for re-implementation.
--|
--| Revision 1.11.4.1  1999/11/24 17:30:42  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.10.2.3  1999/11/04 23:10:52  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.10.2.2  1999/11/02 17:20:11  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
