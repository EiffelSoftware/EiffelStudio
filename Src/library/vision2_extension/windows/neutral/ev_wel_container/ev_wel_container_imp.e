indexing
	description: "Implementation of EV_WEL_CONTAINER"
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

	implementation_window: WEL_WINDOW is
			-- Window containing `item'.
		do
			Result := Current
		end
		
	item: WEL_WINDOW is
			-- `Result' is WEL_WINDOW contained in `Current'.
		do
			Result ?= internal_child_window
		end
		
	item_minimum_height: INTEGER is
			-- Minimum height of `item'.
		do
			Result := internal_item_minimum_height
			--Result := implementation.item_minimum_height
		end
		
	item_minimum_width: INTEGER is
			-- Minimum width of `item'.
		do
			Result := internal_item_minimum_width
		end
		
feature -- Status setting

	set_item_minimum_height (a_height: INTEGER) is
			-- Set minimum height of `item' to `a_height.
		local
			h_cd: BOOLEAN
		do
			h_cd := internal_item_minimum_height /= a_height
			if h_cd then
				internal_item_minimum_height := a_height
				notify_change (Nc_minheight, Current)
			end
		end
		
	set_item_minimum_width (a_width: INTEGER) is
			-- Set minimum height of `item' to `a_height.
		local
			w_cd: BOOLEAN
		do
			w_cd := internal_item_minimum_width /= a_width
			if w_cd then
				internal_item_minimum_width := a_width
				notify_change (Nc_minwidth, Current)			
			end
		end
		
	set_item_minimum_size (a_width, a_height: INTEGER) is
			-- Set minimum size of `item' to `a_width' and `a_height.
		local
			w_cd, h_cd: BOOLEAN
		do
			w_cd := internal_item_minimum_width /= a_width
			h_cd := internal_item_minimum_height /= a_height
			internal_item_minimum_height := a_height
			internal_item_minimum_width := a_width
			if w_cd and h_cd then
				notify_change (Nc_minsize, Current)
			elseif w_cd then
				notify_change (Nc_minwidth, Current)
			elseif h_cd then
				notify_change (Nc_minheight, Current)
			end
		end
		
	replace (a_window: WEL_WINDOW) is
			-- Replace `item' with `a_window'
		do
			if item /= Void then
				internal_child_window.set_parent (Default_parent)
				internal_child_window := Void
			end	
			if a_window /= Void then
				connect_window (a_window)	
			end
		end
		
feature {NONE} -- Implementation

	internal_child_window: WEL_WINDOW
		-- WEL_WINDOW contained in `Current'.
		
	internal_item_minimum_width: INTEGER
		-- Minimum width of `item'.
		
	internal_item_minimum_height: INTEGER
		-- Minimum height of `item'.


	connect_window (a_window: WEL_WINDOW) is
			-- Parent `a_window' to `Current' and
			-- force resize of new child.
		do
				-- Ensure that `a_window' is actually parented in `Current'.
			a_window.set_parent (Current)
				-- Keep a reference to the window.
			internal_child_window := a_window
				-- Size `item' to fit the size of `Current'.
			internal_child_window.resize (width, height)
		end
		
	compute_minimum_width is
			-- Recompute the minimum_width of `Current'.
		do
			ev_set_minimum_width (internal_item_minimum_width)
		end

	compute_minimum_height is
			-- Recompute the minimum_width of `Current'.
		do
			ev_set_minimum_height (internal_item_minimum_height)
		end

	compute_minimum_size is
			-- Recompute both the minimum_width the
			-- minimum_height of `Current'.
		do
			ev_set_minimum_size (internal_item_minimum_width, internal_item_minimum_height)
		end
		
	on_size (size_type, a_width, a_height: INTEGER) is
			-- Called when `Current' is resized.
		local
			t: like resize_actions_internal
		do
			if size_type /= (feature {WEL_WINDOW_CONSTANTS}.Size_minimized) then
				if internal_child_window /= Void then
					io.putstring ("Resizing internal window : " + a_width.out + " : " + a_height.out + "%N")
					internal_child_window.resize (a_width, a_height)
				end
			end
				-- We cannot call the precursor so we have to implement
				-- here.
			t := resize_actions_internal
			if t /= Void then
				t.call ([screen_x, screen_y, a_width, a_height])
			end
		end

	ev_apply_new_size (a_x_position, a_y_position, a_width, a_height: INTEGER; repaint: BOOLEAN) is
			-- Apply new size to `Current'.
		do
			if internal_child_window /= Void then
				internal_child_window.resize (client_width, client_height)
			end
		end

	process_message (hwnd: POINTER; msg, wparam, lparam: INTEGER): INTEGER is
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
				on_sys_command (wparam, cwin_lo_word (lparam), cwin_hi_word (lparam))
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
				on_palette_is_changing (window_of_item (cwel_integer_to_pointer (wparam)))
			when Wm_palettechanged then
				on_palette_changed (window_of_item (cwel_integer_to_pointer (wparam)))
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

	interface: EV_WEL_CONTAINER
		-- Interface of `Current'.

end -- class EV_WEL_CONTAINER_IMP
