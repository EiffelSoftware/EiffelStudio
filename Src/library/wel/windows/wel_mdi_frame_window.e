note
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

	make_top (a_name: STRING_GENERAL; a_menu: WEL_MENU; first_child: INTEGER)
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
			create internal_client_window.make (Current, a_menu, first_child)
		ensure
			parent_set: parent = Void
			exists: exists
			name_set: text.is_equal (a_name)
			client_window_exists: client_window.exists
		end

feature -- Access

	client_window: WEL_MDI_CLIENT_WINDOW
			-- MDI client window which contains child windows
		local
			l_client_window: like internal_client_window
		do
			l_client_window := internal_client_window
			check l_client_window_attached: l_client_window /= Void end
			Result := l_client_window
		end

feature -- Status report

	has_active_window: BOOLEAN
			-- Is a window currently active?
		require
			exists: exists
			client_window_exists: client_window.exists
		do
			Result := client_window.has_active_window
		ensure
			active_window_attached: client_window.active_window /= Void
		end

	active_window: detachable WEL_MDI_CHILD_WINDOW
			-- Window currently active
		require
			exists: exists
			client_window_exists: client_window.exists
			has_active_window: has_active_window
		do
			Result := client_window.active_window
		end

feature -- Basic operations

	tile_children_horizontal
			-- Horizontally tile the child windows.
		require
			exists: exists
		do
			client_window.tile_children_horizontal
		end

	tile_children_vertical
			-- Vertically tile the child windows.
		require
			exists: exists
		do
			client_window.tile_children_vertical
		end

	arrange_icons
			-- Arrange iconized child windows.
		require
			exists: exists
		do
			client_window.arrange_icons
		end

	cascade_children
			-- Cascade the child windows.
		require
			exists: exists
		do
			client_window.cascade_children
		end

feature {NONE} -- Implementation

	call_default_window_procedure (hwnd: POINTER; msg: INTEGER; wparam, lparam: POINTER): POINTER
		do
			if attached internal_client_window as l_client_window and then l_client_window.exists then
				Result := cwin_def_frame_proc (hwnd, l_client_window.item, msg, wparam, lparam)
			else
				Result := cwin_def_frame_proc (hwnd, default_pointer, msg, wparam, lparam)
			end
		end

	class_name: STRING_32
			-- Window class name to create
		once
			Result := "WELMDIFrameWindowClass"
		end

	class_background: WEL_BRUSH
			-- Standard application workspace color
		once
			create Result.make_by_sys_color (Color_appworkspace + 1)
		end

	internal_client_window: detachable like client_window
			-- Storage.

feature {NONE} -- Externals

	cwin_def_frame_proc (hwnd, hwnd_mdi_client: POINTER; msg: INTEGER; wparam,
			lparam: POINTER): POINTER
			-- SDK DefFrameProc
		external
			"C [macro <wel.h>] (HWND, HWND, UINT, WPARAM, LPARAM): LRESULT"
		alias
			"DefFrameProc"
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

end -- class WEL_MDI_FRAME_WINDOW
