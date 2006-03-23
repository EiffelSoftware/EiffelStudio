indexing
	description: "[
		Control to indicate the progress of a lengthy operation.
		Note: The common controls dll (WEL_COMMON_CONTROLS_DLL) needs to
			be loaded to use this control.
		]"
	legal: "See notice at end of class."
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

create
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
			Result := cwin_send_message_result_integer (item, Pbm_getpos,
				to_wparam (0), to_lparam (0))
		end

	minimum: INTEGER is
			-- Minimum position
		do
			Result := cwin_send_message_result_integer (item,
				Pbm_getrange, to_wparam (1), to_lparam (0))
		end

	maximum: INTEGER is
			-- Maximum position
		do
			Result := cwin_send_message_result_integer (item,
				Pbm_getrange, to_wparam (0), to_lparam (0))
		end

feature -- Element change

	step_it is
			-- Advance the current position by the step increment.
		do
			cwin_send_message (item, Pbm_stepit, to_wparam (0), to_lparam (0))
		end

	set_position (new_position: INTEGER) is
			-- Set the current position with `new_position'.
		do
			cwin_send_message (item, Pbm_setpos, to_wparam (new_position), to_lparam (0))
		end

	set_range (min, max: INTEGER) is
			-- Set the range with `minimum' and `maximum'.
		do
			cwin_send_message (item, Pbm_setrange32, to_wparam (min), to_lparam (max))
		end

	set_step (step: INTEGER) is
			-- Set the step increment with `step'.
		do
			cwin_send_message (item, Pbm_setstep, to_wparam (step), to_lparam (0))
		end

	set_delta_pos (increment: INTEGER) is
			-- Advance the current position by a specified
			-- `increment'.
		require
			exists: exists
		do
			cwin_send_message (item, Pbm_deltapos, to_wparam (increment), to_lparam (0))
		end

feature {NONE} -- Implementation

	class_name: STRING_32 is
			-- Window class name to create
		once
			Result := (create {WEL_STRING}.share_from_pointer (cwin_progress_class)).string
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class WEL_PROGRESS_BAR

