note
	description: "MDI client window to insert into a MDI frame window."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_MDI_CLIENT_WINDOW

inherit
	WEL_COMPOSITE_WINDOW
		redefine
			move_and_resize
		end

	WEL_MDI_TILE_CONSTANTS
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_parent: WEL_COMPOSITE_WINDOW; a_menu: WEL_MENU;
			first_child: INTEGER)
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
			name_set: text.is_empty
		end

feature -- Status report

	has_active_window: BOOLEAN
			-- Is a window currently active?
		require
			exists: exists
		do
			Result := active_window /= Void
		end

	active_window: detachable WEL_MDI_CHILD_WINDOW
			-- Currently active window.
		require
			exists: exists
			has_active_window: has_active_window
		do
			Result ?= window_of_item ({WEL_API}.send_message_result (item, Wm_mdigetactive,
				to_wparam (0), to_lparam (0)))
		end

feature -- Basic operations

	move_and_resize (a_x, a_y, a_width, a_height: INTEGER; repaint: BOOLEAN)
			-- Move the window to `a_x', `a_y' position and
			-- resize it with `a_width', `a_height'.
		do
			move_and_resize_internal (a_x, a_y, a_width, a_height, repaint, 0)
		end

	arrange_icons
			-- Arrange iconized child windows.
		require
			exists: exists
		do
			{WEL_API}.send_message (item, Wm_mdiiconarrange, to_wparam (0), to_lparam (0))
		end

	cascade_children
			-- Cascade the child windows.
		require
			exists: exists
		do
			{WEL_API}.send_message (item, Wm_mdicascade, to_wparam (0), to_lparam (0))
		end

	tile_children_horizontal
			-- Horizontally tile the child windows.
		require
			exists: exists
		do
			{WEL_API}.send_message (item, Wm_mditile, to_wparam (Mditile_horizontal), to_lparam (0))
		end

	tile_children_vertical
			-- Vertically tile the child windows.
		require
			exists: exists
		do
			{WEL_API}.send_message (item, Wm_mditile, to_wparam (Mditile_vertical), to_lparam (0))
		end

	destroy_window (child: WEL_MDI_CHILD_WINDOW)
			-- Destroy the child window `child'.
		require
			exists: exists
			child_not_void: child /= Void
			child_exists: child.exists
		do
			{WEL_API}.send_message (item, Wm_mdidestroy, child.item, to_lparam (0))
		end

feature {NONE} -- Implementation

	class_name: STRING_32
			-- Window class name to create
		once
			Result := "MDICLIENT"
		end

	default_style: INTEGER
			-- Default style used to create the window
		once
			Result := Ws_child + Ws_visible + Ws_clipchildren +
				Ws_vscroll + Ws_hscroll
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class WEL_MDI_CLIENT_WINDOW

