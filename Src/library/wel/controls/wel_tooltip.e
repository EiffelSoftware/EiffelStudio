indexing
	description: "Small pop-up window that displays a single line of %
		%descriptive text giving the purpose of tools."
	note: "The common controls dll (WEL_COMMON_CONTROLS_DLL) needs to %
		%be loaded to use this control."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_TOOLTIP

inherit
	WEL_CONTROL
		redefine
			default_ex_style
		end

	WEL_TTM_CONSTANTS
		export
			{NONE} all
		end

	WEL_TTS_CONSTANTS
		export
			{NONE} all
		end

	WEL_TTDT_CONSTANTS
		export
			{NONE} all
		end

creation
	make,
	make_by_id,
	make_by_pointer

feature {NONE} -- Initialization

	make (a_parent: WEL_WINDOW; an_id: INTEGER) is
			-- Create a tooltip control with `a_parent' as parent
			-- and `an_id' as id.
		require
			a_parent_not_void: a_parent /= Void
		do
			internal_window_make (a_parent, Void, default_style,
				Cw_usedefault, Cw_usedefault, Cw_usedefault,
				Cw_usedefault, id, default_pointer)
			id := an_id
		ensure
			exists: exists
			parent_set: parent = a_parent
			id_set: id = an_id
		end

feature -- Access

	i_th_tool_info (index: INTEGER): WEL_TOOL_INFO is
			-- Tool info structure at the zero-based `index'
		require
			exists: exists
			index_large_enough: index >= 0
			index_small_enough: index < count
		do
			create Result.make
			cwin_send_message (item, Ttm_enumtools, index,
				Result.to_integer)
		ensure
			result_not_void: Result /= Void
		end

feature -- Status report

	count: INTEGER is
			-- Count of tools
		require
			exists: exists
		do
			Result := cwin_send_message_result (item,
				Ttm_gettoolcount, 0, 0)
		ensure
			positive_result: Result >= 0
		end

	autopop_delay_time: INTEGER is
			-- Length of time (in milliseconds) before the
			-- tooltip window is hidden if the cursor remains
			-- stationary in the tool's bounding rectangle after
			-- the tooltip window has appeared.
		require
			exists: exists
		do
			Result := cwin_send_message_result (item, Ttm_getdelaytime,
				Ttdt_autopop, 0)
		ensure
			positive_result: result >= 0
		end

	initial_delay_time: INTEGER is
			-- Length of time (in milliseconds) that the
			-- cursor must remain stationary within the bounding
			-- rectangle of a tool before the tooltip window is
			-- displayed.
		require
			exists: exists
		do
			Result := cwin_send_message_result (item, Ttm_getdelaytime,
				Ttdt_initial, 0)
		ensure
			positive_result: result >= 0
		end

	reshow_delay_time: INTEGER is
			-- Length of the delay (in milliseconds) before
			-- subsequent tooltip windows are displayed when the
			-- cursor is moved from one tool to another.
		require
			exists: exists
		do
			Result := cwin_send_message_result (item, Ttm_getdelaytime,
				Ttdt_reshow, 0)
		ensure
			positive_result: result >= 0
		end

	background_color: WEL_COLOR_REF is
			-- Background color used for the tooltip.
		require
			exists: exists
		do
			create Result.make_by_color (cwin_send_message_result (item, Ttm_gettipbkcolor, 0, 0))
		ensure
			result_not_void: result /= Void
		end

	text_color: WEL_COLOR_REF is
			-- Color used for the text of the tooltip.
		require
			exists: exists
		do
			create Result.make_by_color (cwin_send_message_result (item, Ttm_gettiptextcolor, 0, 0))
		ensure
			result_not_void: result /= Void
		end

feature -- Status setting

	activate is
			-- Activate the tooltip control.
		require
			exists: exists
		do
			cwin_send_message (item, Ttm_activate, 1, 0)
		end

	deactivate is
			-- Deactivate the tooltip control.
		require
			exists: exists
		do
			cwin_send_message (item, Ttm_activate, 0, 0)
		end

	set_automatic_delay_time (delay: INTEGER) is
			-- Set automatically the initial, reshow, and
			-- autopopup durations based on the value of
			-- `delay' (in milliseconds).
		require
			exists: exists
			positive_delay: delay >= 0
		do
			cwin_send_message (item, Ttm_setdelaytime,
				Ttdt_automatic, cwin_make_long (delay, 0))
		end

	set_autopop_delay_time (delay: INTEGER) is
			-- Set the length of time (in milliseconds) before the
			-- tooltip window is hidden if the cursor remains
			-- stationary in the tool's bounding rectangle after
			-- the tooltip window has appeared.
		require
			exists: exists
			positive_delay: delay >= 0
		do
			cwin_send_message (item, Ttm_setdelaytime,
				Ttdt_autopop, cwin_make_long (delay, 0))
		end

	set_initial_delay_time (delay: INTEGER) is
			-- Set the length of time (in milliseconds) that the
			-- cursor must remain stationary within the bounding
			-- rectangle of a tool before the tooltip window is
			-- displayed.
		require
			exists: exists
			positive_delay: delay >= 0
		do
			cwin_send_message (item, Ttm_setdelaytime,
				Ttdt_initial, cwin_make_long (delay, 0))
		end

	set_reshow_delay_time (delay: INTEGER) is
			-- Set the length of the delay (in milliseconds) before
			-- subsequent tooltip windows are displayed when the
			-- cursor is moved from one tool to another.
		require
			exists: exists
			positive_delay: delay >= 0
		do
			cwin_send_message (item, Ttm_setdelaytime,
				Ttdt_reshow, cwin_make_long (delay, 0))
		end

	set_background_color (a_color: WEL_COLOR_REF) is
			-- Background color used for the tooltip.
		require
			exists: exists
			color_not_void: a_color /= Void
		do
			cwin_send_message (item, Ttm_settipbkcolor, a_color.item, 0)
		ensure
			color_set: background_color.red = a_color.red and then
					background_color.green = a_color.green and then
					background_color.blue = a_color.blue
		end

	set_text_color (a_color: WEL_COLOR_REF) is
			-- Color used for the text of the tooltip.
		require
			exists: exists
			color_not_void: a_color /= Void
		do
			cwin_send_message (item, Ttm_settiptextcolor, a_color.item, 0)
		ensure
			color_set: text_color.red = a_color.red and then
					text_color.green = a_color.green and then
					text_color.blue = a_color.blue
		end

