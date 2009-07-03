note
	description: "Eiffel Vision window. Cocoa implementation."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_WINDOW_IMP

inherit
	EV_WINDOW_I
		undefine
			propagate_foreground_color,
			propagate_background_color
		redefine
			interface
		select
			copy
		end

	EV_SINGLE_CHILD_CONTAINER_IMP
		undefine
			x_position,
			y_position,
			screen_x,
			screen_y,
			width,
			height,
			on_key_event,
			destroy,
			client_height,
			client_width,
			show
		redefine
			interface,
			make,
			is_sensitive,
			on_key_event,
			hide,
			destroy,
			has_focus,
			set_minimum_size,
			set_minimum_width,
			set_minimum_height,
			set_top_level_window_imp,
			ev_apply_new_size,
			cocoa_set_size,
			dispose,
			replace
		end

	EV_WINDOW_ACTION_SEQUENCES_IMP
		redefine
			interface
		end

	NS_WINDOW
		rename
			set_background_color as cocoa_set_background_color,
			background_color as cocoa_background_color,
			make as cocoa_make,
			screen as cocoa_screen,
			item as window_item,
			title as cocoa_title,
			set_title as cocoa_set_title,
			copy as cocoa_copy
		redefine
			dispose
		end

	NS_WINDOW_DELEGATE
		rename
			make as create_delegate,
			item as delegate
		redefine
			window_did_resize
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Create the vertical box `vbox' and horizontal box `hbox'
			-- to put in the window.
			-- The `vbox' will be able to contain the menu bar, the `hbox'
			-- and the status bar.
			-- The `hbox' will contain the child of the window.
		do
			cocoa_make (create {NS_RECT}.make_rect (100, 100, 100, 100),
				{NS_WINDOW}.closable_window_mask | {NS_WINDOW}.miniaturizable_window_mask | {NS_WINDOW}.resizable_window_mask, True)
			make_key_and_order_front
			order_out
			allow_resize
			create_delegate

			set_accepts_mouse_moved_events (True)

			set_maximum_width (32000)
			set_maximum_height (32000)
			create accel_list.make (10)

			initialize

			cocoa_view := content_view
			init_bars
--			window := current
			set_delegate (current)
			app_implementation.windows_imp.extend (current)

			internal_is_border_enabled := True
			user_can_resize := True
			set_is_initialized (True)
		end

 	init_bars
 			-- Initialize `lower_bar' and `upper_bar'.
 		local
 			ub_imp, lb_imp: detachable EV_VERTICAL_BOX_IMP
 		do
 			create upper_bar
 			create lower_bar
 			ub_imp ?= upper_bar.implementation
  			lb_imp ?= lower_bar.implementation
  			check
  				ub_imp_not_void: ub_imp /= Void
  				lb_imp_not_void: lb_imp /= Void
  			end
  			ub_imp.on_parented
  			lb_imp.on_parented
  			ub_imp.set_parent_imp (Current)
  			content_view.add_subview (ub_imp.attached_view)
  			lb_imp.set_parent_imp (Current)
  			ub_imp.set_top_level_window_imp (Current)
  			lb_imp.set_top_level_window_imp (Current)
  		end

feature -- Delegate

	window_did_resize
		local
			bar_imp: detachable EV_VERTICAL_BOX_IMP
		do
			if not upper_bar.is_empty then
				bar_imp ?= upper_bar.implementation
				check
					bar_imp_not_void: bar_imp /= Void
				end
				bar_imp.ev_apply_new_size (0, 0, client_width, client_y, True)
			end

			if attached item_imp as l_item_imp then
