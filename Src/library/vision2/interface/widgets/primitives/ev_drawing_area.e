indexing
	description:
		"Widget onto which graphical primatives may be drawn.%N%
		%Primatives are drawn directly onto the screen without buffering.%
		%(When buffering is required use EV_PIXMAP.)"
	status: "See notice at end of class"
	keywords: "drawable, expose, primitive, figure, draw, paint, image"
	date: "$Date$"
	revision: "$Revision$"

class 
	EV_DRAWING_AREA

inherit
	EV_DRAWABLE
		undefine
			create_action_sequences
		redefine
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
			is_in_default_state,
			make_for_test
		end

create
	default_create,
	make_for_test

feature -- Basic operations

	redraw is
			-- Call `expose_actions' for whole window when next idle.
		do
			implementation.redraw
		end

	clear_and_redraw is
			-- Clear the window.
			-- Call `expose_actions' for whole window when next idle.
		do
			implementation.clear_and_redraw
		end

	redraw_rectangle (x1, y1, x2, y2: INTEGER) is
			-- Call `expose_actions' for rectangle (`x1',`y1') - (`x2', `y2')
			-- when next idle.
		do
			implementation.redraw_rectangle (x1, y1, x2, y2)
		end

	clear_and_redraw_rectangle (x1, y1, x2, y2: INTEGER) is
			-- Clear the rectangle (`x1',`y1') - (`x2', `y2').
			-- Call `expose_actions' for rectangle when next idle.
		do
			implementation.clear_and_redraw_rectangle (x1, y1, x2, y2)
		end

	flush is
			-- Execute any delayed calls to `expose_actions' without waiting
			-- for next idle. Delayed calls to `expose_actions' happen as a
			-- result of calling on of `redraw', `clear_and_redraw',
			-- `redraw_rectangle' or `clear_and_redraw_rectngle'.
			-- Call this feature to make the effects of one or more previous
			-- calls to these features imediately visible.
		do
			implementation.flush
		end

feature -- Events

	expose_actions: EV_GEOMETRY_ACTION_SEQUENCE
			-- Actions to be performed when part of the drawing area needs to be
			-- redrawn.

feature {EV_ANY} -- Contract support

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state.
		do
			Result := {EV_PRIMITIVE} Precursor
				and then {EV_DRAWABLE} Precursor
		end

	make_for_test is
		local
			p: EV_PIXMAP
			t: EV_TIMEOUT
		do
			default_create
			create p
			create t
			p.set_with_named_file ("test_pixmap")
			t.actions.extend (~draw_pixmap (10, 10, p))
			t.set_interval (1000)
			set_minimum_size (100, 100)
		end

feature {EV_DRAWING_AREA_I} -- Implementation

	implementation: EV_DRAWING_AREA_I
		-- Responsible for interaction with the native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_DRAWING_AREA_IMP} implementation.make (Current)
		end

	create_action_sequences is
			-- See `{EV_ANY}.create_action_sequences'.
		do
			{EV_PRIMITIVE} Precursor
			create expose_actions
		end

invariant
	expose_actions_not_void: expose_actions /= Void

end -- class EV_DRAWING_AREA

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
--| Revision 1.20  2000/04/19 18:44:50  brendel
--| Added make_for_test.
--|
--| Revision 1.19  2000/03/21 19:10:39  oconnor
--| comments, formatting
--|
--| Revision 1.18  2000/03/21 02:35:12  oconnor
--| indexing
--|
--| Revision 1.17  2000/03/21 02:09:23  oconnor
--| comments and formatting
--|
--| Revision 1.16  2000/03/03 03:59:03  pichery
--| added feature `flush'
--|
--| Revision 1.15  2000/03/01 20:28:53  king
--| Corrected export clauses for implementation and create_imp/act_seq
--|
--| Revision 1.14  2000/03/01 03:30:06  oconnor
--| added make_for_test
--|
--| Revision 1.13  2000/02/22 18:39:51  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.12  2000/02/16 18:08:05  pichery
--| added new features: redraw_rectangle, clear_and_redraw,
--| clear_and_redraw_rectangle
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
