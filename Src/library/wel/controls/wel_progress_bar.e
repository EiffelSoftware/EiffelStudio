indexing
	description: "Control to indicate the progress of a lengthy operation."
	note: "The common controls dll (WEL_COMMON_CONTROLS_DLL) needs to %
		%be loaded to use this control."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_PROGRESS_BAR

inherit
	WEL_BAR

	WEL_CONTROL

	WEL_PBM_CONSTANTS
		export
			{NONE} all
		end

creation
	make,
	make_by_id

feature {NONE} -- Initialization

	make (a_parent: WEL_WINDOW; a_x, a_y, a_width, a_height, an_id: INTEGER) is
			-- Make a progress bar.
		require
			a_parent_not_void: a_parent /= Void
		do
			internal_window_make (a_parent, Void,
				default_style, a_x, a_y, a_width, a_height,
				an_id, default_pointer)
			id := an_id
		ensure
			exists: exists
			parent_set: parent = a_parent
			id_set: id = an_id
		end

feature -- Access

	position: INTEGER is
			-- Current position
		do
			Result := cwin_send_message_result (item, Pbm_getpos,
				0, 0)
		end

	minimum: INTEGER is
			-- Minimum position
		do
			Result := cwin_send_message_result (item,
				Pbm_getrange, 1, 0)
		end

	maximum: INTEGER is
			-- Maximum position
		do
			Result := cwin_send_message_result (item,
				Pbm_getrange, 0, 0)
		end

feature -- Element change

	step_it is
			-- Advance the current position by the step increment.
		do
			cwin_send_message (item, Pbm_stepit, 0, 0)
		end

	set_position (new_position: INTEGER) is
			-- Set the current position with `new_position'.
		do
			cwin_send_message (item, Pbm_setpos, new_position, 0)
		end

	set_range (min, max: INTEGER) is
			-- Set the range with `minimum' and `maximum'.
		do
			cwin_send_message (item, Pbm_setrange, 0, cwin_make_long (min, max))
		end

	set_step (step: INTEGER) is
			-- Set the step increment with `step'.
		do
			cwin_send_message (item, Pbm_setstep, step, 0)
		end

	set_delta_pos (increment: INTEGER) is
			-- Advance the current position by a specified
			-- `increment'.
		require
			exists: exists
		do
			cwin_send_message (item, Pbm_deltapos, increment, 0)
		end

feature {NONE} -- Implementation

	class_name: STRING is
			-- Window class name to create
		once
			create Result.make_from_c (cwin_progress_class)
		end

	default_style: INTEGER is
			-- Default style used to create the control
		once
			Result := Ws_visible + Ws_child + Ws_group + Ws_tabstop
		end

feature {NONE} -- Externals

	cwin_progress_class: POINTER is
		external
			"C [macro <cctrl.h>] : EIF_POINTER"
		alias
			"PROGRESS_CLASS"
		end

end -- class WEL_PROGRESS_BAR


--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
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

