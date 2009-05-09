note
	description: "Eiffel Vision window. Cocoa implementation."

class
	EV_WINDOW_IMP

inherit
	EV_WINDOW_I
		undefine
			propagate_foreground_color,
			propagate_background_color
		redefine
			interface
		end

	EV_CONTAINER_IMP
		undefine
			x_position,
			y_position,
			screen_x,
			screen_y,
			width,
			height,
			on_key_event,
			initialize,
			destroy,
			client_height,
			client_width,
			show
		redefine
			interface,
			initialize,
			is_sensitive,
			make,
			on_key_event,
			hide,
			destroy,
			has_focus,
			on_focus_changed,
			set_minimum_size,
			set_minimum_width,
			set_minimum_height,
			set_top_level_window_imp,
			ev_apply_new_size,
			cocoa_set_size
		end

	EV_WINDOW_ACTION_SEQUENCES_IMP
		redefine
			interface
		end

	NS_WINDOW_DELEGATE
		rename
			new as new_delegate,
			cocoa_object as delegate
		redefine
			window_did_resize
		end
create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface)
			-- Create the window.
		do
			base_make (an_interface)
			create {NS_WINDOW}cocoa_item.init_with_control_rect_style_mask_backing_defer (create {NS_RECT}.make_rect (100, 100, 100, 100),
				{NS_WINDOW}.closable_window_mask.bit_or ({NS_WINDOW}.miniaturizable_window_mask).bit_or ({NS_WINDOW}.resizable_window_mask), True)
			window.make_key_and_order_front
			window.order_out
			allow_resize
			new_delegate
			window.set_delegate (current)
		end

	initialize
			-- Create the vertical box `vbox' and horizontal box `hbox'
			-- to put in the window.
			-- The `vbox' will be able to contain the menu bar, the `hbox'
			-- and the status bar.
			-- The `hbox' will contain the child of the window.
		do
			create upper_bar
			create lower_bar

			maximum_width := interface.maximum_dimension
			maximum_height := interface.maximum_dimension

			app_implementation.windows.extend (interface)

			Precursor {EV_CONTAINER_IMP}

			internal_is_border_enabled := True
			user_can_resize := True
			set_is_initialized (True)
		end

feature -- Delegate

	window_did_resize
		local
			bar_imp: EV_VERTICAL_BOX_IMP
		do
			if not interface.upper_bar.is_empty then
				bar_imp ?= interface.upper_bar.implementation
				check
					bar_imp_not_void: bar_imp /= Void
				end
				bar_imp.set_move_and_size (0, 0, client_width, 0)
			end

			if item /= Void then
--				item_imp.set_move_and_size (0, 0,
--					client_width, client_height)
				item_imp.ev_apply_new_size (0, 0, client_width, client_height, True)
			end

			if not interface.lower_bar.is_empty then
				bar_imp ?= interface.lower_bar.implementation
				check
					bar_imp_not_void: bar_imp /= Void
				end
				bar_imp.set_move_and_size (0,
					client_height + 1,
					client_width, bar_imp.minimum_height)
			end

				-- Calls user actions if any
			execute_resize_actions (width, height)
			window.display
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
			bar_imp: EV_VERTICAL_BOX_IMP
		do
			ev_move_and_resize (a_x_position, a_y_position, a_width, a_height, repaint)
			if item /= Void then
				item_imp.ev_apply_new_size (0, 0,
											client_width, client_height, True)
			end
			if not interface.upper_bar.is_empty then
				bar_imp ?= interface.upper_bar.implementation
				check
					bar_imp_not_void: bar_imp /= Void
				end
				bar_imp.ev_move_and_resize (0, 0, client_width, 0, True)
			end
			if not interface.lower_bar.is_empty then
				bar_imp ?= interface.lower_bar.implementation
				check
					bar_imp_not_void: bar_imp /= Void
				end
				bar_imp.ev_move_and_resize (0,
					client_height + 1,
					client_width, bar_imp.minimum_height, True)
			end
		end

	client_height: INTEGER
		do
			Result := window.content_rect_for_frame_rect (window.frame).size.height
		end

	client_width: INTEGER
		do
			Result := window.content_rect_for_frame_rect (window.frame).size.width
		end


	width: INTEGER
			-- Horizontal size measured in pixels.
		do
			Result := window.frame.size.width
		end

	height: INTEGER
			-- Vertical size measured in pixels.
		do
			Result := window.frame.size.height
		end

	set_width (a_width: INTEGER)
			-- Set the horizontal size to `a_width'.
		do
			set_size(a_width, height)
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
			Result := window.frame.origin.x
		end

	y_position, screen_y: INTEGER
			-- Y coordinate of `Current'
		local
			l_frame: NS_RECT
		do
			l_frame := window.frame
			Result := window.screen.frame.size.height - l_frame.origin.y - l_frame.size.height
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
			window.set_frame (create {NS_RECT}.make_rect(a_x, window.screen.frame.size.height - a_y, width, height))
		end

	set_minimum_size (a_minimum_width, a_minimum_height: INTEGER)
			-- Set the minimum horizontal size to `a_minimum_width'.
			-- Set the minimum vertical size to `a_minimum_height'.
		do
			Precursor {EV_CONTAINER_IMP} (a_minimum_width, a_minimum_height)
			if a_minimum_width > width then
				set_width (a_minimum_width)
			end
			if a_minimum_height > height then
				set_height (a_minimum_height)
			end
			window.set_min_size(a_minimum_width, a_minimum_height)
		end

	set_minimum_height (a_minimum_height: INTEGER)
			-- Set the minimum vertical size to `a_minimum_height'.
		do
			Precursor {EV_CONTAINER_IMP} (a_minimum_height)
			if minimum_height > height then
				set_height (minimum_height)
			end
			window.set_min_size(minimum_width, a_minimum_height)
		end

	set_minimum_width (a_minimum_width: INTEGER)
			-- Set the minimum horizontal size to `a_minimum_width'.
		do
			Precursor {EV_CONTAINER_IMP} (a_minimum_width)
			if minimum_width > width then
				set_width (minimum_width)
			end
			window.set_min_size(a_minimum_width, minimum_height)
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
		do

			window.set_frame (create {NS_RECT}.make_rect(a_x_position, a_y_position, a_width, a_height))
		end

feature -- Layout implementation

	compute_minimum_width
			-- Recompute the minimum width of `Current'.
		local
			mw: INTEGER
		do
			mw := 0

			if item_imp /= Void and item_imp.is_show_requested then
				mw := mw + item_imp.minimum_width
			end
			mw := mw.max (interface.upper_bar.minimum_width).max
				(interface.lower_bar.minimum_width)
			internal_set_minimum_width (mw)
			window.set_min_size(mw, minimum_height)
		end

	compute_minimum_height
			-- Recompute the minimum height of `Current'.
		local
			mh: INTEGER
		do
			mh := 0
			if not interface.upper_bar.is_empty then
				mh := mh + interface.upper_bar.minimum_height + 1
			end
			if item_imp /= Void and item_imp.is_show_requested then
				mh := mh + item_imp.minimum_height
			end
			if not interface.lower_bar.is_empty then
				mh := mh + interface.lower_bar.minimum_height + 1
			end
			internal_set_minimum_height (mh)
			window.set_min_size(minimum_width, mh)
		end

	compute_minimum_size
			-- Recompute the minimum size of `Current'.
		local
			mw, mh: INTEGER
			l_size: NS_SIZE
		do
			mw := 0
			if item_imp /= Void and item_imp.is_show_requested then
				mw := mw + item_imp.minimum_width
			end
			mw := mw.max (interface.upper_bar.minimum_width).max
				(interface.lower_bar.minimum_width)

			mh := 0
			if not interface.upper_bar.is_empty then
				mh := mh + interface.upper_bar.minimum_height + 1
			end
			if item_imp /= Void then
				mh := mh + item_imp.minimum_height
			end
			if not interface.lower_bar.is_empty then
				mh := mh + interface.lower_bar.minimum_height + 1
			end
			l_size := window.frame_rect_for_content_rect (create {NS_RECT}.make_rect (0, 0, mw, mh)).size
			internal_set_minimum_size (l_size.width, l_size.height)
			window.set_content_min_size(mw, mh)
		end

