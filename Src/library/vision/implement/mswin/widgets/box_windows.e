indexing
	description: "This class is ancestor of RADIO_BOX_WINDOWS and CHECK_BOX_WINDOWS"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	BOX_WINDOWS

inherit
	MANAGER_WINDOWS
		redefine
			set_x,
			set_y,
			hide,
			show,
			destroy
		end

	WEL_GROUP_BOX
		rename
			make as wel_make,
			show as wel_show,
			hide as wel_hide,
			destroy as wel_destroy,
			x as wel_x,
			y as wel_y,
			width as wel_width,
			height as wel_height,
			set_x as wel_set_x,
			set_y as wel_set_y,
			set_width as wel_set_width,
			set_height as wel_set_height,
			shown as wel_shown,
			parent as wel_parent,
			text as wel_text,
			text_length as wel_text_length,
			set_text as wel_set_text,
			move as wel_move,
			set_focus as wel_set_focus,
			set_capture as wel_set_capture,
			release_capture as wel_release_capture,
			item as wel_item,
			font as wel_font
		undefine
			on_right_button_up, on_left_button_down, on_left_button_up,
			on_right_button_down, on_mouse_move, on_destroy, on_set_cursor,
			on_key_up, on_key_down
		redefine
			default_style
		end

feature -- Access

	destroy (wid_list: LINKED_LIST [WIDGET]) is
			-- Destroy screen widget implementation and all
			-- screen widget implementations of its children
			-- contained in wid_list
		local
			ww: WIDGET_WINDOWS
		do
			destroy_children
			if exists then
				wel_destroy
			end
			from
				wid_list.start
			until
				wid_list.after
			loop
				ww ?= wid_list.item.implementation
				actions_manager_list.deregister (ww)
				wid_list.forth
			end
		end

feature -- Status setting

	set_x (new_x: INTEGER) is
			-- Set `x' to `new_x'.
		do
			private_attributes.set_x (new_x)
			if exists then
				wel_set_x (new_x)
				if number_of_toggles > 0 then
					reposition_toggles
				end
			end
		end

	set_y (new_y: INTEGER) is
			-- Set `y' to `new_y'.
		do
			private_attributes.set_y (new_y)
			if exists then
				wel_set_y (new_y)
				if number_of_toggles > 0 then
					reposition_toggles
				end
			end
		end

	hide is
			-- Hide the box and the toggles
		do
			if exists then
				wel_hide
                                hide_toggle_children
			end
                        shown := false
		end

	show is
			-- Hide the box and the toggles
		do
			if exists then
				wel_show
                                show_toggle_children
			end
                        shown := true
		end
			
feature {TOGGLE_B_WINDOWS} -- Element change

	add_toggle (a_toggle: TOGGLE_B_WINDOWS) is
			-- Add a toggle
		do
			toggle_list.extend (a_toggle)
		end

	remove_toggle (a_toggle: TOGGLE_B_WINDOWS) is
			-- Remove a toggle from the list
		require
			toggles_present: number_of_toggles > 0
			destroyed: not a_toggle.exists
		do
			from
				toggle_list.start
			variant
				toggle_list.count - toggle_list.index
			until
				toggle_list.after
			loop
				if toggle_list.item = a_toggle then
					toggle_list.remove
				else
					toggle_list.forth
				end
			end
		ensure
			removed: toggle_list.count = old toggle_list.count - 1
		end

feature {TOGGLE_B_WINDOWS} -- Status setting

	scan_toggles is
			-- Set the width/height according to the toggles
		require
			toggles_present: number_of_toggles > 0
		local
			c: CURSOR
			largest_width: INTEGER
		do
			largest_width := wel_width
			c := toggle_list.cursor
			from
				toggle_list.start
			variant
				toggle_list.count - toggle_list.index
			until
				toggle_list.after
			loop
				toggle_list.item.set_x_y (horizontal_spacing,
					((toggle_list.index - 1) * child_height) + vertical_spacing)
				if toggle_list.item.realized then
					toggle_list.item.resize_for_toggle
					largest_width := largest_width.max (toggle_list.item.width +
						2 * horizontal_spacing)
				end
				toggle_list.forth
			end;
			toggle_list.go_to (c)
			set_size (largest_width.max (Minimum_width), (toggle_list.count * (child_height)) +
				vertical_spacing + text_height_box // 2)
		end

	reposition_toggles is
			-- Set the width/height according to the toggles
		require
			toggles_present: number_of_toggles > 0
		local
			c: CURSOR
			largest_width: INTEGER
		do
			largest_width := wel_width
			c := toggle_list.cursor
			from
				toggle_list.start
			variant
				toggle_list.count - toggle_list.index
			until
				toggle_list.after
			loop
				toggle_list.item.set_x_y (horizontal_spacing,
					((toggle_list.index - 1) * child_height) + vertical_spacing)
				toggle_list.forth
			end;
			toggle_list.go_to (c)
		end

feature {TOGGLE_B_WINDOWS} -- Status report

	number_of_toggles: INTEGER is
			-- Number of toggles in the box
		do
			Result := toggle_list.count
		end

feature {NONE} -- Implementation

	Minimum_width: INTEGER is 25
			-- Minimum width of the box

	toggle_list: LINKED_LIST [TOGGLE_B_WINDOWS]
			-- List of the toggles in the box

	text_height_box: INTEGER is
			-- Text height of the box title
		local
			a_log_font: WEL_LOG_FONT
		do
			a_log_font := wel_font.log_font
			Result := a_log_font.height
		end

	vertical_spacing: INTEGER is
			-- Spacing between toggles
		do
			Result := child_height // 2
		end

	horizontal_spacing: INTEGER is
			-- Horizontal spacing between toggles and box
		do
			Result := (child_height // 7).max (2)
		end

	child_height: INTEGER is
			-- Height of a toggle
		require
			toggles_present: number_of_toggles > 0
		do
			Result := toggle_list.first.toggle_height
		end

	destroy_children is
			-- Destroy the toggles.
		do
			from
				toggle_list.start
			until
				toggle_list.empty
			loop
				toggle_list.item.unrealize
				toggle_list.start
			end
		end

        show_toggle_children is
			-- Show the toggles.
		do
			from
				toggle_list.start
			variant
				toggle_list.count - toggle_list.index
			until
				toggle_list.after
			loop
				if toggle_list.item.exists then
					toggle_list.item.wel_show
				end
				toggle_list.forth
			end
		end
	
        hide_toggle_children is
			-- Hide the toggles.
		do
			from
				toggle_list.start
			variant
				toggle_list.count - toggle_list.index
			until
				toggle_list.after
			loop
				if toggle_list.item.exists then
					toggle_list.item.wel_hide
				end
				toggle_list.forth
			end
		end

	default_style: INTEGER is
			-- Default style used to create the control
		once
			Result := Ws_visible + Ws_child + Ws_group +
				Ws_tabstop + Bs_groupbox
		end

end -- class BOX_WINDOWS

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| 
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------


