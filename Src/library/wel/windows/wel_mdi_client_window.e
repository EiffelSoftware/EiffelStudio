indexing
	description: "MDI client window to insert into a MDI frame window."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_MDI_CLIENT_WINDOW

inherit
	WEL_COMPOSITE_WINDOW
		redefine
			move,
			move_and_resize
		end

	WEL_MDI_TILE_CONSTANTS
		export
			{NONE} all
		end

creation
	make

feature {NONE} -- Initialization

	make (a_parent: WEL_COMPOSITE_WINDOW; a_menu: WEL_MENU;
			first_child: INTEGER) is
			-- Make a MDI client window named `a_name' using
			-- `a_menu' as the application's Window menu.
			-- `first_child' specifies the child window identifier
			-- of the first MDI child window created. Windows
			-- increments the identifier for each additionnal
			-- MDI child window the application creates. These
			-- identifiers are used in `on_command_control_id' when
			-- a child window is chosen from the Window menu; they
			-- should not conflict with any other command
			-- identifiers.
		require
			a_parent_not_void: a_parent /= Void
			a_parent_exists: a_parent.exists
			a_menu_not_void: a_menu /= Void
			a_menu_exists: a_menu.exists
		local
			create_struct: WEL_CLIENT_CREATE_STRUCT
		do
			create create_struct.make (a_menu, first_child)
			internal_window_make (a_parent, Void,
				default_style, 0, 0, 0, 0, 0,
				create_struct.item)
		ensure
			parent_set: parent = a_parent
			exists: exists
			name_set: text.is_equal (create {STRING}.make (0))
		end

feature -- Status report

	has_active_window: BOOLEAN is
			-- Is a window currently active?
		require
			exists: exists
		do
			Result := cwin_send_message_result (item,
				Wm_mdigetactive, 0, 0) /= 0
		end

	active_window: WEL_MDI_CHILD_WINDOW is
			-- Currently active window.
		require
			exists: exists
			has_active_window: has_active_window
		do
			Result ?= window_of_item (cwel_integer_to_pointer (
				cwin_send_message_result (item,
				Wm_mdigetactive, 0, 0)))
		ensure
			result_not_void: Result /= Void
		end

feature -- Basic operations

	move_and_resize (a_x, a_y, a_width, a_height: INTEGER;
			repaint: BOOLEAN) is
			-- Move the window to `a_x', `a_y' position and
			-- resize it with `a_width', `a_height'.
		do
			cwin_move_window (item, a_x, a_y,
				a_width, a_height, repaint)
		end

	move (a_x, a_y: INTEGER) is
			-- Move the window to `a_x', `a_y'.
		do
			cwin_set_window_pos (item, default_pointer,
				a_x, a_y, 0, 0,
				Swp_nosize + Swp_nozorder + Swp_noactivate)
		end

	arrange_icons is
			-- Arrange iconized child windows.
		require
			exists: exists
		do
			cwin_send_message (item, Wm_mdiiconarrange, 0, 0)
		end

	cascade_children is
			-- Cascade the child windows.
		require
			exists: exists
		do
			cwin_send_message (item, Wm_mdicascade, 0, 0)
		end

	tile_children_horizontal is
			-- Horizontally tile the child windows.
		require
			exists: exists
		do
			cwin_send_message (item, Wm_mditile,
				Mditile_horizontal, 0)
		end

	tile_children_vertical is
			-- Vertically tile the child windows.
		require
			exists: exists
		do
			cwin_send_message (item, Wm_mditile,
				Mditile_vertical, 0)
		end

	destroy_window (child: WEL_MDI_CHILD_WINDOW) is
			-- Destroy the child window `child'.
		require
			exists: exists
			child_not_void: child /= Void
			child_exists: child.exists
		do
			cwin_send_message (item, Wm_mdidestroy,
				cwel_pointer_to_integer (child.item), 0)
		end

feature {NONE} -- Implementation

	class_name: STRING is
			-- Window class name to create
		once
			Result := "MDICLIENT"
		end

	default_style: INTEGER is
			-- Default style used to create the window
		once
			Result := Ws_child + Ws_visible + Ws_clipchildren +
				Ws_vscroll + Ws_hscroll
		end

end -- class WEL_MDI_CLIENT_WINDOW


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

