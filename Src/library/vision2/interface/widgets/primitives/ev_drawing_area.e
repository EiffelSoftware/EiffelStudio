indexing
	description:
		"EiffelVision drawing area. Widgets that can be drawn on."
	status: "See notice at end of class"
	keywords: "drawable, expose, repaint, primitives, figures"
	date: "$Date$"
	revision: "$Revision$"

class 
	EV_DRAWING_AREA

inherit
	EV_DRAWABLE
		undefine
			create_action_sequences
		redefine
			--set_background_color,
			--set_foreground_color,
			--background_color,
			--foreground_color,
			implementation,
			is_in_default_state
		end

	EV_PRIMITIVE
		undefine
			set_background_color,
			background_color,
			set_foreground_color,
			foreground_color
		redefine
			implementation,
			create_action_sequences,
			is_in_default_state
		end

create
	default_create

feature -- Basic operations

	redraw is
			-- Clear the window and call `expose_actions'.
		do
			implementation.clear
			expose_actions.call ([0, 0, width, height])
		end

feature -- Events

	expose_actions: EV_GEOMETRY_ACTION_SEQUENCE
			-- Actions to be performed on expose.

feature {EV_DRAWING_AREA_IMP} -- Implementation

	create_implementation is
			-- Create implementation of drawing area.
		do
			create {EV_DRAWING_AREA_IMP} implementation.make (Current)
		end

	create_action_sequences is
			-- Create action sequences.
		do
			{EV_PRIMITIVE} Precursor
			create expose_actions
		end

feature {EV_DRAWING_AREA_I} -- Implementation

	implementation: EV_DRAWING_AREA_I
			-- Responsible for interaction with the underlying native graphics
			-- toolkit.

feature {EV_ANY} -- Contract support

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state.
		do
			Result := {EV_PRIMITIVE} Precursor and then
				{EV_DRAWABLE} Precursor
		end

invariant
	expose_actions_not_void: expose_actions /= Void

end -- class EV_DRAWING_AREA

--!-----------------------------------------------------------------------------
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
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.11  2000/02/14 11:40:52  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.10.6.28  2000/01/28 20:00:19  oconnor
--| released
--|
--| Revision 1.10.6.27  2000/01/27 19:30:54  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.10.6.26  2000/01/21 22:32:02  brendel
--| Rearranged inheritance of color features.
--|
--| Revision 1.10.6.25  2000/01/21 21:34:18  oconnor
--| formatting, comments
--|
--| Revision 1.10.6.24  2000/01/20 23:02:31  brendel
--| Added function redraw.
--|
--| Revision 1.10.6.23  2000/01/19 17:44:36  brendel
--| Added undefine for color features from EV_WIDGET.
--|
--| Revision 1.10.6.22  2000/01/18 18:11:30  brendel
--| Changed `is_in_default_state'.
--|
--| Revision 1.10.6.21  2000/01/18 17:43:19  brendel
--| Added redefine of is_in_default_state.
--|
--| Revision 1.10.6.20  2000/01/18 17:31:06  king
--| Added `is_in_default_state'.
--|
--| Revision 1.10.6.19  2000/01/18 01:32:13  king
--| Removed conditional checking `is_drawable' in color setting routines.
--|
--| Revision 1.10.6.18  2000/01/17 22:28:09  brendel
--| Formatting.
--|
--| Revision 1.10.6.17  2000/01/17 01:20:23  oconnor
--| renamed EV_EXPOSE_ACTION_SEQUENCE -> EV_GEOMETRY_ACTION_SEQUENCE
--|
--| Revision 1.10.6.16  2000/01/17 00:44:05  oconnor
--| changed calls to is_drawable to implementation.is_drawable
--|
--| Revision 1.10.6.15  2000/01/15 02:12:36  oconnor
--| formatting
--|
--| Revision 1.10.6.14  2000/01/11 01:01:04  king
--| Spelling.
--|
--| Revision 1.10.6.13  1999/12/17 19:43:19  rogers
--| Altered passed parameter types.
--|
--| Revision 1.10.6.12  1999/12/16 03:50:59  oconnor
--| mutiple inheritance of creation_action_sequences tweaked
--|
--| Revision 1.10.6.11  1999/12/09 23:19:00  brendel
--| Fixed bug with infinite loop in color setting.
--|
--| Revision 1.10.6.10  1999/12/08 17:07:51  brendel
--| Added redefine of color setting routines. Every routine now sets both
--| background/fill color or foreground/line color.
--| This is the final version of EV_DRAWING_AREA.
--|
--| Revision 1.10.6.9  1999/12/07 18:09:36  brendel
--| Removed rename of color related features.
--|
--| Revision 1.10.6.8  1999/12/04 22:46:55  brendel
--| Removed commented lines. Removed create_action_sequences redefinition
--| from drawable since it is now deferred in ev_any.
--|
--| Revision 1.10.6.7  1999/12/03 04:10:32  brendel
--| Did some stuff with colors. Will be changed back soon.
--|
--| Revision 1.10.6.6  1999/12/03 00:33:21  brendel
--| Added expose_event action sequence.
--|
--| Revision 1.10.6.5  1999/12/01 21:48:29  brendel
--| Removed action sequences from here since they are defined in widget.
--|
--| Revision 1.10.6.4  1999/12/01 01:02:34  brendel
--| Rearranged externals to GEL or EV_C_GTK. Modified some features that relied
--| on specific things like return value BOOLEAN instead of INTEGER.
--|
--| Revision 1.10.6.3  1999/11/29 17:55:02  brendel
--| Ignore previous log message. Changed creation order according to new
--| creation sequence standard.
--|
--| Revision 1.10.6.2  1999/11/24 22:48:07  brendel
--| Just managed to compile figure cluster example.
--|
--| Revision 1.10.6.1  1999/11/24 17:30:53  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.10.2.3  1999/11/04 23:10:55  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.10.2.2  1999/11/02 17:20:13  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