--				item_imp.set_move_and_size (0, 0,
--					client_width, client_height)
				l_item_imp.ev_apply_new_size (0, client_y, client_width, client_height, True)
			end

			if not lower_bar.is_empty then
				bar_imp ?= lower_bar.implementation
				check
					bar_imp_not_void: bar_imp /= Void
				end
				bar_imp.set_move_and_size (0, client_y + client_height + 1,
					client_width, bar_imp.minimum_height)
			end

				-- Calls user actions if any
			execute_resize_actions (width, height)
			display
		end

	execute_resize_actions (a_width, a_height: INTEGER)
			-- execute `resize_actions_internal' if not Void.
		do
			if resize_actions_internal /= Void then
				resize_actions_internal.call (
					[screen_x, screen_y, a_width, a_height])
			end
		end

feature {EV_ANY_I} -- Implementation

	enable_modal
			-- Set `is_modal' to `True'.
		do
		end

	disable_modal
			-- Set `is_modal' to `False'.
		do
		end

	show_relative_to_window (a_parent: EV_WINDOW)
			-- Show `Current' with respect to `a_parent'.
		do
		end

feature -- Measurement

	ev_apply_new_size (a_x_position, a_y_position, a_width, a_height: INTEGER; repaint: BOOLEAN)
			-- Move the window to `a_x_position', `a_y_position' position and
			-- resize it with `a_width', `a_height'.
			-- This feature must be redefine by the containers to readjust its
			-- children too.
		local
			bar_imp: detachable EV_VERTICAL_BOX_IMP
		do
			ev_move_and_resize (a_x_position, a_y_position, a_width, a_height, repaint)
			if attached item_imp as l_item_imp then
				l_item_imp.ev_apply_new_size (0, client_y, client_width, client_height, True)
			end
			if not upper_bar.is_empty then
				bar_imp ?= upper_bar.implementation
				check
					bar_imp_not_void: bar_imp /= Void
				end
				bar_imp.ev_move_and_resize (0, 0, client_width, client_y, True)
			end
			if not lower_bar.is_empty then
				bar_imp ?= lower_bar.implementation
				check
					bar_imp_not_void: bar_imp /= Void
				end
				bar_imp.ev_move_and_resize (0, client_y + client_height + 1, client_width, bar_imp.minimum_height, True)
			end
		end

	client_height: INTEGER
		do
			Result := content_rect_for_frame_rect (frame).size.height - client_y
