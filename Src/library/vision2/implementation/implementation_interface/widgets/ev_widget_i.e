indexing
	description:
		"Eiffel Vision widget, implementation interface.%N%
		%See bridge pattern notes in ev_any.e"
	status: "See notice at end of class"
	keywords: "widget, component, control"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_WIDGET_I 

inherit
	EV_PICK_AND_DROPABLE_I
		redefine
			interface
		end

feature -- Access

	parent: EV_CONTAINER is
			-- Container widget that contains `Current'.
			-- (Void if `Current' is not in a container)
		deferred
		end

	pointer_position: EV_COORDINATES is
            -- Position of the screen pointer relative to `Current'.
        deferred
        end
		
	pointer_style: EV_CURSOR is
			-- Cursor displayed when screen pointer is over current widget.
		deferred
		end

	foreground_color: EV_COLOR is
			-- Color of foreground features like text.
		deferred
		end

	background_color: EV_COLOR is
			-- Color displayed behind foreground features.
		deferred
		end

	tooltip: STRING is
			-- Text displayed when user moves mouse over widget.
		deferred
		end

feature -- Status Report

	is_sensitive: BOOLEAN is
			-- Does `Current' respond to user input events.
		deferred
		end

	is_show_requested: BOOLEAN is
			-- Will `Current' be displayed when its parent is?
			-- See also `is_displayed'.
		deferred
		end

	is_displayed: BOOLEAN is
			-- Is `Current' visible on the screen?
			-- False if `Current' is entirely obscured by another window.
		deferred
		end

	has_focus: BOOLEAN is
			-- Does widget have the keyboard focus?
		deferred
		end

feature -- Status setting

	hide is
			-- Request that `Current' not be displayed when its parent is.
		deferred
		ensure
			not_is_show_requested: not is_show_requested
		end
	
	show is
			-- Request that `Current' be displayed when its parent is.
		deferred
		ensure
			is_show_requested: is_show_requested
		end

	set_focus is
			-- Grab keyboard focus.
		deferred
		ensure
			has_focus: has_focus
		end

	enable_sensitive is
			-- Enable sensitivity to user input events.
		deferred
		ensure
			is_sensitive: is_sensitive
		end

	disable_sensitive is
			-- Disable sensitivity to user input events.
		deferred
		ensure
			not_is_sensitive: not is_sensitive
		end

	set_default_colors is
			-- Initialize the colors of the widget
		local
			default_colors: EV_DEFAULT_COLORS
		do
			create default_colors
			set_background_color (default_colors.default_background_color)
			set_foreground_color (default_colors.default_foreground_color)
		end
			--| Descendants of EV_WIDGET_I may dedefine this to use different
			--| colors so there is no postcondition.

feature -- Element change

	set_pointer_style (a_cursor: like pointer_style) is
			-- Assign `a_cursor' to `pointer_style'.
		require
			a_cursor_not_void: a_cursor /= Void
		deferred
		ensure
			pointer_style_assigned: pointer_style.is_equal (a_cursor)
		end

	set_background_color (a_color: EV_COLOR) is
			-- Assign `a_color' to `background_color'.
		require
			a_color_not_void: a_color /= Void
		deferred
		ensure
			background_color_assigned: background_color.is_equal (a_color)
		end

	set_foreground_color (a_color: EV_COLOR) is
			-- Assign `a_color' to `foreground_color'
		require
			a_color_not_void: a_color /= Void
		deferred
		ensure
			foreground_color_assigned: foreground_color.is_equal (a_color)
		end

	set_minimum_width (a_minimum_width: INTEGER) is
			-- Set the minimum horizontal size to `a_minimum_width' in pixels.
		require
			a_minimum_width_positive: a_minimum_width > 0
		deferred
		ensure
			minimum_width_assigned: minimum_width = a_minimum_width
		end

	set_minimum_height (a_minimum_height: INTEGER) is
			-- Set the minimum vertical size to `a_minimum_height' in pixels.
		require
			a_minimum_height_positive: a_minimum_height > 0
		deferred
		ensure
			minimum_height_assigned: minimum_height = a_minimum_height
		end

	set_minimum_size (a_minimum_width, a_minimum_height: INTEGER) is
			-- Set the minimum horizontal size to `a_minimum_width' in pixels.
			-- Set the minimum vertical size to `a_minimum_height' in pixels.
		require
			a_minimum_width_positive: a_minimum_width > 0
			a_minimum_height_positive: a_minimum_height > 0
		deferred
		ensure
			minimum_width_assigned: minimum_width = a_minimum_width
			minimum_height_assigned: minimum_height = a_minimum_height
		end

	set_tooltip (a_text: STRING) is
			-- Set `tooltip' to `a_text'.
	        deferred
		end

	remove_tooltip is
			-- Set `tooltip' to `Void'.
	        deferred
		end

