indexing
	description:
		"Eiffel Vision frame. GTK+ implementation"
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FRAME_IMP

inherit
	EV_FRAME_I
		redefine
			interface
		end

	EV_CELL_IMP
		undefine
			make
		redefine
			interface
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create frame.
		do
			base_make (an_interface)
			set_c_object (C.gtk_frame_new (NULL))
		end

feature -- Access

	style: INTEGER is
			-- Visual appearance. See: EV_FRAME_CONSTANTS.
		local
			gtk_style: INTEGER
		do
			gtk_style := C.gtk_frame_struct_shadow_type (c_object)
			if gtk_style = C.Gtk_shadow_in_enum then
				Result := Ev_frame_lowered
			elseif gtk_style = C.Gtk_shadow_out_enum then
				Result := Ev_frame_raised
			elseif gtk_style = C.Gtk_shadow_etched_in_enum then
				Result := Ev_frame_etched_in
			elseif gtk_style = C.Gtk_shadow_etched_out_enum then
				Result := Ev_frame_etched_out
			else
				check
					valid_value: False
				end
			end
		end

feature -- Element change

	set_style (a_style: INTEGER) is
			-- Assign `a_style' to `style'.
		local
			gtk_style: INTEGER
			border_width: INTEGER
		do
			inspect a_style
				when Ev_frame_lowered then
					gtk_style := C.Gtk_shadow_in_enum
					border_width := 1
				when Ev_frame_raised then
					gtk_style := C.Gtk_shadow_out_enum
					border_width := 1
				when Ev_frame_etched_in then
					gtk_style := C.Gtk_shadow_etched_in_enum
					border_width := 2
				when Ev_frame_etched_out then
					gtk_style := C.Gtk_shadow_etched_out_enum
					border_width := 2
			else
				check
					valid_value: False
				end
			end
			--| FIXME incorporate border_width.
			--| NB This is not gtk_container_set_border_width!
			--| Maybe we have to draw the frame ourselves.
			C.gtk_frame_set_shadow_type (c_object, gtk_style)
		end

feature -- Status setting

	align_text_left is
			-- Display `text' left aligned.
		do
			C.gtk_frame_set_label_align (c_object, 0, 0)
		end

	align_text_right is
			-- Display `text' right aligned.
		do
			C.gtk_frame_set_label_align (c_object, 0.5, 0)
		end
        
	align_text_center is
			-- Display `text' centered.
		do
			C.gtk_frame_set_label_align (c_object, 1, 0)
		end

feature -- Status report

	text: STRING is
			-- Text of the frame
		local
			p: POINTER
		do
			p := C.gtk_frame_struct_label (c_object)
			if p /= NULL then
				create Result.make_from_c (p)
				if Result.count = 0 then
					Result := Void
				end
			end
		end

feature -- Element change

	set_text (a_text: STRING) is
			-- set the `text' of the frame
		do
			C.gtk_frame_set_label (c_object, eiffel_to_c (a_text))
		end

	remove_text is
			-- Make `text' `Void'.
		do
			C.gtk_frame_set_label (c_object, NULL)
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_FRAME
			-- Provides a common user interface to possibly platform
			-- dependent functionality implemented by `Current'

end -- class EV_FRAME_IMP

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
--| Revision 1.13  2000/06/07 17:27:37  oconnor
--| merged from DEVEL tag MERGED_TO_TRUNK_20000607
--|
--| Revision 1.7.4.2  2000/05/25 00:35:50  king
--| Implemented external in Eiffel
--|
--| Revision 1.7.4.1  2000/05/03 19:08:48  oconnor
--| mergred from HEAD
--|
--| Revision 1.12  2000/05/02 18:55:28  oconnor
--| Use NULL instread of Defualt_pointer in C code.
--| Use eiffel_to_c (a) instead of a.to_c.
--|
--| Revision 1.11  2000/04/28 22:03:34  brendel
--| Tried to change border width to 1 for lowered and raised but this attempt
--| failed. See code.
--|
--| Revision 1.10  2000/04/27 17:35:07  brendel
--| Implemented `style' and `set_style'.
--|
--| Revision 1.9  2000/02/22 18:39:38  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.8  2000/02/14 11:40:31  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.7.6.7  2000/02/04 04:25:38  oconnor
--| released
--|
--| Revision 1.7.6.6  2000/01/27 19:29:43  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.7.6.5  2000/01/20 18:48:35  oconnor
--| handle new non deferred EV_CELL class inheritnce
--|
--| Revision 1.7.6.4  2000/01/18 19:42:46  oconnor
--| formatting
--|
--| Revision 1.7.6.3  2000/01/18 19:36:14  oconnor
--| implemented textable features
--|
--| Revision 1.7.6.2  2000/01/18 07:12:39  oconnor
--| redefined interface to be of more refined type
--|
--| Revision 1.7.6.1  1999/11/24 17:29:54  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.7.2.3  1999/11/17 01:53:03  oconnor
--| removed "child packing" hacks and obsolete _ref _unref wrappers
--|
--| Revision 1.7.2.2  1999/11/02 17:20:04  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