--			Result := Precursor {EV_SINGLE_CHILD_CONTAINER_IMP} - client_y
			if not lower_bar.is_empty then
				-- Add 1 pixel to separate client area and lower bar.
				Result := Result - lower_bar.minimum_height - 1
			end
			Result := Result.max (0)
		end

	client_width: INTEGER
		do
			Result := content_rect_for_frame_rect (frame).size.width
		end

 	client_y: INTEGER
 			-- Top of the client area of `Current'.
 		do
 			-- Result := Precursor {EV_SINGLE_CHILD_CONTAINER_IMP}
 			if not upper_bar.is_empty then
 				-- Add 1 pixel to separate client area and upper bar.
 				Result := Result + upper_bar.minimum_height + 1
 			end
 	 		Result := Result.min (height)
 	 	end

	width: INTEGER
			-- Horizontal size measured in pixels.
		do
			Result := frame.size.width
		end

	height: INTEGER
			-- Vertical size measured in pixels.
		do
			Result := frame.size.height
		end

	set_width (a_width: INTEGER)
			-- Set the horizontal size to `a_width'.
		do
			set_size (a_width, height)
		end

	set_height (a_height: INTEGER)
			-- Set the vertical size to `a_height'.
		do
			set_size(width, a_height)
		end

	set_size (a_width, a_height: INTEGER)
			-- Set the horizontal size to `a_width'.
			-- Set the vertical size to `a_height'.
		do
			ev_apply_new_size (x_position, y_position, a_width.max (minimum_width), a_height.max (minimum_height), True)
		end

	x_position, screen_x: INTEGER
			-- X coordinate of `Current'
		do
			Result := frame.origin.x
		end

	y_position, screen_y: INTEGER
			-- Y coordinate of `Current'
		local
			l_frame: NS_RECT
		do
			l_frame := frame
			Result := screen.frame.size.height - l_frame.origin.y - l_frame.size.height
		end

	set_x_position (a_x: INTEGER)
			-- Set horizontal offset to parent to `a_x'.
		do
			set_position (a_x, y_position)
		end

	set_y_position (a_y: INTEGER)
			-- Set vertical offset to parent to `a_y'.
		do
			set_position (x_position, a_y)
		end

	set_position (a_x, a_y: INTEGER)
			-- Set horizontal offset to parent to `a_x'.
			-- Set vertical offset to parent to `a_y'.
		do
			set_frame_top_left_point_flipped (create {NS_POINT}.make_point (a_x, a_y))
		end

	screen: NS_SCREEN
			-- Window coordinates are relative to the main screen
		once
			create Result.main_screen
		end

	set_minimum_size (a_minimum_width, a_minimum_height: INTEGER)
			-- Set the minimum horizontal size to `a_minimum_width'.
			-- Set the minimum vertical size to `a_minimum_height'.
		do
			Precursor {EV_SINGLE_CHILD_CONTAINER_IMP} (a_minimum_width, a_minimum_height)
			if a_minimum_width > width then
				set_width (a_minimum_width)
			end
			if a_minimum_height > height then
				set_height (a_minimum_height)
			end
			set_min_size (a_minimum_width, a_minimum_height)
		end

	set_minimum_height (a_minimum_height: INTEGER)
			-- Set the minimum vertical size to `a_minimum_height'.
		do
			Precursor {EV_SINGLE_CHILD_CONTAINER_IMP} (a_minimum_height)
			if minimum_height > height then
				set_height (minimum_height)
			end
			set_min_size (minimum_width, a_minimum_height)
		end

	set_minimum_width (a_minimum_width: INTEGER)
			-- Set the minimum horizontal size to `a_minimum_width'.
		do
			Precursor {EV_SINGLE_CHILD_CONTAINER_IMP} (a_minimum_width)
			if minimum_width > width then
				set_width (minimum_width)
			end
			set_min_size (a_minimum_width, minimum_height)
		end

 	maximum_width: INTEGER
			-- Maximum width that application wishes widget
			-- instance to have.

	maximum_height: INTEGER
			-- Maximum height that application wishes widget
			-- instance to have.

	set_maximum_width (max_width: INTEGER)
			-- Set `maximum_width' to `max_width'.
		do
			maximum_width := max_width
		end

	set_maximum_height (max_height: INTEGER)
			-- Set `maximum_height' to `max_height'.
		do
			maximum_height := max_height
		end

	cocoa_set_size (a_x_position, a_y_position, a_width, a_height: INTEGER)
			-- The given y-coordinate is in the vision-coordinate system
		do
			set_frame (create {NS_RECT}.make_rect (a_x_position, screen.frame.size.height - a_y_position - a_height, a_width, a_height), True)
		end

