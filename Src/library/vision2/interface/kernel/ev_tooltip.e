indexing
	description:
		" EiffelVision Tooltip. This class handles the tooltips%
		% (short messages displayed by the system when the user%
		% stays on a point without moving) inside a window."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TOOLTIP

inherit
	EV_ANY
		redefine
			default_create,
			implementation
		end

create
	default_create,
	make

feature {NONE} -- Initialization

	default_create, make is
			-- Create the tooltip.
		do
			create {EV_TOOLTIP_IMP} implementation.make
		end

feature -- Access

	delay: INTEGER is
			-- Delay im milliseconds the user has to hold the pointer over
			-- the widget before the tooltip pop up.
		require
			exists: not destroyed
		do
			Result := implementation.delay
		ensure
			positive_result: Result >= 0
		end

feature -- Status report

	background_color: EV_COLOR is
			-- Color used for the background of the widget
		require
			exists: not destroyed
		do
			Result := implementation.background_color
		ensure
			valid_result: Result /= Void
		end

	foreground_color: EV_COLOR is
			-- Color used for the foreground of the widget
			-- usually the text.
		require
			exists: not destroyed
		do
			Result := implementation.foreground_color
		ensure
			valid_result: Result /= Void
		end

feature -- Status setting

	enable is
			-- Enable the tooltip control.
		require
			exists: not destroyed
		do
			implementation.activate
		end

	disable is
			-- Disable the tooltip control.
		require
			exists: not destroyed
		do
			implementation.deactivate
		end

	set_background_color (color: EV_COLOR) is
			-- Make `color' the new `background_color'
		require
			exists: not destroyed
			valid_color: is_valid (color)
		do
			implementation.set_background_color (color)
		ensure
			background_color_set: background_color.equal_color (color)
		end

	set_foreground_color (color: EV_COLOR) is
			-- Make `color' the new `foreground_color'
		require
			exists: not destroyed
			valid_color: is_valid (color)
		do
			implementation.set_foreground_color (color)
		ensure
			foreground_color_set: foreground_color.equal_color (color)
		end

feature -- Element change

	set_delay (value: INTEGER) is
			-- Make `value' the new delay.
		require
			exists: not destroyed
			positive_value: value >= 0
		do
			implementation.set_delay (value)
		ensure
			delay_set: delay = value
		end

	add_tip (wid: EV_WIDGET; txt: STRING) is
			-- Make `txt' the tip that is displayed when the
			-- user stays on `wid'.
			-- If the widget already has a tip in this
			-- tooltip, it replaces it.
		require
			exists: not destroyed
			valid_widget: is_valid (wid)
			valid_text: txt /= Void
		do
			implementation.add_tip (wid, txt)
		end

feature -- Implementation

	implementation: EV_TOOLTIP_I
			-- Pltform dependant access.

end -- class EV_TOOLTIP

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
