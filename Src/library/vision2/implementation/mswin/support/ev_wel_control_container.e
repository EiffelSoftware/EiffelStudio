indexing
	description:
		"A common class for the heirs of the WEL_CONTROL_WINDOW."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_WEL_CONTROL_CONTAINER_IMP

inherit
	WEL_CONTROL_WINDOW
		rename
			make as wel_make,
			parent as wel_parent,
			set_parent as wel_set_parent,
			destroy as wel_destroy
		undefine
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
			on_draw_item,
			background_brush,
			on_menu_command,
			on_accelerator_command
		redefine
			default_style,
			default_ex_style
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
			Result := Ws_child + Ws_visible + Ws_clipchildren
						+ Ws_clipsiblings
		end

	default_ex_style: INTEGER is
		do
			Result := Ws_ex_controlparent
		end

feature {NONE} -- Deferred features

	default_parent: CELL [WEL_FRAME_WINDOW] is
		deferred
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