feature -- Measurement
	
	x_position: INTEGER is
			-- Horizontal offset relative to parent `x_position' in pixels.
		deferred
		end
	
	y_position: INTEGER is
			-- Vertical offset relative to parent `y_position' in pixels.
		deferred
		end

	screen_x: INTEGER is
			-- Horizontal offset relative to screen.
		local
			wind: EV_WINDOW_IMP
		do
			wind ?= Current
			if wind /= Void then
				Result := x_position
			elseif parent /= Void then
				Result := x_position + parent.screen_x
			end
		end

	screen_y: INTEGER is
			-- Vertical offset relative to screen.
		local
			wind: EV_WINDOW_IMP
		do
			wind ?= Current
			if wind /= Void then
				Result := y_position
			elseif parent /= Void then
				Result := y_position + parent.screen_y
			end
		end

	width: INTEGER is
			-- Horizontal size in pixels.
		deferred
		end

	height: INTEGER is
			-- Vertical size in pixels.
		deferred
		end
	
	minimum_width: INTEGER is
			-- Minimum horizontal size in pixels.
		deferred
		end

	minimum_height: INTEGER is
			-- Minimum vertical size in pixels.
		deferred
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_WIDGET
		-- Provides a common user interface to platform dependent functionality
		-- implemented by `Current'.
		-- (See bridge pattern notes in ev_any.e)

feature -- Obsolete

	dimensions_set (new_width, new_height: INTEGER): BOOLEAN is
		-- Check if the dimensions of the widget are set to 
		-- the values given or the minimum values possible 
		-- for that widget.
		obsolete "don't use it"
		deferred
		end		

	minimum_dimensions_set (new_width, new_height: INTEGER): BOOLEAN is
		-- Check if the dimensions of the widget are set to 
		-- the values given or the minimum values possible 
		-- for that widget.
		-- When the widget is not shown, the result is 0
		obsolete "don't use it"
		deferred
		end		

	minimum_width_set (value: INTEGER): BOOLEAN is
			-- Send -1 not to test the height
		obsolete "don't use it"
		do
			Result := minimum_dimensions_set (value, -1)
		end

	minimum_height_set (value: INTEGER): BOOLEAN is
			-- Send -1 not to test width.
		obsolete "don't use it"
		do
			Result := minimum_dimensions_set (-1, value)
		end

	position_set (new_x, new_y: INTEGER): BOOLEAN is
		-- Check if the dimensions of the widget are set to 
		-- the values given or the minimum values possible 
		-- for that widget.
		-- When the widget is not shown, the result is -1
		obsolete "don't use it"
		deferred
		end

	x_set (value: INTEGER): BOOLEAN is
		obsolete "don't use it"
		do
			Result := position_set (value, -1)
		end

	y_set (value: INTEGER): BOOLEAN is
		obsolete "don't use it"
		do
			Result := position_set (-1, value)
		end

	has_parent: BOOLEAN is
			-- True if the widget has a parent, False otherwise
		obsolete "use parent /= Void"
		do
			Result := parent.implementation /= void
		end

	parent_set (par: EV_CONTAINER): BOOLEAN is
		obsolete "don't use it"
		local
			wid_imp: EV_CONTAINER_I
		do
		--	if parent_imp /= Void then
		--		wid_imp := par.implementation
		--		Result := wid_imp = parent_imp
		--	else
		--		Result := par = Void
		--	end
			check false end
		end


	--|FIXME I believe this is no longer required.
	--|Will be removed completely when reviewing. Julian
	--managed: BOOLEAN is
	--		-- Is the current widget managed ?
	--	obsolete "needs more work"
	--	local
	--		wid: EV_WIDGET
	--	do
		--	wid ?= interface
		--	if wid = Void then
		--		Result := False
		--	else
		--		Result := wid.managed
		--	end
	--	end

	application: CELL [EV_APPLICATION_IMP] is
			-- The current application.
			--| Needed for the accelerators.
		obsolete
			"see EV_ENVIRONMENT"
		once
			--| FIXME Why Void?
			create Result.put (Void)
		end

invariant
	pointer_position_not_void: is_useable implies pointer_position /= Void
	background_color_not_void: is_useable implies background_color /= void
	foreground_color_not_void: is_useable implies foreground_color /= void

	--| FIXME IEK The minimum dimension size should be greater than 0
	--| This does not hold for containers though
	minimum_width_positive_or_zero: is_useable implies minimum_width >= 0
	minimum_height_positive_or_zero: is_useable implies minimum_height >= 0


	--|FIXME These two assertions have been commented out due to problems with
	--|The windows implementation. The problem is due to the fact that until the widgets
	--| have been re-sized then the width, which is returned by wel will by 0. However,
	--| the minimum width of the widget will be greater than 0.
	--| This violates these pre-conditions and needs to be fixed.
	--|width_not_less_than_minimum_width:
	--|	 is_useable implies width >= minimum_width
	--|height_not_less_than_minimum_height:
	--|	 is_useable implies height >= minimum_height

	is_displayed_implies_show_requested:
		is_useable and is_displayed implies is_show_requested


	--| FIXME IEK Not applicable for items that inherit from widget
	--| only on the implementation side such as T.B. Button
	--parent_contains_current:
		--is_useable and parent /= Void implies parent.has (interface)

end -- class EV_WIDGET_I

--!----------------------------------------------------------------
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
--!----------------------------------------------------------------


--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.58  2000/02/14 11:40:36  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.57.6.33  2000/02/04 04:05:05  oconnor
--| released
--|
--| Revision 1.57.6.32  2000/02/02 00:50:26  king
--| Commented parent_contains_current invariant as it does not hold for items that are widgets only on the implementation side such as tool bar buttons
--|
--| Revision 1.57.6.31  2000/01/29 00:59:03  brendel
--| Removed set_default_minimum_size.
--|
--| Revision 1.57.6.30  2000/01/28 21:18:25  brendel
--| Added `tooltip', `set_tooltip', `remove_tooltip'.
--|
--| Revision 1.57.6.29  2000/01/27 19:29:58  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.57.6.28  2000/01/26 19:17:01  rogers
--| width_not_less_than_minimum_width and height_not_less_than_minimum_height have been commented out with a FIXME and a detailed description of why.
--|
--| Revision 1.57.6.27  2000/01/25 17:12:47  king
--| Added absolute coord functions, can be optimized with platform dependancy
--|
--| Revision 1.57.6.26  2000/01/22 02:28:30  oconnor
--| changed >= 1 to > 0
--|
--| Revision 1.57.6.25  2000/01/21 19:13:34  king
--| Changed min hgt/wid invariants back to zero as they didn't hold for an empty container
--|
--| Revision 1.57.6.24  2000/01/20 23:50:41  king
--| Changed minimum size assertions to be >= 1 instead of 0
--|
--| Revision 1.57.6.23  2000/01/19 00:22:51  rogers
--| Removed managed. This is now only required for windows and is implemented in EV_WIDGET_IMP.
--|
--| Revision 1.57.6.22  1999/12/17 18:16:10  rogers
--| Removed set_parent.
--|
--| Revision 1.57.6.21  1999/12/16 09:20:51  oconnor
--| add is_useable to invariant
--|
--| Revision 1.57.6.20  1999/12/14 18:57:25  oconnor
--| rename POINT->COORDINATES for pointer_position
--|
--| Revision 1.57.6.19  1999/12/14 18:07:45  oconnor
--| implemented feature pointer_position
--|
--| Revision 1.57.6.18  1999/12/14 16:52:56  oconnor
--| renamed EV_PND_SOURCE -> EV_PICK_AND_DROPABLE
--|
--| Revision 1.57.6.17  1999/12/07 18:29:58  oconnor
--| added obsolete tags
--|
--| Revision 1.57.6.16  1999/12/07 18:22:45  oconnor
--| tweaked comments
--|
--| Revision 1.57.6.15  1999/12/06 17:27:16  oconnor
--| fixed invariants to use is_useable implies
--|
--| Revision 1.57.6.14  1999/12/05 00:38:57  oconnor
--| removed postcondition on set_default_colors
--|
--| Revision 1.57.6.13  1999/12/04 18:43:24  oconnor
--| fixed void call in invariant
--|
--| Revision 1.57.6.12  1999/12/03 04:57:36  oconnor
--| added obsolete to application feature
--|
--| Revision 1.57.6.11  1999/12/03 04:11:20  brendel
--| Added is_initialized implies to invariants of bg & fg color.
--|
--| Revision 1.57.6.10  1999/12/03 00:52:43  brendel
--| Commented out a managed function.
--|
--| Revision 1.57.6.9  1999/12/02 22:55:31  oconnor
--| reformatted indexing clause (added keywords)
--| added invariants
--| removed postconditions that are part of invariant
--|
--| Revision 1.57.6.8  1999/12/02 20:11:35  brendel
--| Removed `not_managed' from preconditions.
--|
--| Revision 1.57.6.7  1999/12/02 19:52:41  brendel
--| Changed comments and pre/postconsitions to the ones in EV_WIDGET.
--| Moved features to Obsolete clause.
--|
--| Revision 1.57.6.6  1999/12/01 22:06:52  oconnor
--| x|y is now x|y_position
--|
--| Revision 1.57.6.5  1999/12/01 21:51:23  brendel
--| Added set_pointer_style for compatibility with ev_widget.
--|
--| Revision 1.57.6.4  1999/12/01 20:49:46  brendel
--| Fixed some mistakes.
--|
--| Revision 1.57.6.3  1999/12/01 20:23:23  oconnor
--| x is now x_position
--|
--| Revision 1.57.6.2  1999/11/30 22:44:32  oconnor
--| redefine interface to be of type  EV_WIDGET
--|
--| Revision 1.57.6.1  1999/11/24 17:30:07  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.57.2.4  1999/11/09 16:53:16  oconnor
--| reworking dead object cleanup
--|
--| Revision 1.57.2.3  1999/11/04 23:10:36  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.57.2.2  1999/11/02 17:20:06  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
