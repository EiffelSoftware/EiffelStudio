note
	description: "Implementation of EV_WEL_CONTAINER"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_WEL_CONTAINER_IMP

inherit
	EV_WEL_CONTAINER_I
		redefine
			interface
		end

	EV_CELL_IMP
		rename
			replace as cell_replace,
			item as cell_item
		redefine
			interface,
			compute_minimum_width,
			compute_minimum_height,
			compute_minimum_size,
			on_size,
			ev_apply_new_size,
			process_message
		end

create
	make

feature -- Access

	implementation_window: WEL_WINDOW
			-- Window containing `item'.
		do
			Result := Current
		end

	item: detachable WEL_WINDOW
			-- `Result' is WEL_WINDOW contained in `Current'.
		do
			Result := internal_child_window
		end

feature -- Status setting

	replace (a_window: detachable WEL_WINDOW)
			-- Replace `item' with `a_window'
		do
				-- Remove any connection.
			if attached internal_child_window as l_internal_child_window then
				l_internal_child_window.set_parent (Default_parent)
				internal_child_window := Void
			end
			if a_window /= Void then
				connect_window (a_window)
			end
		end

feature {NONE} -- Implementation

	internal_child_window: detachable WEL_WINDOW
		-- WEL_WINDOW contained in `Current'.

	connect_window (a_window: WEL_WINDOW)
			-- Parent `a_window' to `Current' and
			-- force resize of new child.
		do
				-- Ensure that `a_window' is actually parented in `Current'.
			a_window.set_parent (Current)
				-- Keep a reference to the window.
			internal_child_window := a_window
				-- Size `item' to fit the size of `Current'.
			a_window.resize (width, height)
		end

	compute_minimum_width, compute_minimum_height,
	compute_minimum_size (a_is_size_forced: BOOLEAN)
			-- Recompute the minimum dimensions of `Current'.
		do
			-- There is nothing to be done here. The minimum size
			-- of `Current' is set using `set_minimum_size', and
			-- as the child is a WEL_WINDOW, there is no minimum size
			-- for the child to take into account here.
		end

	on_size (size_type, a_width, a_height: INTEGER)
			-- Called when `Current' is resized.
		local
			t: like resize_actions_internal
		do
			if size_type /= ({WEL_WINDOW_CONSTANTS}.Size_minimized) then
				if attached internal_child_window as l_internal_child_window then
					l_internal_child_window.resize (a_width, a_height)
				end
			end
				-- We cannot call the precursor so we have to implement
				-- here.
			t := resize_actions_internal
			if t /= Void then
				t.call ([screen_x, screen_y, a_width, a_height])
			end
		end

	ev_apply_new_size (a_x_position, a_y_position, a_width, a_height: INTEGER; repaint: BOOLEAN)
			-- Apply new size to `Current'.
		do
			if attached internal_child_window as l_internal_child_window then
				l_internal_child_window.resize (client_width, client_height)
			end
		end

	process_message (hwnd: POINTER; msg: INTEGER; wparam, lparam: POINTER): POINTER
			-- Process messages sent by Windows to `Current'.
		local
			called: BOOLEAN
		do
			inspect msg
			when Wm_paint then
				on_wm_paint (wparam)
			when Wm_command then
				on_wm_command (wparam, lparam)
			when Wm_syscommand then
				on_sys_command (wparam.to_integer_32, cwin_lo_word (lparam), cwin_hi_word (lparam))
			when Wm_menuselect then
				on_wm_menu_select (wparam, lparam)
			when Wm_vscroll then
				on_wm_vscroll (wparam, lparam)
			when Wm_hscroll then
				on_wm_hscroll (wparam, lparam)
			when Wm_drawitem then
				on_wm_draw_item (wparam, lparam)
			when Wm_getminmaxinfo then
				on_wm_get_min_max_info (lparam)
			when Wm_windowposchanged then
				on_wm_window_pos_changed (lparam)
			when Wm_windowposchanging then
				on_wm_window_pos_changing (lparam)
			when Wm_paletteischanging then
				on_palette_is_changing (window_of_item (wparam))
			when Wm_palettechanged then
				on_palette_changed (window_of_item (wparam))
			when Wm_querynewpalette then
				on_query_new_palette
			when Wm_settingchange then
				on_wm_setting_change
			when Wm_syscolorchange then
				on_wm_syscolor_change
			when Wm_close then
				on_wm_close
			else
				called := True
				-- Call the `process_message' routine of the
				-- parent class.
				Result := window_process_message (hwnd, msg, wparam, lparam)
			end
				-- Now call `wel_message_actions'. Note that certain
				-- processing has already been performed on these messages.
				-- The processing is necessary for the Vision2 implementation.
			wel_message_actions.call ([hwnd, msg, wparam, lparam])
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_WEL_CONTAINER note option: stable attribute end;
		-- Interface of `Current'.

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