feature -- Basic operations

	add_tool (tool_info: WEL_TOOL_INFO) is
			-- Add a new `tool_info' in the tooltip control.
		require
			exists: exists
			tool_info_not_void: tool_info /= Void
		do
			cwin_send_message (item, Ttm_addtool, 0,
				tool_info.to_integer)
		ensure
			count_increased: count = old count + 1
		end

	delete_tool (index: INTEGER) is
			-- Delete the tool at the zero-based `index'.
		require
			exists: exists
			index_large_enough: index >= 0
			index_small_enough: index < count
		do
			cwin_send_message (item, Ttm_deltool, 0,
				i_th_tool_info (index).to_integer)
		ensure
			count_decreased: count = old count - 1
		end

feature {NONE} -- Implementation

	class_name: STRING is
			-- Window class name to create
		once
			create Result.make_from_c (cwin_tooltips_class)
		end

	default_style: INTEGER is
			-- Default style used to create the control.
		once
			Result := Tts_alwaystip
		end

	default_ex_style: INTEGER is
			-- Default extended style used to create the control.
		once
			Result := Ws_ex_topmost
		end

feature {NONE} -- Externals

	cwin_tooltips_class: POINTER is
		external
			"C [macro <cctrl.h>] : EIF_POINTER"
		alias
			"TOOLTIPS_CLASS"
		end

end -- class WEL_TOOLTIP

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
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

