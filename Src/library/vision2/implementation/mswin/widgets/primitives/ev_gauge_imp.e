indexing
	description:
		" EiffelVision gauge, mswindows implementation."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_GAUGE_IMP

inherit
	EV_PRIMITIVE_IMP

	EV_GAUGE_I

feature -- Status setting

	step_forward is
			-- Increase the current value of one step.
		do
			set_value (maximum.min (value + step))
		end

	step_backward is
			-- Decrease the current value of one step.
		do
			set_value (minimum.max (value - step))
		end

feature -- Element change

	set_minimum (val: INTEGER) is
			-- Make `val' the new minimum.
		do
			set_range (val, maximum)
		end

	set_maximum (val: INTEGER) is
			-- Make `val' the new maximum.
		do
			set_range (minimum, val)
		end

feature -- Event - command association
	
	add_change_value_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add 'cmd' to the list of commands to be executed 
			-- when the user is about to change
			-- the value of the gauge.
		do
			add_command (Cmd_gauge, cmd, arg)
		end

feature -- Event -- removing command association

	remove_change_value_commands is
			-- Empty the list of commands to be executed
			-- when the user is about to change
			-- the value of the gauge.
		do
			remove_command (Cmd_gauge)
		end

feature -- Deferred

	exists: BOOLEAN is
		deferred
		end

	on_scroll (scroll_code, pos: INTEGER) is
		deferred
		end

end -- class EV_GAUGE_IMP

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