feature -- Widget relations

	top_level_window_imp: EV_WINDOW_IMP
			-- Top level window that contains `Current'.
			-- As `Current' is a window then we return `Current'
		do
			Result := Current
		end

	set_top_level_window_imp (a_window: EV_TITLED_WINDOW_IMP)
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

	item: EV_WIDGET
			-- Current item.

	title: STRING_32
			-- Application name to be displayed by the window manager.
		do
			Result := window.title.as_string_32
		end

	menu_bar: EV_MENU_BAR
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
		do
		end

	internal_enable_border
			-- Ensure a border is displayed around `Current'.
		do
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
			window.set_shows_resize_indicator (False)
		end

	allow_resize
			-- Allow the resize of `Current'.
		do
			window.set_shows_resize_indicator (True)
		end

	show
		do
			-- FIXME: only do this stuff when the window was not displayed before
			if show_actions_internal /= Void then
				show_actions_internal.call (Void)
			end
			window.make_key_and_order_front
			notify_change (nc_minsize, item_imp)
		end

	hide
			-- Unmap the Window from the screen.
		do
			window.order_out
		end

feature -- Element change

	on_attach: ACTION_SEQUENCE [TUPLE]

	replace (v: like item)
			-- Replace `item' with `v'.
		local
			w_imp: EV_WIDGET_IMP
		do
			-- Remove current item, if any
			if item /= Void then
				w_imp ?= item.implementation
				check
					item_has_implementation: w_imp /= Void
				end
				on_removed_item ( w_imp )
			end
			-- Insert new item, if any
			if v /= Void then
				w_imp ?= v.implementation
				check
					v_has_implementation: w_imp /= Void
				end
				window.set_content_view (w_imp.cocoa_view)
				on_new_item ( w_imp )
				notify_change (nc_minsize, Current)
			end
			item := v
		end

	set_title (new_title: STRING_GENERAL)
			-- Set `title' to `new_title'.
		do
			window.set_title (new_title)
		end

	set_menu_bar (a_menu_bar: EV_MENU_BAR)
			-- Set `menu_bar' to `a_menu_bar'.
		local
			mb_imp: EV_MENU_BAR_IMP
		do
			menu_bar := a_menu_bar
			mb_imp ?= menu_bar.implementation
			mb_imp.set_parent_window_imp (Current)

			-- TODO attach the menubar to the current window / application in cocoa and switch on window switch
			app_implementation.application.set_main_menu (mb_imp.menu)
			app_implementation.application.fix_apple_menu
		end

	remove_menu_bar
			-- Set `menu_bar' to `Void'.
		local
			mb_imp: EV_MENU_BAR_IMP
		do
			if menu_bar /= Void then
				mb_imp ?= menu_bar.implementation
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
			Precursor {EV_CONTAINER_IMP}
		end

feature {NONE} -- Implementation

	set_focused_widget (a_widget: EV_WIDGET_IMP)
			-- Set currently focused widget to `a_widget'.
		do
		end

	on_focus_changed (a_has_focus: BOOLEAN)
			-- Called from focus intermediary agents when focus for `Current' has changed.
			-- if `a_has_focus' then `Current' has just received focus.
		do
			Precursor {EV_CONTAINER_IMP} (a_has_focus)
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

feature {EV_ANY_I, LAYOUT_INSPECTOR} -- Implementation

	interface: EV_WINDOW;
		-- Interface object of `Current'

	window: NS_WINDOW
			--
		do
			Result ?= cocoa_item
		end

note
	copyright:	"Copyright (c) 2009, Daniel Furrer"
end -- class EV_WINDOW_IMP

