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

feature -- Element change

	step_it is
			-- Advance the current position by the step increment.
		do
			cwin_send_message (item, Pbm_stepit, 0, 0)
		end

	set_position (new_position: INTEGER) is
			-- Set the current position with `new_position'.
		require
			exists: exists
			positive_position: new_position >= 0
		do
			cwin_send_message (item, Pbm_setpos, new_position, 0)
		end

	set_range (minimum, maximum: INTEGER) is
			-- Set the range with `minimum' and `maximum'.
		do
			cwin_send_message (item, Pbm_setrange, 0,
				cwin_make_long (minimum, maximum))
		end

	set_step (step: INTEGER) is
			-- Set the step increment with `step'.
		require
			exists: exists
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
			!! Result.make (0)
			Result.from_c (cwin_progress_class)
		end

	default_style: INTEGER is
			-- Default style used to create the control
		once
			Result := Ws_visible + Ws_child + Ws_group + Ws_tabstop
		end

feature {NONE} -- Externals

	cwin_progress_class: POINTER is
		external
			"C [macro <cctrl.h>]"
		alias
			"PROGRESS_CLASS"
		end

end -- class WEL_PROGRESS_BAR

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
