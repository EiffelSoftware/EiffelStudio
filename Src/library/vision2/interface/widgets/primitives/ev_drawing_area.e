indexing
	description:
		"Widget onto which graphical primatives may be drawn.%N%
		%Primitives are drawn directly onto the screen without buffering.%
		%(When buffering is required use EV_PIXMAP.)"
	status: "See notice at end of class"
	keywords: "drawable, expose, primitive, figure, draw, paint, image"
	date: "$Date$"
	revision: "$Revision$"

class 
	EV_DRAWING_AREA

inherit
	EV_DRAWABLE
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
			is_in_default_state
		end

	EV_DRAWING_AREA_ACTION_SEQUENCES
		redefine
			implementation
		end

create
	default_create

feature -- Basic operations

	redraw is
			-- Call `expose_actions' for `Current' when next idle.
		require
			not_destroyed: not is_destroyed
		do
			implementation.redraw
		end

	clear_and_redraw is
			-- Clear the window.
			-- Call `expose_actions' for `Current' when next idle.
		require
			not_destroyed: not is_destroyed
		do
			implementation.clear_and_redraw
		end

	redraw_rectangle (a_x, a_y, a_width, a_height: INTEGER) is
			-- Call `expose_actions' for rectangle described with upper-left
			-- corner on (`a_x', `a_y') with size `a_width' and `a_height' when next idle.
		require
			not_destroyed: not is_destroyed
		do
			implementation.redraw_rectangle (a_x, a_y, a_width, a_height)
		end

	clear_and_redraw_rectangle (a_x, a_y, a_width, a_height: INTEGER) is
			-- Clear rectangle described with upper-left corner on (`a_x', `a_y')
			-- with size `a_width' and `a_height'.
			-- Call `expose_actions' for rectangle when next idle.
		require
			not_destroyed: not is_destroyed
		do
			implementation.clear_and_redraw_rectangle (a_x, a_y, a_width, a_height)
		end

	flush is
			-- Execute any delayed calls to `expose_actions' without waiting
			-- for next idle. Delayed calls to `expose_actions' happen as a
			-- result of calling on of `redraw', `clear_and_redraw',
			-- `redraw_rectangle' or `clear_and_redraw_rectngle'.
			-- Call this feature to make the effects of one or more previous
			-- calls to these features immediately visible.
		require
			not_destroyed: not is_destroyed
		do
			implementation.flush
		end

feature {EV_ANY} -- Contract support

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state.
		do
			Result := Precursor {EV_PRIMITIVE}
				and then Precursor {EV_DRAWABLE}
		end

feature {EV_ANY_I} -- Implementation

	implementation: EV_DRAWING_AREA_I
		-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_DRAWING_AREA_IMP} implementation.make (Current)
		end

end -- class EV_DRAWING_AREA

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

