indexing
	description:
		"Eiffel Vision scrollbar. Mswindows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_SCROLL_BAR_IMP

inherit
	EV_SCROLL_BAR_I
		redefine
			interface
		end

	EV_GAUGE_IMP
		undefine
			on_scroll
		redefine
			interface,
			wel_background_color,
			set_leap,
			set_range
		end

	WEL_SCROLL_BAR
		rename
			parent as wel_parent,
			set_parent as wel_set_parent,
			shown as is_displayed,
			destroy as wel_destroy,
			position as value,
			set_position as wel_set_value,
			background_color as wel_background_color,
			foreground_color as wel_foreground_color,
			line as step,
			page as leap,
			set_line as wel_set_step,
			set_page as wel_set_leap,
			width as wel_width,
			height as wel_height,
			enabled as is_sensitive,
			item as wel_item,
			set_range as wel_set_range,
			move as wel_move,
			resize as wel_resize,
			move_and_resize as wel_move_and_resize,
			x as x_position,
			y as y_position,
			has_capture as wel_has_capture
		undefine
			set_width,
			set_height,
			on_left_button_down,
			on_middle_button_down,
			on_right_button_down,
			on_left_button_up,
			on_middle_button_up,
			on_right_button_up,
			on_left_button_double_click,
			on_middle_button_double_click,
			on_right_button_double_click,
			on_mouse_move,
			on_mouse_wheel,
			on_set_focus,
			on_desactivate,
			on_kill_focus,
			on_key_down,
			on_key_up,
			on_char,
			on_set_cursor,
			show,
			hide,
			on_size,
			x_position,
			y_position,
			wel_foreground_color,
			wel_background_color,
			on_sys_key_down,
			on_sys_key_up,
			default_process_message,
			on_getdlgcode
		redefine
			default_style,
			wel_set_range
		end

feature {NONE} -- Implementation

	default_style: INTEGER is
			-- Default style used to create the control
		do
			Result := Ws_visible + Ws_childwindow +
				Ws_clipchildren + Ws_clipsiblings
		end

	wel_background_color: WEL_COLOR_REF is
		do
			Result := background_color_imp
			if Result = Void then
				create Result.make_system (Color_scrollbar)
			end
		end

feature {EV_ANY_I} -- Implementation

	set_leap (a_leap: INTEGER) is
			-- Assign `a_leap' to `leap'.
		do
				--| Adjust the range so that the value_range.upper can actually
				--| be achieved. When scroll bars are proportional in WEL, only
				--| the maximum value - leap can be acheived. Julian
			wel_set_range (value_range.lower, value_range.upper + a_leap - 1)
			Precursor (a_leap)
		end
		
	wel_set_range (a_minimum, a_maximum: INTEGER) is
			-- Set `minimum' and `maximum' with
			-- `a_minimum' and `a_maximum'
		local
			must_adjust: BOOLEAN
			adjusted_value: INTEGER
			l_value: INTEGER
		do
				--| This has been redefined to fic the following bug:
				--| run the vision2 Gauges sample, without redefining this feature,
				--| and before doing anythign else, click on the right hand arrow of
				--| the horizontal scroll bar.
				--| This redefinition ensures that if the range of `Current' changes, the
				--| `value' remains valid.
			l_value := value
			if l_value < a_minimum then
				must_adjust := True
				adjusted_value := a_minimum
			elseif l_value > a_maximum then
				must_adjust := True
				adjusted_value := a_maximum
			end
			
			scroll_info_struct.set_mask (Sif_range)
			scroll_info_struct.set_minimum (a_minimum)
			scroll_info_struct.set_maximum (a_maximum)
			cwin_set_scroll_info (wel_item, Sb_ctl, scroll_info_struct.item, True)
			
				-- If previous `value' is now out of range then
				-- assign `adjusted_value' to `value'.
			if must_adjust then
				scroll_info_struct.set_mask (Sif_pos)
				scroll_info_struct.set_position (adjusted_value)
				cwin_set_scroll_info (wel_item, Sb_ctl, scroll_info_struct.item, True)
			end
		end

	set_range is
		do
				--| Adjust the range so that the value_range.upper can actually
				--| be achieved. When scroll bars are proportional in WEL, only
				--| the maximum value - leap can be acheived. Julian
			wel_set_range (value_range.lower, value_range.upper + leap - 1)
		end

	interface: EV_SCROLL_BAR;

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




end -- class EV_RANGE_IMP

