note
	description: "Eiffel Vision popup window. Mswindows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_POPUP_WINDOW_IMP

inherit
	EV_WINDOW_IMP
		redefine
			interface,
			default_style,
			default_ex_style,
			class_name,
			class_style,
			make,
			initialize,
			show_flags
		end

	EV_POPUP_WINDOW_I
		undefine
			propagate_foreground_color,
			propagate_background_color,
			lock_update,
			unlock_update,
			disconnect_from_window_manager
		redefine
			interface
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface)
			-- Create `Current' with interface `an_interface'.
		do
			base_make (an_interface)
			create accel_list.make (10)
			make_child (application_imp.silly_main_window, "")
		end

feature -- Status Setting

	disconnect_from_window_manager
			-- Show popup window disconnected from Window manager.
			-- By default when shown the window will have full capture
			-- and be setup so that clicking on an area outside the window
			-- or pressing the Escape key will hide it.
		do
			Precursor
			set_ex_style (ex_style | ws_ex_topmost)
		end

feature {NONE} -- Initialization

	initialize
			-- Initialize `Current'.
		do
			Precursor {EV_WINDOW_IMP}
			user_can_resize := False
			internal_is_border_enabled := False
		end

feature {NONE} -- Implementation

	class_name: STRING_32
			-- Class name for current type of window.
		do
			if interface.has_shadow then
				Result := "EV_POPUP_WINDOW_IMP_with_shadow"
			else
				Result := "EV_POPUP_WINDOW_IMP"
			end
		end

	class_style: INTEGER
			-- Redefine
		local
			l_win: WEL_WINDOWS_VERSION
		do
			Result := Precursor {EV_WINDOW_IMP}
			if interface.has_shadow then
				create l_win
				if l_win.is_windows_xp_compatible then
					Result := Result | cs_dropshadow
				end
			end
		end

	show_flags: INTEGER
		do
			if is_disconnected_from_window_manager then
				Result := sw_shownoactivate
			else
				Result := sw_show
			end
		end

	default_style: INTEGER
			-- Default style of `Current'.
			-- Set with the option `ws_clipchildren' to avoid flashing.
		do
			Result := ws_popup + ws_overlapped + ws_clipchildren + ws_clipsiblings
		end

	default_ex_style: INTEGER
			-- Redefine
			-- Set with `ws_ex_toolwindow' to avoid addition title in taskbar.
		do
			if is_disconnected_from_window_manager then
				Result := ws_ex_topmost
			end
			Result := Result | ws_ex_toolwindow
		end

feature  -- Implementation

	interface: EV_POPUP_WINDOW;

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




end -- class EV_WINDOW_IMP

