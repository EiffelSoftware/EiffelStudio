indexing
	description:
		" A WEL tool-bar with some properties used by%
		% the EiffelVision Tool Bar."
	status: "See notica at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_INTERNAL_TOOL_BAR_IMP

inherit
	WEL_TOOL_BAR
		redefine
			make,
			default_style,
			default_process_message,
			on_left_button_down,
			on_right_button_down,
			on_left_button_up,
			on_right_button_up
		end

	WEL_COLOR_CONSTANTS
		export
			{NONE} all
		end

	EV_ITEM_EVENTS_CONSTANTS_IMP

creation
	make

feature {NONE} -- Initialization

	make (a_parent: EV_TOOL_BAR_IMP; an_id: INTEGER) is
			-- Create a toolbar with `a_parent' as parent and
			-- `an_id' as id.
		do
			{WEL_TOOL_BAR} Precursor (a_parent, an_id)
			ev_children := a_parent.ev_children
		end

feature -- Access

	ev_children: HASH_TABLE [EV_TOOL_BAR_BUTTON_IMP, INTEGER]
			-- The buttons of the tool-bar.

feature -- Status report

	button_width: INTEGER is
			-- Current width of the buttons
		do
			Result := cwin_lo_word (cwin_send_message_result (item,
						Tb_getbuttonsize, 0, 0))
		end

	separator_width: INTEGER is
			-- Current width of a separator
		do
			Result := 8
		end

	button_height: INTEGER is
			-- Current width of the buttons
		do
			Result := cwin_hi_word (cwin_send_message_result (item,
						Tb_getbuttonsize, 0, 0))
		end

feature -- Basic operation

	internal_index (command_id: INTEGER): INTEGER is
			-- Retrieve the current index of the button with
			-- `command_id' as id.
		do
			Result := cwin_send_message_result (item, Tb_commandtoindex, command_id, 0)
		end

	internal_propagate_event (event_id, x_pos, y_pos: INTEGER) is
			-- Propagate the `event_id' to the good child.
		local
			index: INTEGER
			point: WEL_POINT
			button: WEL_TOOL_BAR_BUTTON
		do
			create point.make (x_pos, y_pos)
--			index := cwin_send_message_result (item, Tb_hittest, 0, point.to_integer)
			index := cwin_send_message_result (item, 1093, 0, point.to_integer)
			create button.make
			if index >= 0 then
				cwin_send_message (item, Tb_getbutton, index, button.to_integer)
				(ev_children @ button.command_id).execute_command (event_id, Void)
			end
		end

feature {NONE} -- Implementation

	default_style: INTEGER is
			-- A new style to avoid a line on the top.
		do
			Result := {WEL_TOOL_BAR} Precursor + Tbstyle_flat
					--	+ Tbstyle_list
		end

	default_process_message (msg, wparam, lparam: INTEGER) is
			-- Process `msg' which has not been processed by
			-- `process_message'.
		do
			if msg = Wm_ncpaint then
				on_wm_ncpaint (wparam)
			end
		end

	on_wm_ncpaint (wparam: INTEGER) is
			-- Wm_paint message.
			-- A WEL_DC and WEL_PAINT_STRUCT are created and
			-- passed to the `on_paint' routine.
			-- To be more efficient when the windows does not
			-- need to paint something, this routine can be
			-- redefined to do nothing (eg. The object creation are
			-- useless).
		require
			exists: exists
		local
			dc: WEL_WINDOW_DC
			color: WEL_COLOR_REF
			pen: WEL_PEN
			int: INTEGER
		do
			!! color.make_system (Color_menu)
			!! pen.make_solid (2, color)
			!! dc.make (Current)
			dc.get
				dc.select_pen (pen)
				int := width
				int := height
				dc.line (-1, 1, width, 1)
			dc.release
			disable_default_processing
		end

	on_left_button_down (keys, x_pos, y_pos: INTEGER) is
			-- Wm_lbuttondown message
			-- See class WEL_MK_CONSTANTS for `keys' value
		do
			internal_propagate_event (Cmd_item_button_one_press,
				x_pos, y_pos)
		end

	on_right_button_down (keys, x_pos, y_pos: INTEGER) is
			-- Wm_rbuttondown message
			-- See class WEL_MK_CONSTANTS for `keys' value
		do
			internal_propagate_event (Cmd_item_button_three_press,
				x_pos, y_pos)
		end

	on_left_button_up (keys, x_pos, y_pos: INTEGER) is
			-- Wm_lbuttonup message
			-- See class WEL_MK_CONSTANTS for `keys' value
		do
			internal_propagate_event (Cmd_item_button_one_release,
				x_pos, y_pos)
		end

	on_right_button_up (keys, x_pos, y_pos: INTEGER) is
			-- Wm_rbuttonup message
			-- See class WEL_MK_CONSTANTS for `keys' value
		do
			internal_propagate_event (Cmd_item_button_three_release,
				x_pos, y_pos)
		end

end -- class EV_INTERNAL_TOOL_BAR_IMP

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
