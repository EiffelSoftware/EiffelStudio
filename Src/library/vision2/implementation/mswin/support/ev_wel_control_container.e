indexing
	description:
		"A common class for the heirs of the WEL_CONTROL_WINDOW."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_WEL_CONTROL_CONTAINER_IMP

inherit
	EV_WIDGET_EVENTS_CONSTANTS_IMP

	WEL_CONTROL_WINDOW
		rename
			make as wel_make,
			parent as wel_parent,
			set_parent as wel_set_parent,
			destroy as wel_destroy
		undefine
			window_process_message,
			set_width,
			set_height,
			remove_command,
			on_left_button_down,
			on_right_button_down,
			on_left_button_up,
			on_right_button_up,
			on_left_button_double_click,
			on_right_button_double_click,
			on_mouse_move,
			on_key_down,
			on_key_up,
			on_set_focus,
			on_kill_focus,
			on_set_cursor,
			on_draw_item,
			background_brush,
			on_menu_command,
			on_accelerator_command,
			on_color_control
		redefine
			default_style,
			default_ex_style
-- 			on_wm_vscroll,
-- 			on_wm_hscroll
		end

feature {NONE} -- Initialization

	make is
			-- Create the box with the default options.
		do
			wel_make (default_parent.item, "")
		end

feature {NONE} -- Implementation

	top_level_window_imp: WEL_WINDOW
			-- Top level window that contains the current widget.

feature {NONE} -- WEL Implementation

	default_style: INTEGER is
		do
			Result := Ws_child + Ws_clipchildren
					+ Ws_clipsiblings + Ws_visible
		end

	default_ex_style: INTEGER is
		do
			Result := Ws_ex_controlparent
		end

-- 	on_wm_vscroll (wparam, lparam: INTEGER) is
-- 			-- Wm_vscroll message.
-- 			-- Should be implementated in EV_CONTAINER_IMP,
-- 			-- But as we can't implement a deferred feature
-- 			-- with an external, it is not possible.
-- 		local
-- 			gauge: EV_GAUGE_IMP
-- 			p: POINTER
-- 		do
-- 			p := cwin_get_wm_vscroll_hwnd (wparam, lparam)
-- 			if p /= default_pointer then
-- 				-- The message comes from a gauge
-- 				gauge ?= windows.item (p)
-- 				if gauge /= Void then
-- 					check
-- 						gauge_exists: gauge.exists
-- 					end
-- 					gauge.execute_command (Cmd_gauge, Void)
-- 				end
-- 			else
-- 				-- The message comes from a window scroll bar
-- 				on_vertical_scroll (cwin_get_wm_vscroll_code (wparam, lparam),
-- 					cwin_get_wm_vscroll_pos (wparam, lparam))
-- 			end
-- 		end
-- 
-- 	on_wm_hscroll (wparam, lparam: INTEGER) is
-- 			-- Wm_hscroll message.
-- 		local
-- 			gauge: EV_GAUGE_IMP
-- 			p: POINTER
-- 		do
-- 			p := cwin_get_wm_hscroll_hwnd (wparam, lparam)
-- 			if p /= default_pointer then
-- 				-- The message comes from a gauge
-- 				gauge ?= windows.item (p)
-- 				if gauge /= Void then
-- 					check
-- 						gauge_exists: gauge.exists
-- 					end
-- 					gauge.execute_command (Cmd_gauge, Void)
-- 				end
-- 			else
-- 				-- The message comes from a window scroll bar
-- 				on_horizontal_scroll (cwin_get_wm_hscroll_code (wparam, lparam),
-- 					cwin_get_wm_hscroll_pos (wparam, lparam))
-- 			end
-- 		end

feature {NONE} -- Deferred features

	default_parent: CELL [WEL_FRAME_WINDOW] is
		deferred
		end

feature {NONE} -- Feature that should be directly implemented by externals

	mouse_message_x (lparam: INTEGER): INTEGER is
			-- Encapsulation of the c_mouse_message_x function of
			-- WEL_WINDOW. Normaly, we should be able to have directly
			-- c_mouse_message_x deferred but it does not wotk because
			-- it would be implemented by an external.
		do
			Result := c_mouse_message_x (lparam)
		end

	mouse_message_y (lparam: INTEGER): INTEGER is
			-- Encapsulation of the c_mouse_message_x function of
			-- WEL_WINDOW. Normaly, we should be able to have directly
			-- c_mouse_message_x deferred but it does not wotk because
			-- it would be implemented by an external.
		do
			Result := c_mouse_message_y (lparam)
		end

end -- class EV_WEL_CONTROL_CONTAINER_IMP

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
