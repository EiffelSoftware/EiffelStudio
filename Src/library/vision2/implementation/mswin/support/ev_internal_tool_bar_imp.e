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
			default_style,
			default_process_message
		end

	WEL_COLOR_CONSTANTS
		export
			{NONE} all
		end

creation
	make

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
