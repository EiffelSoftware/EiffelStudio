indexing
	description: 
		"Displays an optionally labeled border around a widget."
	appearance:
		"+<`text'>-----+%N%
		%|             |%N%
		%|   `item'    |%N%
		%|             |%N%
		%+-------------+"
	status: "See notice at end of class"
	keywords: "container, frame, box, border, bevel, outline, raised, lowered"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_FRAME

inherit
	EV_CELL
		undefine
			create_implementation
		redefine
			implementation,
			make_for_test
		end

	EV_TEXTABLE
		redefine
			implementation,
			make_for_test
		end

	EV_FRAME_CONSTANTS
		undefine
			default_create
		end

create
	default_create,
	make_with_text,
	make_for_test

feature {NONE} -- Initialization

	create_implementation is
			-- Create implementation of frame.
		do
			create {EV_FRAME_IMP} implementation.make (Current)
		end

	make_for_test is
			-- Create interesting to display.
		local
			style_timer: EV_TIMEOUT
		do
			default_create
			{EV_TEXTABLE} Precursor
			extend (create {EV_LABEL})
			create style_timer.make_with_interval (2500)
			style_timer.actions.extend (~cycle_style)
		end

feature -- Access

	style: INTEGER is
			-- Visual appearance. See: EV_FRAME_CONSTANTS.
		do
			Result := implementation.style
		ensure
			bridge_ok: Result = implementation.style
		end

feature -- Element change

	set_style (a_style: INTEGER) is
			-- Assign `a_style' to `style'.
		require
			a_style_valid: valid_frame_border (a_style)
		do
			implementation.set_style (a_style)
		ensure
			style_assigned: style = a_style
		end

feature {NONE} -- Implementation

	cycle_style is
			-- Set another `style'.
		local
			next_style: INTEGER
			textable: EV_TEXTABLE
		do
			next_style := style + 1
			if not valid_frame_border (next_style) then
				next_style := Ev_frame_lowered
				if text = Void then
					set_text ("Text label")
				else
					remove_text
				end
			end
			set_style (next_style)
			textable ?= item
			if textable /= Void then
				inspect next_style
					when Ev_frame_lowered then textable.set_text ("Lowered")
					when Ev_frame_raised then textable.set_text ("Raised")
					when Ev_frame_etched_in then textable.set_text ("Etched in")
					when Ev_frame_etched_out then textable.set_text ("Etched out")
				end
			end
		end

	implementation: EV_FRAME_I
			-- Responsible for interaction with the native graphics toolkit.

invariant
	valid_style: is_useable implies valid_frame_border (style)

end -- class EV_FRAME

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
--| Revision 1.15  2000/04/28 00:41:56  brendel
--| Incorporated {EV_TEXTABLE}.make_for_test.
--|
--| Revision 1.14  2000/04/27 18:29:38  brendel
--| Improved make_for_test.
--|
--| Revision 1.13  2000/04/27 17:31:08  brendel
--| Improved make_for_test.
--|
--| Revision 1.11  2000/03/17 23:48:19  oconnor
--| comments
--|
--| Revision 1.10  2000/03/01 19:48:53  king
--| Corrected export clauses for implementation and create_imp/act_seq
--|
--| Revision 1.9  2000/03/01 03:30:06  oconnor
--| added make_for_test
--|
--| Revision 1.8  2000/02/22 18:39:51  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.7  2000/02/14 11:40:51  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.6.6.9  2000/02/05 04:14:39  oconnor
--| removed make_with_text
--|
--| Revision 1.6.6.8  2000/01/28 20:00:13  oconnor
--| released
--|
--| Revision 1.6.6.7  2000/01/27 19:30:51  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.6.6.6  2000/01/20 18:47:55  oconnor
--| removed invariant text_not_void: text /= Void
--|
--| Revision 1.6.6.5  2000/01/18 19:38:45  oconnor
--| inherit textable
--|
--| Revision 1.6.6.4  2000/01/17 02:47:25  oconnor
--| Removed press action sequence.
--| Added and improved comments.
--| improved attribute names.
--|
--| Revision 1.6.6.3  2000/01/15 02:15:37  oconnor
--| formatting
--|
--| Revision 1.6.6.2  1999/12/17 20:03:29  rogers
--| redefined implementation to be a a more refined type. make_with_text no
--| longer takes a parent. added press actions and create_implementation.
--|
--| Revision 1.6.6.1  1999/11/24 17:30:51  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.6.2.3  1999/11/04 23:10:54  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.6.2.2  1999/11/02 17:20:12  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
