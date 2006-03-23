indexing
	description: "MDI frame window containing a MDI client window."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_MDI_FRAME_WINDOW

inherit
	WEL_FRAME_WINDOW
		rename
			make_top as frame_make_top
		redefine
			call_default_window_procedure,
			class_name,
			class_background
		end

create
	make_top

feature {NONE} -- Initialization

	make_top (a_name: STRING_GENERAL; a_menu: WEL_MENU; first_child: INTEGER) is
			-- Make a MDI frame window named `a_name' using
			-- `a_menu' as the application's Window menu.
			-- `first_child' specifies the child window identifier
			-- of the first MDI child window created. Windows
			-- increments the identifier for each additional
			-- MDI child window the application creates. These
			-- identifiers are used in `on_command_control_id' when
			-- a child window is chosen from the Window menu; they
			-- should not conflict with any other command
			-- identifiers.
		require
			a_name_not_void: a_name /= Void
			a_menu_not_void: a_menu /= Void
			a_menu_exists: a_menu.exists
		do
			frame_make_top (a_name)
			create client_window.make (Current, a_menu, first_child)
		ensure
			parent_set: parent = Void
			exists: exists
			name_set: text.is_equal (a_name)
			client_window_not_void: client_window /= Void
			client_window_exists: client_window.exists
		end

feature -- Access

	client_window: WEL_MDI_CLIENT_WINDOW
			-- MDI client window which contains child windows

feature -- Status report

	has_active_window: BOOLEAN is
			-- Is a window currently active?
		require
			exists: exists
			client_window_not_void: client_window /= Void
			client_window_exists: client_window.exists
		do
			Result := client_window.has_active_window
		end

	active_window: WEL_MDI_CHILD_WINDOW is
			-- Window currently active
		require
			exists: exists
			client_window_not_void: client_window /= Void
			client_window_exists: client_window.exists
			has_active_window: has_active_window
		do
			Result := client_window.active_window
		end

feature -- Basic operations

	tile_children_horizontal is
			-- Horizontally tile the child windows.
		require
			exists: exists
		do
			client_window.tile_children_horizontal
		end

	tile_children_vertical is
			-- Vertically tile the child windows.
		require
			exists: exists
		do
			client_window.tile_children_vertical
		end

	arrange_icons is
			-- Arrange iconized child windows.
		require
			exists: exists
		do
			client_window.arrange_icons
		end

	cascade_children is
			-- Cascade the child windows.
		require
			exists: exists
		do
			client_window.cascade_children
		end

feature {NONE} -- Implementation

	call_default_window_procedure (hwnd: POINTER; msg: INTEGER; wparam, lparam: POINTER): POINTER is
		do
			if client_window /= Void and then client_window.exists then
				Result := cwin_def_frame_proc (hwnd,
					client_window.item, msg, wparam, lparam)
			else
				Result := cwin_def_frame_proc (hwnd,
					default_pointer, msg, wparam, lparam)
			end
		end

	class_name: STRING_32 is
			-- Window class name to create
		once
			Result := "WELMDIFrameWindowClass"
		end

	class_background: WEL_BRUSH is
			-- Standard application workspace color 
		once
			create Result.make_by_sys_color (Color_appworkspace + 1)
		end

feature {NONE} -- Externals

	cwin_def_frame_proc (hwnd, hwnd_mdi_client: POINTER; msg: INTEGER; wparam,
			lparam: POINTER): POINTER is
			-- SDK DefFrameProc
		external
			"C [macro <wel.h>] (HWND, HWND, UINT, WPARAM, LPARAM): LRESULT"
		alias
			"DefFrameProc"
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




end -- class WEL_MDI_FRAME_WINDOW

