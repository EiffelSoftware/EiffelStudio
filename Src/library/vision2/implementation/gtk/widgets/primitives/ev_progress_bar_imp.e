indexing 
	description: "EiffelVision Progress bar."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_PROGRESS_BAR_IMP

inherit
	EV_PROGRESS_BAR_I

	EV_GAUGE_IMP

	EV_PRIMITIVE_IMP

feature -- Implementation

	make is
			-- Create the progress bar.
		do
			widget := gtk_progress_bar_new
			gtk_object_ref (widget)
		end

	make_with_range (min: INTEGER; max: INTEGER) is
			-- Create a gauge with `min' as minimum, `max' as maximum
			-- and `par' as parent.
		do
			-- Parameters are:
			-- value, lower, upper, step_increment, page_increment.
			widget := c_gtk_progress_bar_new_with_adjustment (min, min, max, 1, 5)

			adjustment_widget := c_gtk_progress_bar_adjustment (widget)
			gtk_object_ref (widget)
		end

feature -- Access

	value: INTEGER is
			-- Current value of the gauge
		do
		end

	step: INTEGER is
			-- Step of the scrolling
			-- ie : the user clicks on an arrow
		do
		end

	minimum: INTEGER is
			-- Minimum value
		do
		end

	maximum: INTEGER is
			-- Maximum value
		do
		end

feature -- Status report

	is_segmented: BOOLEAN is
			-- Is the mode in segmented mode?
		local
			mode: INTEGER
		do
			mode := c_gtk_progress_bar_style (widget)

			if (mode = 0) then
				Result := False
			else
				Result := True
			end
		end

feature -- Status setting

	set_percentage (val: INTEGER) is
			-- Make `value' the new percentage filled by the
			-- progress bar.
		do
			gtk_progress_bar_update (widget, val/100)
		end

	set_segmented (flag: BOOLEAN) is
			-- Set the progress bar mode in
			-- segmented if `flag' is true, in
			-- continuous otherwise.
		do
			if flag then
				gtk_progress_bar_set_bar_style (widget, GTK_PROGRESS_DISCRETE)
			else
				gtk_progress_bar_set_bar_style (widget, GTK_PROGRESS_CONTINUOUS)
			end
		end

feature -- Element change

	set_value (val: INTEGER) is
			-- Make `val' the new current value.
		do
			check
				not_yet_implemented: False
			end
		end

	set_step (val: INTEGER) is
			-- Make `val' the new step.
		do
			check
				not_yet_implemented: False
			end
		end

	set_minimum (val: INTEGER) is
			-- Make `val' the new minimum.
		do
			check
				not_yet_implemented: False
			end
		end

	set_maximum (val: INTEGER) is
			-- Make `val' the new maximum.
		do
			check
				not_yet_implemented: False
			end
		end

end -- class EV_PROGRESS_BAR_IMP

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
