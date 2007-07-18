indexing
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
			initialize
		end

	EV_POPUP_WINDOW_I
		undefine
			propagate_foreground_color,
			propagate_background_color,
			lock_update,
			unlock_update
		redefine
			interface
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create `Current' with interface `an_interface'.
		do
			base_make (an_interface)
			create accel_list.make (10)
			make_child (application_imp.silly_main_window, "")
		end

feature {NONE} -- Initialization

	initialize is
			-- Initialize `Current'.
		do
			Precursor {EV_WINDOW_IMP}
			user_can_resize := False
			internal_is_border_enabled := False
		end

feature {NONE} -- Implementation

	class_name: STRING_32 is
			-- Class name for current type of window.
		do
			if interface.has_shadow then
				Result := "EV_POPUP_WINDOW_IMP_with_shadow"
			else
				Result := "EV_POPUP_WINDOW_IMP"
			end
		end

	class_style: INTEGER is
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

	default_style: INTEGER is
			-- Default style of `Current'.
			-- Set with the option `Ws_clipchildren' to avoid flashing.
		do
			Result := Ws_popup + Ws_overlapped + Ws_clipchildren + Ws_clipsiblings
		end

	default_ex_style: INTEGER is
			-- Redefine
			-- Set with `ws_ex_toolwindow' to avoid addition title in taskbar.
		do
			Result := Ws_ex_toolwindow
		end

feature  -- Implementation

	interface: EV_POPUP_WINDOW;

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




end -- class EV_WINDOW_IMP