feature -- Layout implementation

	compute_minimum_width
			-- Recompute the minimum width of `Current'.
		local
			mw: INTEGER
		do
			mw := 0

			if attached item_imp as l_item_imp and then l_item_imp.is_show_requested then
				mw := mw + l_item_imp.minimum_width
			end
			mw := mw.max (attached_interface.upper_bar.minimum_width).max
				(attached_interface.lower_bar.minimum_width)
			internal_set_minimum_width (mw)
			set_min_size (mw, minimum_height)
		end

	compute_minimum_height
			-- Recompute the minimum height of `Current'.
		local
			mh: INTEGER
		do
			mh := 0
			if not attached_interface.upper_bar.is_empty then
				mh := mh + attached_interface.upper_bar.minimum_height + 1
			end
			if attached item_imp as l_item_imp and then l_item_imp.is_show_requested then
				mh := mh + l_item_imp.minimum_height
			end
			if not attached_interface.lower_bar.is_empty then
				mh := mh + attached_interface.lower_bar.minimum_height + 1
			end
			internal_set_minimum_height (mh)
			set_min_size (minimum_width, mh)
		end

	compute_minimum_size
			-- Recompute the minimum size of `Current'.
		local
			mw, mh: INTEGER
			l_size: NS_SIZE
		do
			mw := 0
			if attached item_imp as l_item_imp and then l_item_imp.is_show_requested then
				mw := mw + l_item_imp.minimum_width
			end
			mw := mw.max (attached_interface.upper_bar.minimum_width).max
				(attached_interface.lower_bar.minimum_width)

			mh := 0
			if not attached_interface.upper_bar.is_empty then
				mh := mh + attached_interface.upper_bar.minimum_height + 1
			end
			if attached item_imp as l_item_imp and then l_item_imp.is_show_requested then
				mh := mh + l_item_imp.minimum_height
			end
			if not attached_interface.lower_bar.is_empty then
				mh := mh + attached_interface.lower_bar.minimum_height + 1
			end
			l_size := frame_rect_for_content_rect (create {NS_RECT}.make_rect (0, 0, mw, mh)).size
			internal_set_minimum_size (l_size.width, l_size.height)
			set_content_min_size(mw, mh)
		end

feature -- Widget relations

	top_level_window_imp: detachable EV_WINDOW_IMP
			-- Top level window that contains `Current'.
			-- As `Current' is a window then we return `Current'
		do
			Result := Current
		end

	set_top_level_window_imp (a_window: detachable EV_WINDOW_IMP)
			-- Make `a_window' the new `top_level_window_imp'
			-- of `Current'.
		do
			--| This should never be called for a window.
			check
				inapplicable: False
			end
		end

feature  -- Access

	is_sensitive: BOOLEAN
			--
		do
			Result := True
		end

	has_focus: BOOLEAN
			-- Does `Current' have the keyboard focus?
		do
		end

	count: INTEGER_32
			-- Number of elements in `Current'.	
		do
			if item /= Void then
				Result := 1
			end
		end

	menu_bar: detachable EV_MENU_BAR
			-- FIXME Mac Issue: Menu-Bars are Application-wide
			-- Horizontal bar at top of client area that contains menu's.

feature -- Status setting

	disconnect_accelerator (an_accel: EV_ACCELERATOR)
			-- Disconnect key combination `an_accel' from this window.
		do
		end

	connect_accelerator (an_accel: EV_ACCELERATOR)
			-- Disconnect key combination `an_accel' from this window.
		do
		end

	internal_disable_border
			-- Ensure no border is displayed around `Current'.
		local
			l_content_view: NS_VIEW
		do
			l_content_view := content_view
			-- Recreate the Cocoa window, because changing the style mask is not supported
			cocoa_make (frame,
				{NS_WINDOW}.borderless_window_mask, True)
			set_content_view (l_content_view)
		end

	internal_enable_border
			-- Ensure a border is displayed around `Current'.
		local
			l_content_view: NS_VIEW
		do
			l_content_view := content_view
			-- Recreate the Cocoa window, because changing the style mask is not supported
			cocoa_make (frame,
				{NS_WINDOW}.closable_window_mask | {NS_WINDOW}.miniaturizable_window_mask | {NS_WINDOW}.resizable_window_mask, True)
			set_content_view (l_content_view)
		end

	block
			-- Wait until window is closed by the user.
		local
			app: EV_APPLICATION_IMP
		do
			from
				app := app_implementation
			until
				is_destroyed or else not is_displayed
			loop
				app.process_events
			end
		end

	disable_user_resize
			-- Forbid the resize of the window.
		do
			user_can_resize := False
			forbid_resize
		end

	enable_user_resize
			-- Allow the resize of the window.
		do
			user_can_resize := True
			allow_resize
		end

	forbid_resize
			-- Forbid the resize of `Current'.
		do
			set_shows_resize_indicator (False)
			standdard_window_button ({NS_WINDOW}.window_zoom_button).set_enabled (False)
		end

	allow_resize
			-- Allow the resize of `Current'.
		do
			set_shows_resize_indicator (True)
			standdard_window_button ({NS_WINDOW}.window_zoom_button).set_enabled (True)
		end

	show
		do
			-- FIXME: only do this stuff when the window was not displayed before
			is_show_requested := True
			if show_actions_internal /= Void then
				show_actions_internal.call (Void)
			end
			make_key_and_order_front
			notify_change (nc_minsize, item_imp)
		end

	hide
			-- Unmap the Window from the screen.
		do
			order_out
			--is_show_requested := False
		end

	set_title (a_title: STRING_GENERAL)
			-- <Precursor>
		do
			cocoa_set_title (create {NS_STRING}.make_with_string (a_title))
			internal_title := a_title.as_string_32
		end

	title: STRING_32
			-- <Precursor>-
		do
			if attached internal_title as l_title then
				Result := l_title.twin
			else
				create Result.make_empty
			end
		end

	internal_title: detachable STRING_32

feature -- Element change

	replace (v: like item)
			-- Replace `item' with `v'.
		local
			v_imp: detachable EV_WIDGET_IMP
		do
			-- Remove current item, if any
			if attached item as l_item then
				remove_item_actions.call ([l_item])
				v_imp ?= l_item.implementation
				check
					item_has_implementation: v_imp /= Void
				end
				v_imp.set_parent_imp (Void)
				notify_change (Nc_minsize, Current)
			end
			-- Insert new item, if any
			if attached v as l_v then
				v_imp ?= l_v.implementation
				check
					v_has_implementation: v_imp /= Void
				end
				content_view.add_subview (v_imp.attached_view)
				v_imp.set_parent_imp (Current)
				notify_change (Nc_minsize, Current)
			end
			item := v
		end

	set_menu_bar (a_menu_bar: EV_MENU_BAR)
			-- Set `menu_bar' to `a_menu_bar'.
		local
			mb_imp: detachable EV_MENU_BAR_IMP
			menu: NS_MENU
		do
			menu_bar := a_menu_bar
			mb_imp ?= a_menu_bar.implementation
			check mb_imp /= Void end
			mb_imp.set_parent_window_imp (Current)

			-- TODO attach the menubar to the current window / application in cocoa and switch on window switch
			menu := mb_imp.menu
			menu.insert_item_at_index (app_implementation.default_application_menu, 0)

			app_implementation.set_main_menu (menu)
		end

	remove_menu_bar
			-- Set `menu_bar' to `Void'.
		local
			mb_imp: detachable EV_MENU_BAR_IMP
		do
			if attached menu_bar as l_menu_bar then
				mb_imp ?= l_menu_bar.implementation
				check mb_imp /= Void end
				mb_imp.remove_parent_window
				-- TODO: remove the menubar in cocoa
			end
			menu_bar := Void
		end

feature {EV_ANY_IMP} -- Implementation

	destroy
			-- Destroy `Current'
		do
			disable_capture
			hide
			app_implementation.windows_imp.start
			app_implementation.windows_imp.prune (current)
			Precursor {EV_SINGLE_CHILD_CONTAINER_IMP}
		end

	dispose
		do
			Precursor {EV_SINGLE_CHILD_CONTAINER_IMP}
			Precursor {NS_WINDOW}
		end

feature {NONE} -- Implementation

	set_focused_widget (a_widget: EV_WIDGET_IMP)
			-- Set currently focused widget to `a_widget'.
		do
		end

	on_key_event (a_key: EV_KEY; a_key_string: STRING_32; a_key_press: BOOLEAN)
			-- Used for key event actions sequences.
		do
		end

feature {EV_INTERMEDIARY_ROUTINES}

	call_close_request_actions
			-- Call the close request actions.
		do
			close_request_actions.call ([])
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_WINDOW note option: stable attribute end;
		-- Interface object of `Current'

end -- class EV_WINDOW_IMP
