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
			old_make,
			make,
			show_flags,
			is_top_level,
			on_wm_mouseactivate
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
	make, initialize_with_shadow

feature -- Initialization

	old_make (an_interface: attached like interface)
			-- Create `Current' with interface `an_interface'.
		do
			assign_interface (an_interface)
		end

	make
			-- Initialize `Current'.
		do
			create accel_list.make (10)
			Precursor
			user_can_resize := False
			internal_is_border_enabled := False
		end

	is_top_level: BOOLEAN
			-- Does `Current' need to be made as a top-level window?
		do
			Result := False
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

	on_wm_mouseactivate (wparam, lparam: POINTER)
		do
			if not is_disconnected_from_window_manager then
				Precursor (wparam, lparam)
			else
				set_message_return_value (to_lresult ({WEL_MA_CONSTANTS}.ma_noactivate))
				disable_default_processing
			end
		end

feature {NONE} -- Implementation

	class_name: STRING_32
			-- Class name for current type of window.
		do
			create Result.make_from_string_general (generator)
			if has_shadow then
				Result.append_string_general ("_with_shadow")
			end
		end

	class_style: INTEGER
			-- Redefine
		local
			l_win: WEL_WINDOWS_VERSION
		do
			Result := Precursor {EV_WINDOW_IMP}
			if has_shadow then
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

	interface: detachable EV_POPUP_WINDOW note option: stable attribute end;

note
	copyright:	"Copyright (c) 1984-2017, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class EV_WINDOW_IMP









