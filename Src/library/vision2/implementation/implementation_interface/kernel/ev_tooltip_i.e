indexing
	description:
		" EiffelVision Tooltip, implementation interface."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_TOOLTIP_I

inherit
	EV_ANY_I

feature -- Access

	delay: INTEGER is
			-- Delay im milliseconds the user has to hold the pointer over
			-- the widget before the tooltip pop up.
		require
			exists: not destroyed
		deferred
		ensure
			positive_result: Result >= 0
		end

feature -- Status report

	background_color: EV_COLOR is
			-- Color used for the background of the widget
		require
			exists: not destroyed
		deferred
		ensure
			valid_result: Result /= Void
		end

	foreground_color: EV_COLOR is
			-- Color used for the foreground of the widget
			-- usually the text.
		require
			exists: not destroyed
		deferred
		ensure
			valid_result: Result /= Void
		end

feature -- Status setting

	activate is
			-- Enable the tooltip control.
		require
			exists: not destroyed
		deferred
		end

	deactivate is
			-- Disable the tooltip control.
		require
			exists: not destroyed
		deferred
		end

	set_background_color (color: EV_COLOR) is
			-- Make `color' the new `background_color'
		require
			exists: not destroyed
			valid_color: is_valid (color)
		deferred
		ensure
			background_color_set: background_color.equal_color (color)
		end

	set_foreground_color (color: EV_COLOR) is
			-- Make `color' the new `foreground_color'
		require
			exists: not destroyed
			valid_color: is_valid (color)
		deferred
		ensure
			foreground_color_set: foreground_color.equal_color(color)
		end

feature -- Element change

	set_delay (value: INTEGER) is
			-- Make `value' the new delay.
		require
			exists: not destroyed
			positive_value: value >= 0
		deferred
		ensure
			delay_set: delay = value
		end

	add_tip (wid: EV_WIDGET; txt: STRING) is
			-- Make `txt' the tip that is displayed when the
			-- user stays on `wid'.
		require
			exists: not destroyed
			valid_widget: is_valid (wid)
			valid_text: txt /= Void
		deferred
		end

end -- class EV_TOOLTIP_I

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
